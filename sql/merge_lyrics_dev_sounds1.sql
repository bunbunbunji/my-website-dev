-- ============================================================
-- lyrics_dev レコード統合: sounds_id=1「BABY I LOVED」
-- 隣接する2レコードを1レコードに物理的に統合する（表示上の連結ではない）
--
-- 対象ペア（親レコードに子レコードの内容を追記し、子レコードは削除）:
--   1892 + 1893 → 1892
--   1894 + 1895 → 1894
--   1896 + 1897 → 1896
--   1900 + 1901 → 1900
--   1906 + 1907 → 1906
--   1910 + 1911 → 1910
--   1916 + 1917 → 1916
--
-- 注意: 子レコード（1893,1895,1897,1901,1907,1911,1917）はDELETEされる。
--       これらのidに紐づくクイズ問題は開発環境のクイズ出題から消える。
--       lyric_colは1レコード化に伴い度外視し、NULLにする。
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

BEGIN;

UPDATE "public"."lyrics_dev" SET
  "lyric" = 'It''s time to live my life 雨音
It''s time to live my life ため息',
  "occurrence" = '{1,1}',
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1892;

UPDATE "public"."lyrics_dev" SET
  "lyric" = 'Baby I loved, Baby I loved
儚くって
あれほど信じた日々の終点',
  "occurrence" = NULL,
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1894;

UPDATE "public"."lyrics_dev" SET
  "lyric" = '水たまりの街 反射するメモリー
やけに、綺麗、憎い。',
  "occurrence" = NULL,
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1896;

UPDATE "public"."lyrics_dev" SET
  "lyric" = '解釈違いの　ロマンス手を振って
それじゃ、私、行くね。',
  "occurrence" = NULL,
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1900;

UPDATE "public"."lyrics_dev" SET
  "lyric" = 'It''s time to live my life. 雨音
It''s time to live my life ため息',
  "occurrence" = '{2,2}',
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1906;

UPDATE "public"."lyrics_dev" SET
  "lyric" = '今更泣きついたって無駄よ　許してあげない
きっと　きっと　きっとよ',
  "occurrence" = NULL,
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1910;

UPDATE "public"."lyrics_dev" SET
  "lyric" = '湾岸ルーレット　ハイウェイ
涙にそっと　都会のネオンを映す
きらり　まとい　素敵　大人になれる',
  "occurrence" = '{3,NULL,NULL}',
  "lyric_col" = NULL,
  "col_space" = NULL
WHERE "id" = 1916;

DELETE FROM "public"."lyrics_dev"
WHERE "id" IN (1893, 1895, 1897, 1901, 1907, 1911, 1917);

COMMIT;


-- ============================================================
-- 確認用: 統合後の該当行を一覧表示
-- ============================================================
SELECT id, seq, lyric, occurrence, lyric_col, col_space
FROM "public"."lyrics_dev"
WHERE sounds_id = 1
ORDER BY seq;
