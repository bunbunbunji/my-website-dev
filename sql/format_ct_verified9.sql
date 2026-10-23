-- CANDY TUNE 歌詞成型: 修正版lyrics_tool.py（行頭括弧の欠落バグ修正後）で
-- 完成形入力と完全一致（内容の過不足なし・lyric_col/col_space算出成功・
-- render結果が完成形と1文字違わず一致）を確認できた9曲分。
--
-- 対象: HOT！SCOOP！、Twilight Dilemma、WAO！アオハル！、hanamaru、
--       いえなかったことば ～ありがとう～、きゅきゅきゅキュート、
--       レイドバックジャーニー、備えあれば無問題
-- （このうち実際に差分があったのはTwilight Dilemmaといえなかったこ
--   とばの2曲のみ。残り6曲は既存のDB内容が完成形と完全一致していた
--   ため、UPDATE文はなし）
--
-- 注意: sql/format_ct_batch1.sql・format_ct_batch2.sql は、この修正
-- 前のツールで生成されたもの（CATCH YOUなど行頭括弧を含む曲で欠落が
-- 起きていたことが判明）。再検証するまで実行しないこと。

UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah　与え', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 5926;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 5927;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 5928;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5929;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5930;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 5931;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんて言い飽きたここからがスタート' WHERE "id" = 5933;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたししかできない　できない' WHERE "id" = 5940;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah　誰も', "lyric_col" = 1 WHERE "id" = 5943;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5944;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 5945;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5946;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5947;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 5948;
UPDATE "public"."lyrics_dev" SET "lyric" = '今はまだ足りない　足りない' WHERE "id" = 5957;
UPDATE "public"."lyrics_dev" SET "lyric" = '諦めが悪い？笑わせとけばいい
聞いてあげる暇なんかないの' WHERE "id" = 5962;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたししかできない　できない' WHERE "id" = 5966;

UPDATE "public"."lyrics_dev" SET "lyric" = '嬉しい時はいつも自分のことみたいにはしゃぐ
家族みたいなそんな関係値' WHERE "id" = 6405;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6410;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6411;
UPDATE "public"."lyrics_dev" SET "lyric" = '共に居る時間は駆け抜けていく「ちから」なの' WHERE "id" = 6416;
UPDATE "public"."lyrics_dev" SET "lyric" = '遅刻しちゃったときも優しく向かい入れてくれる
時にやさしく時には強い' WHERE "id" = 6418;
UPDATE "public"."lyrics_dev" SET "lyric" = '嫌なことがあって少し泣いちゃった時も
君の笑顔を思い出す' WHERE "id" = 6420;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6422;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6423;
UPDATE "public"."lyrics_dev" SET "lyric" = '予定の数だけ進んでいける「しるし」だから
信じあえる' WHERE "id" = 6438;
