-- ============================================================
-- lyrics_dev 更新: sounds_id=6「JAM」(id:3874〜3938, 65行)
-- truelyric.txt（成型済み）を完成形として全行を照合・修正。
--
-- 除外した行（テキストは既に正しいため未修正、要確認済み）:
--   id:3875,3898,3912,3913,3936,3937,3938
--   『Ja ja ja ja la ja la jam』の繰り返し回数がDBとtrueで一致しないが、
--   テキスト自体は正しいため手を付けていない。
--
-- 主な修正内容:
--   ・全角/半角記号（！/!、括弧）の統一
--   ・複数行に分かれていた歌詞を、真の1行表示に合わせて結合
--     （結合行は occurrence の先頭値のみ保持）
--   ・「ずっと大切にしてね でも」/「とっておきすぎないでね」の行またぎ誤り修正
--     （『でも』が前の行に誤って付いていたのを次の行の頭に修正）
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

UPDATE "public"."lyrics_dev" SET "lyric" = 'let''s jam！', "occurrence" = NULL WHERE "id" = 3874; -- seq=1 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '時々ちょっとめんどうな瞬間あったり
何が普通？or 平均？比べたりもして', "occurrence" = NULL WHERE "id" = 3878; -- seq=5 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '友達同士、知らないおしゃれをしてみたり
この手を離す日も来る
それまでは', "occurrence" = NULL WHERE "id" = 3879; -- seq=6 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '史上最高の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{1}' WHERE "id" = 3883; -- seq=10 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '前途洋々の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{1}' WHERE "id" = 3885; -- seq=12 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '(let''s jam)', "occurrence" = '{1}' WHERE "id" = 3887; -- seq=14 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'じゃあじゃあじゃあ 「君が好き」', "occurrence" = '{1}' WHERE "id" = 3896; -- seq=23 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '(let''s jam)', "occurrence" = '{2}' WHERE "id" = 3897; -- seq=24 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '史上最高の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{2}' WHERE "id" = 3907; -- seq=34 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '前途洋々の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{2}' WHERE "id" = 3909; -- seq=36 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '踊って！', "occurrence" = NULL WHERE "id" = 3911; -- seq=38 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'せーの
YEAH！', "occurrence" = NULL WHERE "id" = 3914; -- seq=41 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっと大切にしてね', "occurrence" = NULL WHERE "id" = 3915; -- seq=42 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'でもとっておきすぎないでね', "occurrence" = NULL WHERE "id" = 3916; -- seq=43 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '史上最高の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{3}' WHERE "id" = 3922; -- seq=49 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '前途洋々の君のかわいさを伝えたいよ、baby baby', "occurrence" = '{3}' WHERE "id" = 3924; -- seq=51 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '(let''s jam)', "occurrence" = '{3}' WHERE "id" = 3926; -- seq=53 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'じゃあじゃあじゃあ 「君が好き」', "occurrence" = '{2}' WHERE "id" = 3935; -- seq=62 (lyric)
