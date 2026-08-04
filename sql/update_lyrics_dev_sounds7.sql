-- ============================================================
-- lyrics_dev 更新: sounds_id=7「KawaiiってMagic」(id:3939〜3972, 34行)
-- truelyric.txt（成型済み）を完成形として全行を照合・修正。
--
-- 除外した行（テキストがtrueに対応せず、要確認済みで未修正）:
--   id:3948の2行目「いくよ (yeah)」
--   id:3960,3961「大丈夫？」「大丈夫」
--
-- 主な修正内容:
--   ・全角/半角スペースの統一
--   ・Kawaii/Bye-byeの大文字小文字・カンマ表記の統一（true準拠）
--   ・「Ah-ah, kawaii, kawaii, kawaii (yeah)」→「Ah-ah Kawaii Kawaii Kawaii」等、
--     余計な表記（カンマ・かっこ）を除去
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫', "occurrence" = '{1}' WHERE "id" = 3939; -- seq=1 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'つまずいても　涙 Bye-bye', "occurrence" = '{1}' WHERE "id" = 3940; -- seq=2 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii Kawaii Kawaii', "occurrence" = '{1}' WHERE "id" = 3941; -- seq=3 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫', "occurrence" = '{2}' WHERE "id" = 3942; -- seq=4 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '手をつないで　涙 Bye-bye', "occurrence" = '{1}' WHERE "id" = 3943; -- seq=5 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah-ah Kawaii KawaiiってMagicだわ', "occurrence" = '{1}' WHERE "id" = 3944; -- seq=6 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '遠くても会おうよ　未来で', "occurrence" = NULL WHERE "id" = 3946; -- seq=8 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫', "occurrence" = '{3}' WHERE "id" = 3949; -- seq=11 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'つまずいても　涙 Bye-bye', "occurrence" = '{2}' WHERE "id" = 3950; -- seq=12 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii Kawaii Kawaii', "occurrence" = '{2}' WHERE "id" = 3951; -- seq=13 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫', "occurrence" = '{4}' WHERE "id" = 3952; -- seq=14 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '手をつないで　涙 Bye-bye', "occurrence" = '{2}' WHERE "id" = 3953; -- seq=15 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah-ah Kawaii KawaiiってMagicだわ', "occurrence" = '{2}' WHERE "id" = 3954; -- seq=16 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつかきっと　笑おう　未来で', "occurrence" = NULL WHERE "id" = 3956; -- seq=18 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫
つまずいても　涙 Bye-bye', "occurrence" = '{5,3}' WHERE "id" = 3962; -- seq=24 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii Kawaii Kawaii', "occurrence" = '{3}' WHERE "id" = 3963; -- seq=25 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫
手をつないで　涙 Bye-bye', "occurrence" = '{6,3}' WHERE "id" = 3964; -- seq=26 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah-ah Kawaii Kawaii Kawaii', "occurrence" = NULL WHERE "id" = 3965; -- seq=27 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫
つまずいても　涙 Bye-bye', "occurrence" = '{7,4}' WHERE "id" = 3966; -- seq=28 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫', "occurrence" = '{8}' WHERE "id" = 3967; -- seq=29 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii KawaiiってMagicだわ', "occurrence" = NULL WHERE "id" = 3968; -- seq=30 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫　大丈夫
手をつないで　涙 Bye-bye', "occurrence" = '{9,4}' WHERE "id" = 3969; -- seq=31 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah-ah Kawaii KawaiiってMagicだわ', "occurrence" = '{3}' WHERE "id" = 3970; -- seq=32 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii Kawaii Kawaii
Kawaii Kawaii Kawaii', "occurrence" = '{4,5}' WHERE "id" = 3971; -- seq=33 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Kawaii Kawaii Kawaii
Kawaii Kawaii Kawaii', "occurrence" = '{6,7}' WHERE "id" = 3972; -- seq=34 (lyric)
