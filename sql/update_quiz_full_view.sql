-- 本番 quiz_full ビューに、dev quiz_full_dev が既に持っている列を追加する。
-- 追加列: lyric_col, col_space, "unique", length, mv, fam, bars_per_phrase, weight
-- (mv/fam/bars_per_phraseはsoundsが本番・dev共有テーブルのため既にデータが入っている。
--  unique/length/weight/lyric_col/col_spaceは2026-10-15/16の同期作業で本番lyricsに投入済み)
--
-- 実行前の実際のビュー定義(2026-10-16確認、pg_get_viewdefの出力)をベースに、
-- 不足列をdev版(quiz_full_dev)と同じ形で追加しただけで、JOIN構造・WHERE条件・
-- GROUP BYの対象行・既存列の意味は一切変更していない。

CREATE OR REPLACE VIEW quiz_full AS
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
    l.weight,
    s.group_name,
    s.song_name,
    s.mv,
    s.fam,
    s.bars_per_phrase,
    string_agg(m.name, ',' ORDER BY m.sort_order) AS correct_members
  FROM quizzes q
    JOIN lyrics l ON q.lyrics_id = l.id
    JOIN sounds s ON l.sounds_id = s.id
    LEFT JOIN lyric_members lm ON l.id = lm.lyric_id
    LEFT JOIN members m ON lm.member_id = m.id
  WHERE q.is_active = true AND l.is_active = true AND s.is_active = true
  GROUP BY
    q.id, q.easy, q.normal, q.hard, q.expert,
    l.lyric, l.section_name, l.seq, l.id, l.sounds_id, l.occurrence,
    l.lyric_col, l.col_space, l."unique", l.length, l.weight,
    s.group_name, s.song_name, s.mv, s.fam, s.bars_per_phrase
)
-- 既存ビューの列順(id〜surround_next_2)は変更せず維持し、新規列は末尾に追加する
-- (CREATE OR REPLACE VIEWは列の位置で管理されるため、途中への挿入はエラーになる)
SELECT
  id, easy, normal, hard, expert, lyrics, section_name, seq, lyrics_id, sounds_id,
  occurrence, group_name, song_name, correct_members,
  lag(lyrics, 2) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_prev_2,
  lag(lyrics, 1) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_prev_1,
  lead(lyrics, 1) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_next_1,
  lead(lyrics, 2) OVER (PARTITION BY sounds_id ORDER BY seq) AS surround_next_2,
  lyric_col, col_space, "unique", length, mv, fam, bars_per_phrase, weight
FROM grouped;
