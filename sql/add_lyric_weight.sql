-- 歌詞ごとに出題率を調整するための重みカラムを追加。
-- 前後の歌詞や歌詞自体に歌い手の名前が入っていて簡単すぎる歌詞を、
-- 完全に除外せず「出にくくする」ために使う（デフォルト1、下げたい場合は0.1〜0.5など）。
-- lyrics/lyrics_devは本番と共有のため追加のみでNULL埋め（ゼロリスク）。本番アプリコードはこの列を読まない。
ALTER TABLE lyrics ADD COLUMN IF NOT EXISTS weight real;
ALTER TABLE lyrics_dev ADD COLUMN IF NOT EXISTS weight real;

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
    string_agg(m.name, ','::text ORDER BY m.sort_order) AS correct_members,
    l.weight
  FROM quizzes q
    JOIN lyrics_dev l ON q.lyrics_id = l.id
    JOIN sounds s ON l.sounds_id = s.id
    LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
    LEFT JOIN members m ON lm.member_id = m.id
  WHERE q.is_active = true AND l.is_active = true AND s.is_active = true
  GROUP BY q.id, q.easy, q.normal, q.hard, q.expert, l.lyric, l.section_name, l.seq, l.id, l.sounds_id, l.occurrence, l.lyric_col, l.col_space, l."unique", l.length, s.group_name, s.song_name, s.mv, s.fam, s.bars_per_phrase, l.weight
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
  string_agg(m.name, ','::text ORDER BY m.sort_order) AS correct_members,
  l."unique",
  l.length,
  l.weight
FROM lyrics_dev l
  JOIN sounds s ON l.sounds_id = s.id
  LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
  LEFT JOIN members m ON lm.member_id = m.id
WHERE l.is_active = true AND s.is_active = true
GROUP BY l.id, l.lyric, l.section_name, l.seq, l.occurrence, l.lyric_col, l.col_space, l."unique", l.length, l.sounds_id, s.group_name, s.song_name, l.weight
ORDER BY l.seq;
