-- ============================================================
-- 曲ごとの「1フレーズの小節数」タグを追加
--
-- 目的: lyrics_dev.length（歌詞の長さ＝実際の小節数）は、曲によって
-- 1フレーズにあたる小節数が異なる（曲調・テンポ感で変わる）ため、
-- 同じ小節数でも体感の長さが変わってしまう。曲ごとに実際の
-- 「1フレーズの小節数」を bars_per_phrase として持たせ、アプリ側で
-- 「正規化後の長さ = length × (4 ÷ bars_per_phrase)」を計算して
-- 難易度判定（TIER_TAG_FILTER / TIER_TAG_WEIGHT_FN）に使う。
-- bars_per_phrase が未設定の曲は基準4小節（従来通り）として扱う。
--
-- lengthそのものは実際の小節数をそのまま入力する（カテゴリ値ではない）。
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

-- 1. スキーマ変更
ALTER TABLE sounds ADD COLUMN IF NOT EXISTS bars_per_phrase smallint;

-- 2. quiz_full_dev ビュー更新（s.bars_per_phrase を末尾に追加）
CREATE OR REPLACE VIEW quiz_full_dev AS
WITH grouped AS (
  SELECT
    q.id,
    q.easy,
    q.normal,
    q.hard,
    q.expert,
    l.lyric        AS lyrics,
    l.section_name,
    l.seq,
    l.id           AS lyrics_id,
    l.sounds_id,
    l.occurrence,
    l.lyric_col,
    l.col_space,
    l."unique",
    l.length,
    s.group_name,
    s.song_name,
    s.mv,
    s.fam,
    s.bars_per_phrase,
    string_agg(m.name, ',' ORDER BY m.sort_order) AS correct_members
  FROM quizzes q
  JOIN lyrics_dev l ON q.lyrics_id = l.id
  JOIN sounds  s  ON l.sounds_id = s.id
  LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
  LEFT JOIN members       m  ON lm.member_id = m.id
  WHERE q.is_active = true
    AND l.is_active = true
    AND s.is_active = true
  GROUP BY
    q.id, q.easy, q.normal, q.hard, q.expert,
    l.lyric, l.section_name, l.seq, l.id,
    l.sounds_id, l.occurrence, l.lyric_col, l.col_space,
    l."unique", l.length,
    s.group_name, s.song_name, s.mv, s.fam, s.bars_per_phrase
)
SELECT
  id,
  easy, normal, hard, expert,
  lyrics,
  section_name,
  seq,
  lyrics_id,
  sounds_id,
  occurrence,
  lyric_col,
  col_space,
  group_name,
  song_name,
  correct_members,
  lag(lyrics, 2) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_prev_2,
  lag(lyrics, 1) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_prev_1,
  lead(lyrics, 1) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_next_1,
  lead(lyrics, 2) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_next_2,
  "unique",
  length,
  mv,
  fam,
  bars_per_phrase
FROM grouped;
