-- 歌詞モーダルの表示は維持しつつ、クイズの出題対象からは除外できる仕組みを追加する。
-- lyrics_dev に exclude_from_quiz 列を追加し、quiz_full_dev の WHERE 条件にのみ反映する
-- （song_lyrics_dev は変更しない。こちらがモーダル表示のソースのため、除外フラグに関わらず表示され続ける）。
-- quiz_full_dev の SELECT列構成は変えないため、CREATE OR REPLACE で既存ビューをそのまま更新できる
-- （DROP VIEWは不要。依存オブジェクトの列シグネチャが変わらないため）。

ALTER TABLE "public"."lyrics_dev"
  ADD COLUMN "exclude_from_quiz" boolean NOT NULL DEFAULT false;

CREATE OR REPLACE VIEW quiz_full_dev AS
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
            AND COALESCE(l.exclude_from_quiz, false) = false
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
