-- ============================================================
-- lyrics_dev 全件置換: sounds_id=1（id:1892〜1924, 33行）
-- truelyric.txt を完成形として全行を照合・修正済み。
--
-- 主な修正点:
--   ・Its → It's（1892,1893,1906,1907）
--   ・2番間奏の雨音行はピリオド付き（1906）
--   ・全角スペースの復元（1900,1902,1903,1904,1910,1911,1912,1913,1914,1917,1918,1924）
--   ・? → ？ 全角に統一（1904,1914）
--   ・サビ「湾岸ルーレット」: 3行分割→2行に戻す（1902,1912）, occurrence更新
--   ・サビ「すこし」: 2行分割→1行に戻す（1905,1915）, occurrence更新
--   ・サビ「すこし」2番/3番は全角スペースに統一（1915,1924）
--   ・サビ「そうよ」: 2行分割→1行に戻す（1918）
--   ・「きっと」半角→全角スペース（1911）
--   ・「きらり」半角→全角スペース（1917）
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '1', "section_name" = '1番のイントロ', "lyric" = 'It''s time to live my life 雨音', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1892';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '2', "section_name" = '1番のイントロ', "lyric" = 'It''s time to live my life ため息', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1893';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '3', "section_name" = '1番のAメロ', "lyric" = 'Baby I loved, Baby I loved
儚くって', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1894';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '4', "section_name" = '1番のAメロ', "lyric" = 'あれほど信じた日々の終点', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1895';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '5', "section_name" = '1番のAメロ', "lyric" = '水たまりの街 反射するメモリー', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1896';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '6', "section_name" = '1番のAメロ', "lyric" = 'やけに、綺麗、憎い。', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1897';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '7', "section_name" = '1番のAメロ', "lyric" = 'Baby I loved, Baby I loved
わがままって', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1898';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '8', "section_name" = '1番のAメロ', "lyric" = '恋から愛への証拠だった', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1899';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '9', "section_name" = '1番のAメロ', "lyric" = '解釈違いの　ロマンス手を振って', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1900';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '10', "section_name" = '1番のAメロ', "lyric" = 'それじゃ、私、行くね。', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1901';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '11', "section_name" = '1番のサビ', "lyric" = '湾岸ルーレット　ハイウェイ
乗り込んだら　もうどこへだって行けそう', "occurrence" = '{1,1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1902';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '12', "section_name" = '1番のサビ', "lyric" = '夜が明ける頃は　違う私で', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1903';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '13', "section_name" = '1番のサビ', "lyric" = 'そうよ悲しまないで
顔を上げて
そんなに惨めじゃないでしょ？', "occurrence" = '{1,1,1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1904';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '14', "section_name" = '1番のサビ', "lyric" = 'すこし すこしずつ変われるチャンス', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1905';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '15', "section_name" = '2番の間奏', "lyric" = 'It''s time to live my life. 雨音', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1906';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '16', "section_name" = '2番の間奏', "lyric" = 'It''s time to live my life ため息', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1907';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '17', "section_name" = '2番のAメロ', "lyric" = 'Baby I loved, Baby I loved
猫かぶって', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1908';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '18', "section_name" = '2番のAメロ', "lyric" = '合わせて笑うの疲れちゃった', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1909';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '19', "section_name" = '2番のAメロ', "lyric" = '今更　泣きついたって
無駄よ　許してあげない', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1910';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '20', "section_name" = '2番のAメロ', "lyric" = 'きっと　きっと　きっとよ', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1911';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '21', "section_name" = '2番のサビ', "lyric" = '湾岸ルーレット　ハイウェイ
乗り込んだら　もうどこへだって行けそう', "occurrence" = '{2,2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1912';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '22', "section_name" = '2番のサビ', "lyric" = '夜が明ける頃は　違う私で', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1913';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '23', "section_name" = '2番のサビ', "lyric" = 'そうよ悲しまないで
顔を上げて
そんなに惨めじゃないでしょ？', "occurrence" = '{2,2,2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1914';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '24', "section_name" = '2番のサビ', "lyric" = 'すこし　すこしずつ変われるチャンス', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1915';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '25', "section_name" = '3番のサビ', "lyric" = '湾岸ルーレット　ハイウェイ
涙にそっと　都会のネオンを映す', "occurrence" = '{3,NULL}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1916';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '26', "section_name" = '3番のサビ', "lyric" = 'きらり　まとい　素敵　大人になれる', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1917';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '27', "section_name" = '3番のサビ', "lyric" = 'そうよ　悲しまないで感じるでしょ　予感', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1918';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '28', "section_name" = '3番のサビ', "lyric" = '今が', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1919';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '29', "section_name" = '3番のサビ', "lyric" = 'ここが', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1920';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '30', "section_name" = '3番のサビ', "lyric" = '彼が', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1921';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '31', "section_name" = '3番のサビ', "lyric" = '雨の', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1922';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '32', "section_name" = '3番のサビ', "lyric" = '夜が', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1923';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '1', "seq" = '33', "section_name" = '3番のサビ', "lyric" = 'すこし　すこしずつ変われるチャンス', "occurrence" = '{3}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '1924';


-- ============================================================
-- 確認用: 実行後の全行を表示
-- ============================================================
SELECT id, seq, section_name, lyric, occurrence
FROM lyrics_dev
WHERE sounds_id = 1
ORDER BY seq;
