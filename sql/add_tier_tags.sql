-- ============================================================
-- クイズ難易度5段階化に向けたタグ列の追加
--
-- sounds: mv（公式MVの有無）, fam（有名な曲かどうか）
-- lyrics / lyrics_dev: "unique"（特徴的なフレーズか）, length（何小節か）
--
-- sounds / lyrics は本番と共有だが、追加のみ（NULL埋め）でゼロリスク。
-- 本番アプリのコードはこれらの列を読まないため、本番の挙動には影響しない。
--
-- "unique" は予約語なのでダブルクォートで囲む必要がある。
--
-- 併せて quiz_full_dev / song_lyrics_dev ビューを更新し、新しい列を
-- 開発環境のクエリから参照できるようにする。本番の quiz_full /
-- song_lyrics ビューはここでは変更しない。
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

-- 1. スキーマ変更（再実行しても安全なように IF NOT EXISTS を付与）
ALTER TABLE sounds ADD COLUMN IF NOT EXISTS mv boolean;
ALTER TABLE sounds ADD COLUMN IF NOT EXISTS fam boolean;

ALTER TABLE lyrics ADD COLUMN IF NOT EXISTS "unique" boolean;
ALTER TABLE lyrics ADD COLUMN IF NOT EXISTS length smallint;

ALTER TABLE lyrics_dev ADD COLUMN IF NOT EXISTS "unique" boolean;
ALTER TABLE lyrics_dev ADD COLUMN IF NOT EXISTS length smallint;


-- 2. quiz_full_dev ビュー更新（s.mv, s.fam, l."unique", l.length を追加）
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
    s.group_name, s.song_name, s.mv, s.fam
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
  fam
FROM grouped;


-- 3. song_lyrics_dev ビュー更新（l."unique", l.length を追加）
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
  string_agg(m.name, ',' ORDER BY m.sort_order) AS correct_members,
  l."unique",
  l.length
FROM lyrics_dev l
JOIN sounds s ON l.sounds_id = s.id
LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
LEFT JOIN members       m  ON lm.member_id = m.id
WHERE l.is_active = true
  AND s.is_active = true
GROUP BY
  l.id, l.lyric, l.section_name, l.seq,
  l.occurrence, l.lyric_col, l.col_space,
  l."unique", l.length,
  l.sounds_id, s.group_name, s.song_name
ORDER BY l.seq;
