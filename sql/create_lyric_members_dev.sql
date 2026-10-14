-- ============================================================
-- lyric_members_dev テーブルを新設
--
-- 背景: lyrics_dev は本番の lyrics テーブルをコピーして作られたが、
-- その後 dev 側だけに歌詞行が追加されたことで、一部の曲について
-- lyrics_dev.id が本番 lyrics.id からズレてしまっている（例: DASH!!!は+72）。
-- 歌割り（correct_members）は lyric_members（本番・dev共有、
-- lyric_id が本番lyrics.idへの外部キー）に入っているため、
-- ズレた曲は lyrics_dev.id で検索しても正しい歌割りが引けない。
--
-- 対応: lyrics_dev.id を直接参照できる dev専用の歌割りテーブルを新設。
-- quiz_full_dev / song_lyrics_dev は、このテーブルにデータがあれば
-- それを優先し、無ければ既存の lyric_members にフォールバックする。
-- 本番の lyrics / lyric_members には一切変更を加えない。
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

CREATE TABLE IF NOT EXISTS lyric_members_dev (
  lyric_id  bigint NOT NULL REFERENCES lyrics_dev(id) ON DELETE CASCADE,
  member_id bigint NOT NULL REFERENCES members(id) ON DELETE CASCADE,
  PRIMARY KEY (lyric_id, member_id)
);

ALTER TABLE lyric_members_dev ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON lyric_members_dev FOR SELECT USING (true);

-- quiz_full_dev: 歌割りの解決を lyric_members_dev 優先・lyric_members フォールバックに変更。
-- 旧来の LEFT JOIN + GROUP BY 方式をやめ、スカラーサブクエリでの解決に変更。
CREATE OR REPLACE VIEW quiz_full_dev AS
WITH grouped AS (
  SELECT
    q.id,
    q.easy,
    q.normal,
    q.hard,
    q.expert,
    l.lyric AS lyrics,
    l.section_name,
    l.seq,
    l.id AS lyrics_id,
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
    COALESCE(
      (SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order)
       FROM lyric_members_dev lmd JOIN members mm ON mm.id = lmd.member_id
       WHERE lmd.lyric_id = l.id),
      (SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order)
       FROM lyric_members lm JOIN members mm ON mm.id = lm.member_id
       WHERE lm.lyric_id = l.id)
    ) AS correct_members,
    l.weight
  FROM quizzes q
    JOIN lyrics_dev l ON q.lyrics_id = l.id
    JOIN sounds s ON l.sounds_id = s.id
  WHERE q.is_active = true AND l.is_active = true AND s.is_active = true
)
SELECT
  id,
  easy,
  normal,
  hard,
  expert,
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
  bars_per_phrase,
  weight
FROM grouped;

-- song_lyrics_dev も同様に対応
CREATE OR REPLACE VIEW song_lyrics_dev AS
SELECT
  l.id AS lyrics_id,
  l.lyric AS lyrics,
  l.section_name,
  l.seq,
  l.occurrence,
  l.lyric_col,
  l.col_space,
  l.sounds_id,
  s.group_name,
  s.song_name,
  COALESCE(
    (SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order)
     FROM lyric_members_dev lmd JOIN members mm ON mm.id = lmd.member_id
     WHERE lmd.lyric_id = l.id),
    (SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order)
     FROM lyric_members lm JOIN members mm ON mm.id = lm.member_id
     WHERE lm.lyric_id = l.id)
  ) AS correct_members,
  l."unique",
  l.length,
  l.weight
FROM lyrics_dev l
  JOIN sounds s ON l.sounds_id = s.id
WHERE l.is_active = true AND s.is_active = true
ORDER BY l.seq;
