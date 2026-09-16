#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
lyrics_tool.py
================
lyrics_dev 照合プロジェクト用の統合ツール(1ファイル版)。
サブコマンドで機能を切り替える。

【サブコマンド一覧】
  fetch-false      Supabaseからfalselyricを取得
  fetch-true       uta-netからtruelyricを取得
  export-rendered  レコードを表示形式に組み立ててtxt出力    (ルートA・1/2)
  build-sql        編集済みrenderedからSQLを再構築          (ルートA・2/2)
  export-byrecord  [id]タグ付きでレコードを出力             (ルートB・1/2)
  apply-byrecord   編集済みbyrecordからSQLを生成            (ルートB・2/2)
  export-quoted    ダブルクォート形式でレコードを出力       (ルートC・1/2)
  apply-quoted     編集済みquotedからSQLを生成              (ルートC・2/2)
  check            自動対応付けレポートを表示(検証用)

各サブコマンドの詳しい使い方は `-h` を付けて確認してください。
例: python lyrics_tool.py export-rendered -h

【3つの編集ルート】
  A: 空白・改行の位置だけ直す(文言は変えない前提。最も安全・自動化率が高い)
  B: 文言そのものを直す([id]タグで対応関係を明示。手間はかかるが確実)
  C: 文言そのものを直す(タグなし、id昇順のブロックで対応関係を暗黙的に特定)

【前提】
- レコード数・IDは絶対に増減させない
- スペースは常に半角(U+0020)として扱う(全角には変換しない)
- 全角/半角括弧の違いは検証対象外(意図的なDB側の使い分けのため)
"""

import argparse
import csv
import difflib
import io
import itertools
import json
import os
import re
import sys
import urllib.request
import urllib.error
from collections import defaultdict, OrderedDict
from typing import Dict, List, Optional, Tuple


# =========================================================================
# 共通設定
# =========================================================================
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "lyric_data")
URLS_TXT_PATH = os.path.join(SCRIPT_DIR, "URLs.txt")

# ---- Supabase接続情報(自分のプロジェクトのものに書き換えて使うこと) ----
SUPABASE_URL = "https://atinpqtedmrfrtdlkpkd.supabase.co"
SUPABASE_KEY = "sb_publishable_SWT3WgKAN77Ujv_lbDSppg_gmedWl64"
SUPABASE_TABLE = "lyrics_dev"
SUPABASE_COLUMNS = ["id", "sounds_id", "seq", "section_name", "lyric",
                    "occurrence", "lyric_col", "col_space", "is_active"]

SPACE = {'half': '\u0020', 'full': '\u3000', '': '', None: ''}
SPACE_CANDIDATES = ['', '\u0020', '\u3000']  # ''=なし, 半角, 全角


# =========================================================================
# 共通ヘルパー: id指定のパース(単体/カンマ区切り/範囲)
# =========================================================================
def parse_id_spec(spec: str) -> List[int]:
    """"16" / "16,17,18" / "16-20" / "16,17,20-23" を整数リストに展開する。"""
    ids: List[int] = []
    try:
        for part in spec.split(","):
            part = part.strip()
            if not part:
                continue
            if "-" in part:
                a, b = part.split("-", 1)
                ids.extend(range(int(a), int(b) + 1))
            else:
                ids.append(int(part))
    except ValueError:
        print(f"[ERROR] ID指定の形式が正しくありません: {spec!r} (例: 16 / 16,17,18 / 16-20)")
        sys.exit(1)
    return ids


def load_urls_txt() -> Dict[int, Dict[str, Optional[str]]]:
    """
    URLs.txt (No. / アーティスト / 曲名 / 歌ネットURL のタブ区切り) を読み、
    {No(int): {"artist":..., "song_name":..., "url":... or None}} を返す。
    URLが「該当なし」の行は url=None にする。
    """
    if not os.path.exists(URLS_TXT_PATH):
        print(f"[ERROR] URLs.txt が見つかりません: {URLS_TXT_PATH}")
        sys.exit(1)
    result = {}
    with open(URLS_TXT_PATH, encoding="utf-8", newline="") as f:
        reader = csv.reader(f, delimiter="\t")
        rows = list(reader)
    header = rows[0]
    for row in rows[1:]:
        if not row or not row[0].strip():
            continue
        d = dict(zip(header, row))
        try:
            no = int(d.get("No.", "").strip())
        except ValueError:
            continue
        url = d.get("歌ネットURL", "").strip()
        result[no] = {
            "artist": d.get("アーティスト", "").strip(),
            "song_name": d.get("曲名", "").strip(),
            "url": None if (url == "" or url == "該当なし") else url,
        }
    return result


def extract_song_id(arg: str) -> str:
    m = re.search(r"/song/(\d+)/?", arg)
    if m:
        return m.group(1)
    if arg.isdigit():
        return arg
    raise ValueError(f"曲IDを特定できませんでした: {arg}")


def tag_from_filename(path: str, prefix: str) -> str:
    """
    "f18.txt" のような短いファイル名から、prefix("f")を取り除いた
    残りの部分("18")を返す。旧形式("falselyric_18.txt")にも一応対応する。
    """
    base = os.path.splitext(os.path.basename(path))[0]
    if base.startswith(prefix + "_"):
        return base[len(prefix) + 1:]
    if base.startswith(prefix):
        return base[len(prefix):]
    return base


def find_falselyric_for(edited_path: str) -> str:
    """
    br18.txt / q18.txt のようなファイル名から番号(タグ)を取り出し、
    同じフォルダにある f<タグ>.txt を自動で探して返す。
    見つからなければエラーで終了する。
    """
    base = os.path.splitext(os.path.basename(edited_path))[0]
    m = re.match(r'^(?:br|q|r)(\w+)$', base)
    if not m:
        print(f"[ERROR] ファイル名からタグを特定できませんでした: {edited_path}")
        print("        falselyricファイルを明示的に指定してください。")
        sys.exit(1)
    tag = m.group(1)
    candidate = os.path.join(os.path.dirname(edited_path) or ".", f"f{tag}.txt")
    if not os.path.exists(candidate):
        print(f"[ERROR] 元のfalselyricファイルが見つかりません: {candidate}")
        print("        falselyricファイルを明示的に指定してください。")
        sys.exit(1)
    return candidate


# =========================================================================
# 共通ローダー: falselyric(TSV)/ true(HTML・テキスト) / 編集後ファイル
# =========================================================================
def load_falselyric(path: str) -> List[Dict]:
    with open(path, encoding='utf-8', newline='') as f:
        reader = csv.reader(f, delimiter='\t', quotechar='"')
        rows = list(reader)
    header = rows[0]
    records = []
    for r in rows[1:]:
        d = dict(zip(header, r))
        d['lyric'] = d['lyric'].replace('\r\n', '\n').replace('\r', '\n')
        records.append({
            'id': d.get('id', ''),
            'seq': d.get('seq', ''),
            'lyric': d['lyric'],
            'occurrence': d.get('occurrence', ''),
            'lyric_col': d.get('lyric_col', ''),
            'col_space': d.get('col_space', ''),
        })
    return records


def load_lines(path: str) -> List[str]:
    """rendered/target系の、素のテキスト行を読む(空行は除く)。"""
    with open(path, encoding='utf-8') as f:
        return [l.rstrip('\n') for l in f if l.strip('\n') != '']


def load_true_any(path: str) -> List[str]:
    """生HTML(kashi_area)なら parse_true_html、それ以外は parse_true_text。"""
    with open(path, encoding='utf-8') as f:
        content = f.read()
    if '<div' in content and 'kashi_area' in content:
        return parse_true_html(content, br_pattern=r'<br\s*/?>')
    return parse_true_text(content)


# =========================================================================
# コアロジック: true側テキスト整形
# =========================================================================
def parse_true_html(html: str, br_pattern: str = r'<br\s*/?>') -> List[str]:
    """kashi_area等の生HTMLからプレーンテキストの行リストを作る。"""
    inner = html
    m = re.search(r'<div[^>]*>(.*)</div>\s*$', html, re.S)
    if m:
        inner = m.group(1)
    inner = re.sub(r'</div>\s*<div[^>]*>', '<br>', inner)
    inner = re.sub(r'</?div[^>]*>', '', inner)
    lines_raw = re.split(br_pattern, inner)
    lines = []
    for l in lines_raw:
        text = re.sub(r'<[^>]+>', '', l)
        text = text.strip()
        if text:
            lines.append(text)
    return lines


def parse_true_text(text: str) -> List[str]:
    """改行区切りテキスト(空行はスタンザ区切り)から行リストを作る。"""
    lines = [l.rstrip() for l in text.split('\n')]
    return [l for l in lines if l.strip() != '']


# =========================================================================
# コアロジック: レンダリング(lyric_col/col_space 反映)
# =========================================================================
def render(records: List[Dict]) -> List[Dict]:
    units = []
    i, n = 0, len(records)
    while i < n:
        rec = records[i]
        col = (rec.get('lyric_col') or '')
        cs = (rec.get('col_space') or '')

        if col == '':
            for line in rec['lyric'].split('\n'):
                units.append({'text': line, 'ids': [rec['id']]})
            i += 1
            continue

        if col == '1' and cs == 'insert':
            pieces = []
            j = i + 1
            while j < n and (records[j].get('lyric_col') or '') not in ('', '1'):
                pieces.append(records[j])
                j += 1
            plain_text = rec['lyric'].replace('##', '\u3000')
            units.append({
                'text': plain_text,
                'ids': [rec['id']] + [p['id'] for p in pieces],
                'note': 'insert-mode: ##は全角スペース化、挿入レコードはプレーン比較対象外',
            })
            i = j
            continue

        if col == '1':
            pieces = [rec]
            j = i + 1
            while j < n and (records[j].get('lyric_col') or '') not in ('', '1'):
                pieces.append(records[j])
                j += 1
            text = ''
            ids = []
            for k, p in enumerate(pieces):
                text += p['lyric']
                ids.append(p['id'])
                if k < len(pieces) - 1:
                    text += SPACE.get(p.get('col_space') or '', '')
            units.append({'text': text, 'ids': ids})
            i = j
            continue

        units.append({'text': rec['lyric'], 'ids': [rec['id']], 'note': 'WARNING: 先頭colなしで出現'})
        i += 1

    return units


def flatten_atomic(records: List[Dict]) -> List[Dict]:
    """lyric_colを無視し、\nだけで分割した原子的な行のリストを返す(suggest_alignment用)。"""
    atoms = []
    i, n = 0, len(records)
    while i < n:
        rec = records[i]
        col = (rec.get('lyric_col') or '')
        cs = (rec.get('col_space') or '')
        if col == '1' and cs == 'insert':
            pieces = []
            j = i + 1
            while j < n and (records[j].get('lyric_col') or '') not in ('', '1'):
                pieces.append(records[j])
                j += 1
            atoms.append({
                'text': rec['lyric'].replace('##', '\u3000'),
                'ids': [rec['id']] + [p['id'] for p in pieces],
                'insert_mode': True,
                'insert_records': [rec] + pieces,
            })
            i = j
            continue
        for line in rec['lyric'].split('\n'):
            atoms.append({'text': line, 'ids': [rec['id']]})
        i += 1
    return atoms


def _flatten_by_record(records: List[Dict]) -> List[Dict]:
    """reconstruct_from_edited専用。レコード1件(または insertグループ)を1単位で返す。"""
    units = []
    i, n = 0, len(records)
    while i < n:
        rec = records[i]
        col = (rec.get('lyric_col') or '')
        cs = (rec.get('col_space') or '')
        if col == '1' and cs == 'insert':
            pieces = []
            j = i + 1
            while j < n and (records[j].get('lyric_col') or '') not in ('', '1'):
                pieces.append(records[j])
                j += 1
            units.append({
                'text': rec['lyric'].replace('##', '\u3000'),
                'ids': [rec['id']] + [p['id'] for p in pieces],
                'insert_mode': True,
            })
            i = j
            continue
        units.append({'text': rec['lyric'], 'ids': [rec['id']]})
        i += 1
    return units


_STRIP_CHARS_RE = re.compile(
    r'[\s\u3000　、。！!？?…‥・\-—―~〜～"\'"\'（）()「」『』]'
)
_TRAILING_PUNCT_RE = re.compile(
    r'[、。！!？?…‥・\-—―~〜～"\'"\'（）()「」『』]'
)


def _extend_trailing_punct(unit_text: str, end_orig: int, global_text: str) -> int:
    trail = 0
    for ch in reversed(unit_text):
        if _TRAILING_PUNCT_RE.match(ch):
            trail += 1
        else:
            break
    extended = end_orig
    count = 0
    while count < trail and extended < len(global_text) and _TRAILING_PUNCT_RE.match(global_text[extended]):
        extended += 1
        count += 1
    return extended


def _normalize(s: str) -> str:
    return _STRIP_CHARS_RE.sub('', s).lower()


def _try_join_with_spaces(pieces: List[str], target: str) -> Optional[List[str]]:
    n = len(pieces)
    if n <= 1:
        return [] if ''.join(pieces) == target else None
    if n > 5:
        return None
    for combo in itertools.product(SPACE_CANDIDATES, repeat=n - 1):
        text = pieces[0]
        for sep, p in zip(combo, pieces[1:]):
            text += sep + p
        if text == target:
            return list(combo)
    return None


# =========================================================================
# コアロジック: 自動対応付け(check用)
# =========================================================================
def suggest_alignment(records: List[Dict], true_lines: List[str]) -> List[Dict]:
    atoms = flatten_atomic(records)
    norm_atoms = [_normalize(a['text']) for a in atoms]
    norm_true = [_normalize(t) for t in true_lines]

    sm = difflib.SequenceMatcher(None, norm_atoms, norm_true, autojunk=False)
    blocks = []

    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        a_slice = atoms[i1:i2]
        t_slice = true_lines[j1:j2]

        if tag == 'equal':
            for a, t in zip(a_slice, t_slice):
                blocks.append({
                    'kind': 'match' if a['text'] == t else 'match_format_diff',
                    'atoms': [a],
                    'true': [t],
                    'detail': {} if a['text'] == t else {'got': a['text'], 'expected': t},
                })
            continue

        n_a, n_t = len(a_slice), len(t_slice)

        if n_a >= 1 and n_t == 1:
            target = t_slice[0]
            pieces = [a['text'] for a in a_slice]
            seps = _try_join_with_spaces(pieces, target)
            blocks.append({
                'kind': 'merge_suggestion',
                'atoms': a_slice,
                'true': t_slice,
                'detail': {'auto_resolved': seps is not None, 'separators': seps},
            })
            continue

        if n_a == 1 and n_t > 1:
            blocks.append({
                'kind': 'split_needed',
                'atoms': a_slice,
                'true': t_slice,
                'detail': {'note': '1レコード内を複数行に分割する必要がある可能性。手動確認。'},
            })
            continue

        blocks.append({
            'kind': 'content_mismatch',
            'atoms': a_slice,
            'true': t_slice,
            'detail': {'note': 'DBとtrueの対応が取れない範囲。内容差分の疑いあり、要確認。'},
        })

    return blocks


def print_alignment_report(blocks: List[Dict]) -> None:
    match_count = sum(1 for b in blocks if b['kind'] == 'match')
    print(f"[match] 完全一致: {match_count}件 (詳細は省略)")

    for b in blocks:
        if b['kind'] == 'match':
            continue
        ids = [a['ids'][0] for a in b['atoms']]
        if b['kind'] == 'match_format_diff':
            print(f"[format_diff] ids={ids}")
            print(f"    got     : {b['detail']['got']!r}")
            print(f"    expected: {b['detail']['expected']!r}")
        elif b['kind'] == 'merge_suggestion':
            resolved = b['detail']['auto_resolved']
            mark = '[merge:自動解決]' if resolved else '[merge:要確認]'
            print(f"{mark} ids={ids}")
            print(f"    atoms   : {[a['text'] for a in b['atoms']]}")
            print(f"    true    : {b['true']}")
            if resolved:
                print(f"    seps    : {b['detail']['separators']}")
        elif b['kind'] == 'split_needed':
            print(f"[split:要確認] ids={ids}")
            print(f"    atom    : {b['atoms'][0]['text']!r}")
            print(f"    true    : {b['true']}")
        elif b['kind'] == 'content_mismatch':
            print(f"[content_mismatch:要確認] ids={ids}")
            print(f"    atoms   : {[a['text'] for a in b['atoms']]}")
            print(f"    true    : {b['true']}")


def diff_against_true(units: List[Dict], true_lines: List[str]):
    mismatches = []
    n = max(len(units), len(true_lines))
    for idx in range(n):
        u = units[idx] if idx < len(units) else None
        t = true_lines[idx] if idx < len(true_lines) else None
        got = u['text'] if u else None
        if got != t:
            mismatches.append((idx, got, t, u['ids'] if u else []))
    return mismatches


def print_diff_report(mismatches) -> None:
    if not mismatches:
        print("[OK] 完全一致 (差分0件)")
        return
    print(f"[NG] 差分 {len(mismatches)} 件")
    for idx, got, expected, ids in mismatches:
        print(f"  --- line {idx}  ids={ids}")
        print(f"    got     : {got!r}")
        print(f"    expected: {expected!r}")


# =========================================================================
# コアロジック: 手動編集した表示形式テキストからの再構築(ルートA)
# =========================================================================
def reconstruct_from_edited(records: List[Dict], target_lines: List[str]) -> Tuple[List[Dict], List[Dict]]:
    """
    前提: 各レコードのlyric本文の「文言」自体は編集していない(空白・改行の
    位置だけを変えている)。この前提のもとで、各レコードの文字列がtarget_lines
    の中に順番通りそのまま登場するかを検証しながら、実際の文字範囲(スパン)を
    特定し、lyric/lyric_col/col_spaceを再構築する。
    """
    units = _flatten_by_record(records)

    global_text = '\n'.join(target_lines)
    norm_chars = []
    orig_idx = []
    for idx, ch in enumerate(global_text):
        if _STRIP_CHARS_RE.match(ch):
            continue
        norm_chars.append(ch.lower())
        orig_idx.append(idx)
    norm_global = ''.join(norm_chars)

    problems: List[Dict] = []
    pos = 0
    spans: List[Optional[Tuple[int, int]]] = []
    LOOKAHEAD = 400
    i = 0
    n_units = len(units)
    while i < n_units:
        unit = units[i]
        norm_u = _normalize(unit['text'])
        L = len(norm_u)

        if norm_global[pos:pos + L] == norm_u:
            if L == 0:
                start_orig = orig_idx[pos] if pos < len(orig_idx) else len(global_text)
                spans.append((start_orig, start_orig))
            else:
                start_orig = orig_idx[pos]
                end_orig = orig_idx[pos + L - 1] + 1
                end_orig = _extend_trailing_punct(unit['text'], end_orig, global_text)
                spans.append((start_orig, end_orig))
            pos += L
            i += 1
            continue

        window = norm_global[pos:pos + LOOKAHEAD]
        found_at = window.find(norm_u) if L > 0 else -1

        skip_matches = False
        if i + 1 < n_units:
            next_norm = _normalize(units[i + 1]['text'])
            if next_norm and norm_global[pos:pos + len(next_norm)] == next_norm:
                skip_matches = True

        if found_at > 0:
            problems.append({
                'kind': 'extra_content_skipped',
                'ids': unit['ids'],
                'note': ('このレコードの直前に、レコードに存在しない文字列が'
                         '見つかりました(新しい単語を追加した可能性があります)。'
                         'この追加分は自動反映されていません。'),
                'atoms': [unit['text']],
                'target': [global_text[orig_idx[pos]:orig_idx[pos + found_at]]],
            })
            pos += found_at
            continue

        if unit.get('insert_mode'):
            problems.append({
                'kind': 'insert_mode_edited',
                'ids': unit['ids'],
                'note': ('col_space=insert のレコードは自動再構築の対象外です。'
                         'この行は編集せずそのままにしてください。'),
                'atoms': [unit['text']],
                'target': None,
            })
            spans.append(None)
            i += 1
            continue

        if skip_matches:
            problems.append({
                'kind': 'record_removed',
                'ids': unit['ids'],
                'note': ('このレコードの文言が編集後のテキストから見つからず、'
                         '削除された可能性があります。このレコードは自動更新'
                         '対象外としました(元のまま残ります)。'),
                'atoms': [unit['text']],
                'target': None,
            })
            spans.append(None)
            i += 1
            continue

        problems.append({
            'kind': 'sequence_mismatch',
            'ids': unit['ids'],
            'note': ('このレコードの文言が、編集後のテキストの中に'
                     '期待した順番で見つかりませんでした。文言自体を'
                     '編集した、または行の順序を入れ替えた可能性があります。'
                     'このレコードは自動更新対象外としました。'),
            'atoms': [unit['text']],
            'target': None,
        })
        spans.append(None)
        i += 1

        RESYNC_LOOKAHEAD = 3000
        if i < n_units:
            next_norm = _normalize(units[i]['text'])
            if next_norm:
                wide_window = norm_global[pos:pos + RESYNC_LOOKAHEAD]
                found_resync = wide_window.find(next_norm)
                if found_resync >= 0:
                    pos += found_resync

    resolved = [(u, s) for u, s in zip(units, spans) if s is not None]
    units = [u for u, _ in resolved]
    spans = [s for _, s in resolved]

    if units and spans:
        tail = global_text[spans[-1][1]:]
        if tail.strip(' \u3000\n') != '':
            problems.append({
                'kind': 'extra_content_in_target',
                'ids': [],
                'note': ('全レコードの文言を使い切った後も、編集後のテキストに'
                         '余りがあります。新しい行を追加した可能性があります'
                         '(このツールは文言を変えない前提のため未対応です)。'),
                'atoms': [],
                'target': [tail],
            })

    boundary = []
    for i in range(len(units) - 1):
        gap = global_text[spans[i][1]:spans[i + 1][0]]
        if '\n' in gap:
            boundary.append('break')
        else:
            stripped = gap.strip('\u0020\u3000')
            if stripped != '':
                boundary.append('break')
            elif '\u3000' in gap:
                boundary.append('full')
            elif '\u0020' in gap:
                boundary.append('half')
            else:
                boundary.append('')

    groups = []
    cur = [0]
    for i, b in enumerate(boundary):
        if b == 'break':
            groups.append(cur)
            cur = [i + 1]
        else:
            cur.append(i + 1)
    groups.append(cur)

    updates: Dict[str, Dict] = {}

    def set_fields(rid, **kwargs):
        updates.setdefault(rid, {}).update(kwargs)

    for group in groups:
        if len(group) == 1:
            idx = group[0]
            rid = units[idx]['ids'][0]
            new_text = global_text[spans[idx][0]:spans[idx][1]]
            set_fields(rid, lyric=new_text, lyric_col='', col_space='')
        else:
            for k, idx in enumerate(group):
                rid = units[idx]['ids'][0]
                new_text = global_text[spans[idx][0]:spans[idx][1]]
                col_space = ''
                if k < len(group) - 1:
                    col_space = {'half': 'half', 'full': 'full', '': ''}[boundary[idx]]
                set_fields(rid, lyric=new_text, lyric_col=str(k + 1), col_space=col_space)

    planned = []
    for rec in records:
        new_rec = dict(rec)
        if rec['id'] in updates:
            new_rec.update(updates[rec['id']])
        planned.append(new_rec)

    return planned, problems


def print_problems(problems: List[Dict]) -> None:
    if not problems:
        print("[OK] 自動再構築に問題なし。全レコードを反映できました。")
        return
    print(f"[NG] 自動再構築できなかった箇所: {len(problems)}件")
    for p in problems:
        print(f"  [{p['kind']}] ids={p['ids']}")
        print(f"    原因: {p['note']}")
        print(f"    現在のレコード: {p['atoms']}")
        print(f"    編集後の希望  : {p['target']}")


# =========================================================================
# コアロジック: SQL生成
# =========================================================================
def _sql_str(s: str) -> str:
    return "'" + s.replace("'", "''") + "'"


def _sql_lyric_col(v):
    return 'NULL' if not v else str(v)


def _sql_col_space(v):
    return 'NULL' if not v else _sql_str(v)


def _sql_occurrence(v):
    return 'NULL' if not v else _sql_str(v)


def build_update_sql(orig_records: List[Dict], planned_records: List[Dict],
                      table: str = 'public.lyrics_dev') -> str:
    orig_map = {r['id']: r for r in orig_records}
    stmts = []
    for p in planned_records:
        o = orig_map[p['id']]
        sets = []
        if (o.get('lyric') or '') != (p.get('lyric') or ''):
            sets.append(f'"lyric" = {_sql_str(p["lyric"])}')
        if (o.get('lyric_col') or '') != (p.get('lyric_col') or ''):
            sets.append(f'"lyric_col" = {_sql_lyric_col(p.get("lyric_col"))}')
        if (o.get('col_space') or '') != (p.get('col_space') or ''):
            sets.append(f'"col_space" = {_sql_col_space(p.get("col_space"))}')
        if (o.get('occurrence') or '') != (p.get('occurrence') or ''):
            sets.append(f'"occurrence" = {_sql_occurrence(p.get("occurrence"))}')
        if sets:
            schema, tbl = table.split('.')
            stmts.append(f'UPDATE "{schema}"."{tbl}" SET {", ".join(sets)} WHERE "id" = {p["id"]};')
    return '\n'.join(stmts) + ('\n' if stmts else '')


def write_sql(stmts_text: str, tag: str, prefix: str = "u") -> str:
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    sql_path = os.path.join(OUTPUT_DIR, f"{prefix}{tag}.sql")
    with open(sql_path, "w", encoding="utf-8", newline="") as f:
        f.write(stmts_text)
    return sql_path


# =========================================================================
# サブコマンド: fetch-false
# =========================================================================
def cmd_fetch_false(args):
    sounds_ids = parse_id_spec(args.sounds_id)
    if not sounds_ids:
        print("[ERROR] sounds_idを正しく指定してください。")
        sys.exit(1)

    cols = ",".join(SUPABASE_COLUMNS)
    ids_csv = ",".join(str(i) for i in sounds_ids)
    url = (f"{SUPABASE_URL}/rest/v1/{SUPABASE_TABLE}"
           f"?select={cols}&sounds_id=in.({ids_csv})&order=sounds_id.asc,seq.asc")
    req = urllib.request.Request(url, headers={
        "apikey": SUPABASE_KEY,
        "Authorization": f"Bearer {SUPABASE_KEY}",
    })
    try:
        with urllib.request.urlopen(req) as resp:
            data = json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        print(f"[ERROR] HTTP {e.code}: {e.read().decode('utf-8', 'ignore')}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"[ERROR] 接続に失敗しました: {e}")
        sys.exit(1)

    grouped = defaultdict(list)
    for r in data:
        grouped[r["sounds_id"]].append(r)

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    for sid in sorted(grouped.keys()):
        out_path = os.path.join(OUTPUT_DIR, f"f{sid}.txt")
        with open(out_path, "w", encoding="utf-8", newline="") as f:
            writer = csv.writer(f, delimiter="\t", quoting=csv.QUOTE_MINIMAL)
            writer.writerow(SUPABASE_COLUMNS)
            for r in grouped[sid]:
                row = []
                for c in SUPABASE_COLUMNS:
                    v = r.get(c)
                    if v is None:
                        row.append("")
                    elif isinstance(v, list):
                        row.append("{" + ",".join("NULL" if x is None else str(x) for x in v) + "}")
                    else:
                        row.append(str(v))
                writer.writerow(row)
        print(f"[OK] sounds_id={sid}: {len(grouped[sid])}件 → {out_path}")

    for sid in sounds_ids:
        if sid not in grouped:
            print(f"[WARN] sounds_id={sid} のレコードが見つかりませんでした。")


# =========================================================================
# サブコマンド: fetch-true
# =========================================================================
def _fetch_html(song_id: str) -> str:
    url = f"https://www.uta-net.com/song/{song_id}/"
    req = urllib.request.Request(url, headers={
        "User-Agent": "Mozilla/5.0 (compatible; lyric-fetch-script/1.0)"
    })
    try:
        with urllib.request.urlopen(req) as resp:
            raw = resp.read()
    except urllib.error.HTTPError as e:
        print(f"[ERROR] HTTP {e.code} : {url}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"[ERROR] 接続に失敗しました: {e}")
        sys.exit(1)
    return raw.decode("utf-8", errors="replace")


def _extract_kashi_area(html: str) -> str:
    m = re.search(r'<div[^>]*id="kashi_area"[^>]*>', html)
    if not m:
        raise ValueError("kashi_area が見つかりませんでした。ページ構造が変わっている可能性があります。")
    start = m.end()
    depth = 1
    pos = start
    tag_re = re.compile(r'<div\b[^>]*>|</div>', re.I)
    while depth > 0:
        tm = tag_re.search(html, pos)
        if not tm:
            raise ValueError("kashi_area の終了タグが見つかりませんでした。")
        if tm.group(0).lower().startswith('</div'):
            depth -= 1
        else:
            depth += 1
        pos = tm.end()
        if depth == 0:
            end = tm.start()
            break
    return html[start:end]


def _to_plain_text(kashi_html: str) -> str:
    lines_raw = re.split(r'<br\s*/?>', kashi_html)
    lines = []
    for l in lines_raw:
        text = re.sub(r'<[^>]+>', '', l).strip()
        if text:
            lines.append(text)
    return '\n'.join(lines)


def _fetch_true_and_save(song_id: str, want_plain: bool, out_name: Optional[str] = None,
                          tag_override: Optional[str] = None):
    html = _fetch_html(song_id)
    kashi_html = _extract_kashi_area(html)

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    filename = out_name or f"t{tag_override or song_id}.txt"
    out_path = os.path.join(OUTPUT_DIR, filename)

    with open(out_path, "w", encoding="utf-8", newline="") as f:
        f.write(f'<div id="kashi_area" itemprop="text">{kashi_html}</div>\n')
    print(f"[OK] 生HTMLを {out_path} に保存しました。")

    if want_plain:
        plain_path = out_path.rsplit(".", 1)[0] + ".plain.txt"
        with open(plain_path, "w", encoding="utf-8", newline="") as f:
            f.write(_to_plain_text(kashi_html))
        print(f"[OK] プレーンテキストを {plain_path} に保存しました。")


def cmd_fetch_true(args):
    if args.sounds_id:
        sounds_ids = parse_id_spec(args.sounds_id)
        url_map = load_urls_txt()
        for sid in sounds_ids:
            info = url_map.get(sid)
            if info is None:
                print(f"[WARN] sounds_id={sid}: URLs.txt に該当行がありません。スキップします。")
                continue
            if info["url"] is None:
                print(f"[SKIP] sounds_id={sid} 「{info['song_name']}」: URL該当なし。スキップします。")
                continue
            print(f"--- sounds_id={sid} 「{info['song_name']}」 を取得します ---")
            song_id = extract_song_id(info["url"])
            _fetch_true_and_save(song_id, args.plain, tag_override=str(sid))
        return

    if not args.url_or_id:
        print("[ERROR] URL/曲IDまたは --sounds-id のいずれかを指定してください。")
        sys.exit(1)
    song_id = extract_song_id(args.url_or_id)
    _fetch_true_and_save(song_id, args.plain, args.out)


# =========================================================================
# サブコマンド: export-rendered / build-sql (ルートA)
# =========================================================================
def cmd_export_rendered(args):
    if not os.path.exists(args.falselyric):
        print(f"[ERROR] ファイルが見つかりません: {args.falselyric}")
        sys.exit(1)

    records = load_falselyric(args.falselyric)
    units = render(records)
    tag = tag_from_filename(args.falselyric, "f")

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    out_path = os.path.join(OUTPUT_DIR, f"r{tag}.txt")
    with open(out_path, "w", encoding="utf-8", newline="") as f:
        for u in units:
            f.write(u['text'] + "\n")

    print(f"[OK] {len(records)}レコード → {len(units)}行 を {out_path} に出力しました。")
    print("このファイルを編集して、あるべき歌詞の姿に直してください。")
    print("編集が終わったら:")
    print(f"    python lyrics_tool.py bs {args.falselyric} {out_path}")


def cmd_build_sql(args):
    for p in (args.falselyric, args.edited):
        if not os.path.exists(p):
            print(f"[ERROR] ファイルが見つかりません: {p}")
            sys.exit(1)

    orig_records = load_falselyric(args.falselyric)
    target_lines = load_lines(args.edited)

    planned, problems = reconstruct_from_edited(orig_records, target_lines)

    print(f"元レコード数: {len(orig_records)}件 / 編集後の行数: {len(target_lines)}行")
    print("-" * 60)
    print_problems(problems)
    print("-" * 60)

    tag = tag_from_filename(args.falselyric, "f")
    sql = build_update_sql(orig_records, planned, table='public.lyrics_dev')
    sql_path = write_sql(sql, tag, prefix="u")

    changed = sql.count("UPDATE ")
    print(f"[OK] {changed}件のUPDATE文を {sql_path} に出力しました。")
    if problems:
        print(f"[注意] 上記の{len(problems)}件は自動化できなかったため、SQLに含まれていません。手動で追記してください。")


# =========================================================================
# サブコマンド: export-byrecord / apply-byrecord (ルートB)
# =========================================================================
def cmd_export_byrecord(args):
    if not os.path.exists(args.falselyric):
        print(f"[ERROR] ファイルが見つかりません: {args.falselyric}")
        sys.exit(1)

    records = load_falselyric(args.falselyric)
    tag = tag_from_filename(args.falselyric, "f")

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    out_path = os.path.join(OUTPUT_DIR, f"br{tag}.txt")
    with open(out_path, "w", encoding="utf-8", newline="") as f:
        for r in records:
            for line in r['lyric'].split('\n'):
                f.write(f"[{r['id']}] {line}\n")

    print(f"[OK] {len(records)}レコード を {out_path} に出力しました。")
    print("このファイルの [id] の後の文言だけを編集してください([id]自体・行数は変えないこと)。")
    print("編集が終わったら:")
    print(f"    python lyrics_tool.py ab {out_path}")


_TAG_RE = re.compile(r'^\[(\S+)\]\s?(.*)$')


def cmd_apply_byrecord(args):
    falselyric = args.falselyric or find_falselyric_for(args.edited)
    if args.falselyric is None:
        print(f"[INFO] falselyricファイルを自動検出しました: {falselyric}")

    for p in (falselyric, args.edited):
        if not os.path.exists(p):
            print(f"[ERROR] ファイルが見つかりません: {p}")
            sys.exit(1)

    orig = OrderedDict((r['id'], r['lyric']) for r in load_falselyric(falselyric))

    edited: "OrderedDict[str, List[str]]" = OrderedDict()
    order = []
    with open(args.edited, encoding='utf-8') as f:
        for lineno, raw in enumerate(f, 1):
            line = raw.rstrip('\n')
            if line == '':
                continue
            m = _TAG_RE.match(line)
            if not m:
                print(f"[ERROR] {lineno}行目: [id] 形式で始まっていません: {line!r}")
                sys.exit(1)
            rid, text = m.group(1), m.group(2)
            if rid not in edited:
                edited[rid] = []
                order.append(rid)
            edited[rid].append(text)

    orig_ids = set(orig.keys())
    edited_ids = set(edited.keys())
    missing = orig_ids - edited_ids
    extra = edited_ids - orig_ids
    if missing:
        print(f"[ERROR] 編集後のファイルに存在しないid(削除された?): {sorted(missing)}")
    if extra:
        print(f"[ERROR] 元のfalselyricに存在しないid(追加された?): {sorted(extra)}")
    if missing or extra:
        print("レコードの追加・削除は自動対応できません。idの集合を元と完全に一致させてください。")
        sys.exit(1)

    stmts = []
    for rid in order:
        new_lyric = '\n'.join(edited[rid])
        if new_lyric != orig[rid]:
            stmts.append(f'UPDATE "public"."lyrics_dev" SET "lyric" = {_sql_str(new_lyric)} WHERE "id" = {rid};')

    tag = tag_from_filename(falselyric, "f")
    sql_path = write_sql('\n'.join(stmts) + ('\n' if stmts else ''), tag, prefix="lu")
    print(f"[OK] {len(stmts)}件のUPDATE文(lyricのみ)を {sql_path} に出力しました。")


# =========================================================================
# サブコマンド: export-quoted / apply-quoted (ルートC)
# =========================================================================
def _quote(s: str) -> str:
    return '"' + s.replace('"', '""') + '"'


def cmd_export_quoted(args):
    if not os.path.exists(args.falselyric):
        print(f"[ERROR] ファイルが見つかりません: {args.falselyric}")
        sys.exit(1)

    records = load_falselyric(args.falselyric)
    tag = tag_from_filename(args.falselyric, "f")

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    out_path = os.path.join(OUTPUT_DIR, f"q{tag}.txt")
    with open(out_path, "w", encoding="utf-8", newline="") as f:
        for r in records:
            f.write(_quote(r['lyric']) + "\n")

    print(f"[OK] {len(records)}レコード を {out_path} に出力しました。")
    print("ブロックの数・順序を変えずに、中身だけ編集してください。")
    print("編集が終わったら:")
    print(f"    python lyrics_tool.py aq {out_path}")


def _load_quoted_blocks(path: str) -> List[str]:
    with open(path, encoding='utf-8', newline='') as f:
        content = f.read()
    reader = csv.reader(io.StringIO(content), delimiter='\t', quotechar='"')
    blocks = []
    for row in reader:
        if not row:
            continue
        text = row[0].strip('\r\n')
        if text == '' and len(row) == 1:
            continue
        text = text.replace('\r\n', '\n').replace('\r', '\n')
        blocks.append(text)
    return blocks


def cmd_apply_quoted(args):
    falselyric = args.falselyric or find_falselyric_for(args.edited)
    if args.falselyric is None:
        print(f"[INFO] falselyricファイルを自動検出しました: {falselyric}")

    for p in (falselyric, args.edited):
        if not os.path.exists(p):
            print(f"[ERROR] ファイルが見つかりません: {p}")
            sys.exit(1)

    orig = load_falselyric(falselyric)
    blocks = _load_quoted_blocks(args.edited)

    if len(blocks) != len(orig):
        print(f"[ERROR] ブロック数が一致しません(元: {len(orig)}件 / 編集後: {len(blocks)}件)。")
        print("レコードの追加・削除は自動対応できません。ブロックの数を元と完全に一致させてください。")
        sys.exit(1)

    stmts = []
    for rec, new_lyric in zip(orig, blocks):
        if new_lyric != rec['lyric']:
            stmts.append(f'UPDATE "public"."lyrics_dev" SET "lyric" = {_sql_str(new_lyric)} WHERE "id" = {rec["id"]};')

    tag = tag_from_filename(falselyric, "f")
    sql_path = write_sql('\n'.join(stmts) + ('\n' if stmts else ''), tag, prefix="lu")
    print(f"[OK] {len(stmts)}件のUPDATE文(lyricのみ)を {sql_path} に出力しました。")


# =========================================================================
# サブコマンド: check (検証・自動対応付けレポート)
# =========================================================================
def _run_check_one(false_path: str, true_path: str, label: Optional[str] = None):
    if label:
        print(f"\n########## {label} ##########")
    if not os.path.exists(false_path):
        print(f"[SKIP] ファイルが見つかりません: {false_path}")
        return
    if not os.path.exists(true_path):
        print(f"[SKIP] ファイルが見つかりません: {true_path}")
        return

    records = load_falselyric(false_path)
    true_lines = load_true_any(true_path)

    print(f"falselyric: {len(records)}レコード ({false_path})")
    print(f"truelyric : {len(true_lines)}行 ({true_path})")
    print("-" * 60)

    blocks = suggest_alignment(records, true_lines)
    print_alignment_report(blocks)


def cmd_check(args):
    if args.sounds_id:
        sounds_ids = parse_id_spec(args.sounds_id)
        url_map = load_urls_txt()
        for sid in sounds_ids:
            info = url_map.get(sid)
            if info is None:
                print(f"\n[SKIP] sounds_id={sid}: URLs.txt に該当行がありません。")
                continue
            if info["url"] is None:
                print(f"\n[SKIP] sounds_id={sid} 「{info['song_name']}」: URL該当なし。")
                continue
            song_id = extract_song_id(info["url"])
            false_path = os.path.join(OUTPUT_DIR, f"f{sid}.txt")
            true_path = os.path.join(OUTPUT_DIR, f"t{sid}.txt")
            label = f"sounds_id={sid} 「{info['song_name']}」"
            _run_check_one(false_path, true_path, label=label)
        return

    if not args.falselyric or not args.truelyric:
        print("[ERROR] falselyric/truelyric のパス、または --sounds-id を指定してください。")
        sys.exit(1)
    _run_check_one(args.falselyric, args.truelyric)


# =========================================================================
# argparse ディスパッチ
# =========================================================================
def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="lyrics_tool.py",
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    sub = parser.add_subparsers(dest="command", required=True)

    p = sub.add_parser("fetch-false", aliases=["ff"], help="Supabaseからfalselyricを取得 [ff]")
    p.add_argument("sounds_id", help='例: 16 / 16,17,18 / 16-20')
    p.set_defaults(func=cmd_fetch_false)

    p = sub.add_parser("fetch-true", aliases=["ft"], help="uta-netからtruelyricを取得 [ft]")
    p.add_argument("url_or_id", nargs="?", default=None, help="uta-netのURL、または曲ID")
    p.add_argument("out", nargs="?", default=None, help="出力ファイル名(省略可)")
    p.add_argument("--sounds-id", dest="sounds_id", default=None,
                   help="URLs.txtから自動でURLを引く場合のsounds_id指定(例: 18-25)")
    p.add_argument("--plain", action="store_true", help="プレーンテキスト版も出力する")
    p.set_defaults(func=cmd_fetch_true)

    p = sub.add_parser("export-rendered", aliases=["er"], help="[ルートA 1/2] 表示形式に組み立ててtxt出力 [er]")
    p.add_argument("falselyric", help="falselyric_<id>.txt のパス")
    p.set_defaults(func=cmd_export_rendered)

    p = sub.add_parser("build-sql", aliases=["bs"], help="[ルートA 2/2] 編集済みrenderedからSQLを再構築 [bs]")
    p.add_argument("falselyric", help="元のfalselyric_<id>.txt のパス")
    p.add_argument("edited", help="編集済みのrendered_<id>.txt のパス")
    p.set_defaults(func=cmd_build_sql)

    p = sub.add_parser("export-byrecord", aliases=["eb"], help="[ルートB 1/2] [id]タグ付きでレコードを出力 [eb]")
    p.add_argument("falselyric", help="falselyric_<id>.txt のパス")
    p.set_defaults(func=cmd_export_byrecord)

    p = sub.add_parser("apply-byrecord", aliases=["ab"], help="[ルートB 2/2] 編集済みbyrecordからSQLを生成 [ab]")
    p.add_argument("edited", help="編集済みのbr<id>.txt のパス")
    p.add_argument("falselyric", nargs="?", default=None,
                    help="元のf<id>.txt のパス(省略時は同フォルダから自動検出)")
    p.set_defaults(func=cmd_apply_byrecord)

    p = sub.add_parser("export-quoted", aliases=["eq"], help="[ルートC 1/2] ダブルクォート形式でレコードを出力 [eq]")
    p.add_argument("falselyric", help="falselyric_<id>.txt のパス")
    p.set_defaults(func=cmd_export_quoted)

    p = sub.add_parser("apply-quoted", aliases=["aq"], help="[ルートC 2/2] 編集済みquotedからSQLを生成 [aq]")
    p.add_argument("edited", help="編集済みのq<id>.txt のパス")
    p.add_argument("falselyric", nargs="?", default=None,
                    help="元のf<id>.txt のパス(省略時は同フォルダから自動検出)")
    p.set_defaults(func=cmd_apply_quoted)

    p = sub.add_parser("check", aliases=["ck"], help="自動対応付けレポートを表示(検証用) [ck]")
    p.add_argument("falselyric", nargs="?", default=None, help="falselyric_<id>.txt のパス")
    p.add_argument("truelyric", nargs="?", default=None, help="truelyric_<songid>.txt のパス")
    p.add_argument("--sounds-id", dest="sounds_id", default=None,
                   help="URLs.txtからペアを自動解決してまとめて実行(例: 18-25)")
    p.set_defaults(func=cmd_check)

    return parser


def main():
    parser = build_parser()
    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
