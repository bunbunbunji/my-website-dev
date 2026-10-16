-- 行数不一致5曲（BABY I LOVED, Going!, skyfeelan, 好き、お願い, タイムライド）を
-- devと同じ行統合（11組）に本番も揃えるSQL。
--
-- 対象11組（survive_id, remove_id）:
--   BABY I LOVED: (1892,1893) (1894,1895) (1896,1897) (1900,1901) (1906,1907) (1910,1911) (1916,1917)
--   Going!:       (3839,3840)  ※歌割りは「松本かれんのみ」で確定(2026-10-16ユーザー判断)
--   skyfeelan:    (251,252)
--   好き、お願い:  (3336,3337)
--   タイムライド:  (1884,1885)
--
-- 事前確認済み: survive側のlyric_membersは全11組とも統合後の値と一致（Going!含む）のため変更不要。
-- 安全な実行順序: lyric_members削除 -> quizzes削除 -> lyrics削除 -> lyricテキスト更新

-- 1. remove側のlyric_members削除（16件）
delete from lyric_members
where lyric_id in (1893,1895,1897,1901,1907,1911,1917,3840,252,3337,1885);

-- 2. remove側のquizzes削除（11件、is_active=trueで現役出題中だったもの）
delete from quizzes
where lyrics_id in (1893,1895,1897,1901,1907,1911,1917,3840,252,3337,1885);

-- 3. remove側のlyrics削除（11件）
delete from lyrics
where id in (1893,1895,1897,1901,1907,1911,1917,3840,252,3337,1885);

-- 4. survive側のlyricテキストをdevの統合済みテキストに更新（11件）
update lyrics set lyric = 'It''s time to live my life 雨音
It''s time to live my life ため息' where id = 1892;

update lyrics set lyric = 'Baby I loved, Baby I loved
儚くってあれほど信じた日々の終点' where id = 1894;

update lyrics set lyric = '水たまりの街 反射するメモリー
やけに、綺麗、憎い。' where id = 1896;

update lyrics set lyric = '解釈違いの ロマンス手を振って
それじゃ、私、行くね。' where id = 1900;

update lyrics set lyric = 'It''s time to live my life. 雨音
It''s time to live my life ため息' where id = 1906;

update lyrics set lyric = '今更泣きついたって無駄よ 許してあげない
きっと きっと きっとよ' where id = 1910;

update lyrics set lyric = '湾岸ルーレット ハイウェイ
涙にそっと 都会のネオンを映す
きらり まとい 素敵 大人になれる' where id = 1916;

update lyrics set lyric = 'ブラジル・ニューヨーク・バンクーバー' where id = 3839;

update lyrics set lyric = 'やってみたかったがいっぱいつまってる
今の私の一番大事な場所' where id = 251;

update lyrics set lyric = '毎晩、眠る前、長すぎる妄想のストーリーは続く' where id = 3336;

update lyrics set lyric = '今を本気で楽しんじゃえ
心からワクワクしちゃえ' where id = 1884;

-- 実行後の確認用SELECT（コメントアウトを外して個別に実行してください）
-- select id, sounds_id, seq, lyric from lyrics where id in (1892,1894,1896,1900,1906,1910,1916,3839,251,3336,1884) order by id;
-- select count(*) from lyrics where id in (1893,1895,1897,1901,1907,1911,1917,3840,252,3337,1885); -- 0件になっていればOK
