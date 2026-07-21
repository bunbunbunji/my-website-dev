-- ============================================================
-- 開発環境用: lyrics テーブルのコピーを作成し、歌詞テキストを
-- 本番から切り離して自由に編集できるようにする。
--
-- 範囲: 歌詞テキスト（lyrics）のみコピー。
--       quizzes / lyric_members / members / sounds は本番と共有。
--       lyrics_dev は id を本番の lyrics.id と同じ値で保持するため、
--       既存の quizzes.lyrics_id / lyric_members.lyric_id の
--       紐づけはそのまま有効。
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

-- 1. lyrics テーブルの開発用コピーを作成
CREATE TABLE lyrics_dev AS
SELECT * FROM lyrics;

ALTER TABLE lyrics_dev ADD PRIMARY KEY (id);
CREATE INDEX idx_lyrics_dev_sounds_seq ON lyrics_dev (sounds_id, seq);

-- lyrics 側で RLS が有効な場合、lyrics_dev にも同様の読み取りポリシーを付与する。
-- （lyrics に RLS が無い/挙動が異なる場合はこのブロックを調整・削除してください）
ALTER TABLE lyrics_dev ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON lyrics_dev FOR SELECT USING (true);


-- 2. quiz_full_dev ビュー（quiz_full と同じ定義。lyrics → lyrics_dev のみ変更）
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
    s.group_name,
    s.song_name,
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
    s.group_name, s.song_name
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
  lead(lyrics, 2) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_next_2
FROM grouped;


-- 3. song_lyrics_dev ビュー（song_lyrics と同じ定義。lyrics → lyrics_dev のみ変更）
CREATE OR REPLACE VIEW song_lyrics_dev AS
SELECT
  l.id           AS lyrics_id,
  l.lyric        AS lyrics,
  l.section_name,
  l.seq,
  l.occurrence,
  l.lyric_col,
  l.col_space,
  l.sounds_id,
  s.group_name,
  s.song_name,
  string_agg(m.name, ',' ORDER BY m.sort_order) AS correct_members
FROM lyrics_dev l
JOIN sounds s ON l.sounds_id = s.id
LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
LEFT JOIN members       m  ON lm.member_id = m.id
WHERE l.is_active = true
  AND s.is_active = true
GROUP BY
  l.id, l.lyric, l.section_name, l.seq,
  l.occurrence, l.lyric_col, l.col_space,
  l.sounds_id, s.group_name, s.song_name
ORDER BY l.seq;


-- ============================================================
-- 今後、本番の lyrics に新しい曲・歌詞行が追加された場合は
-- lyrics_dev に同期する必要があります。差分だけ取り込む例:
--
-- INSERT INTO lyrics_dev
-- SELECT * FROM lyrics
-- WHERE id NOT IN (SELECT id FROM lyrics_dev);
-- ============================================================
