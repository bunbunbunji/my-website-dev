-- occurrence列を配列型からスカラーのinteger型に変更する
-- (全レコードが「1レコード1値」の新設計に移行済みであることを確認済み)
-- quiz_full_dev / song_lyrics_dev ビューがこの列に依存しているため、
-- 一旦削除してから型変更し、同じ定義で再作成する。

DROP VIEW IF EXISTS quiz_full_dev;
DROP VIEW IF EXISTS song_lyrics_dev;

ALTER TABLE "public"."lyrics_dev"
  ALTER COLUMN "occurrence" TYPE integer USING occurrence[1];

CREATE VIEW quiz_full_dev AS
 WITH grouped AS (
         SELECT l.id,
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
            COALESCE(( SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order) AS string_agg
                   FROM lyric_members_dev lmd
                     JOIN members mm ON mm.id = lmd.member_id
                  WHERE lmd.lyric_id = l.id), ( SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order) AS string_agg
                   FROM lyric_members lm
                     JOIN members mm ON mm.id = lm.member_id
                  WHERE lm.lyric_id = l.id)) AS correct_members,
            l.weight
           FROM lyrics_dev l
             LEFT JOIN quizzes q ON q.lyrics_id = l.id
             JOIN sounds s ON l.sounds_id = s.id
          WHERE COALESCE(q.is_active, true) = true AND l.is_active = true AND s.is_active = true
        )
 SELECT id,
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

CREATE VIEW song_lyrics_dev AS
 SELECT l.id AS lyrics_id,
    l.lyric AS lyrics,
    l.section_name,
    l.seq,
    l.occurrence,
    l.lyric_col,
    l.col_space,
    l.sounds_id,
    s.group_name,
    s.song_name,
    COALESCE(( SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order) AS string_agg
           FROM lyric_members_dev lmd
             JOIN members mm ON mm.id = lmd.member_id
          WHERE lmd.lyric_id = l.id), ( SELECT string_agg(mm.name, ','::text ORDER BY mm.sort_order) AS string_agg
           FROM lyric_members lm
             JOIN members mm ON mm.id = lm.member_id
          WHERE lm.lyric_id = l.id)) AS correct_members,
    l."unique",
    l.length,
    l.weight
   FROM lyrics_dev l
     JOIN sounds s ON l.sounds_id = s.id
  WHERE l.is_active = true AND s.is_active = true
  ORDER BY l.seq;
