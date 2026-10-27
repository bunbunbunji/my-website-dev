-- add_exclude_from_quiz.sql の設計ミスを修正する。
-- 「歌詞モーダル」は実は2つの経路がある：
--   1. fetchSongLyrics（クイズ中の「歌詞全体を確認する」）→ song_lyrics_dev を参照（変更していない・問題なし）
--   2. openSongModal（楽曲リスト画面から開くモーダル）→ quiz_full_dev を参照（★こちらに前回のWHERE追加が直撃していた）
-- そのため quiz_full_dev のWHERE句でexclude_from_quizを除外すると、楽曲リストのモーダルからも
-- 消えてしまっていた。
--
-- 修正方針：quiz_full_dev からは除外せず、exclude_from_quiz の値をそのまま列として返すようにする。
-- クイズの出題選定（App.jsx側のprepareQuiz/prepareEndlessMode/startCustomMode/resumeQuiz）で
-- 取得後にJS側でフィルタする。openSongModalはこの列を select していないので影響なし。

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
            l.exclude_from_quiz,
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
    weight,
    exclude_from_quiz
   FROM grouped;
