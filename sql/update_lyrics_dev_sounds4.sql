-- ============================================================
-- lyrics_dev 全件置換: sounds_id=4（id:3224〜3283, 60行）
-- truelyric.txt を完成形として全行を照合・修正済み。
--
-- 主な修正点:
--   ・「こ、個性 こーこーせい」→「こ、個性\nこーこーせい」に分割（全箇所）
--   ・「求められるような恋とか、/なんとか欲しがられたりだけど」→ 1行に結合（3233）
--   ・「むずがゆいような言葉だって今、言っていこ？」→ 1行化（3242,3272）, occurrence更新
--   ・「え、いつからだっていいじゃん、いつまでとかないじゃん」→ 1行化（3252）
--   ・「は まあ三年、」→「はまあ三年、」スペース除去（3254）
--   ・「ほらきょうはきょうの小テストを/クリアしとかなきゃね」→ 行区切り位置修正（3255）
--   ・「ほんとはまったく/気にしてもいないけれど」→ 1行化（3256）
--   ・「ねぇ、ねえねえ 昨日」→「ねぇ、ねえねえ昨日」スペース除去（3258）
--   ・「忘れないような言葉も/何度も、言っていこ？」→ 1行化（3264）
--   ・section_name を空行位置に合わせて全面見直し
--     （イントロ/Bメロ/間奏/サビをサブセクションに分割）
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '1', "section_name" = 'イントロ①', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3224';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '2', "section_name" = 'イントロ①', "lyric" = '同じ制服着ても', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3225';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '3', "section_name" = 'イントロ②', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3226';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '4', "section_name" = 'イントロ②', "lyric" = '同じ授業受けても', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3227';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '5', "section_name" = 'イントロ③', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3228';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '6', "section_name" = 'イントロ③', "lyric" = '同じ頃生まれても', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3229';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '7', "section_name" = 'イントロ④', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3230';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '8', "section_name" = 'イントロ④', "lyric" = '同じとこ続いても', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3231';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '9', "section_name" = '1番のAメロ', "lyric" = 'わたしはわたしで、いーの
ってそりゃそうです、', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3232';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '10', "section_name" = '1番のAメロ', "lyric" = 'でもきょうはきょうの協調性も
求められるような恋とか、なんとか欲しがられたりだけど', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3233';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '11', "section_name" = '1番のBメロ①', "lyric" = '個性の方向性が
虹色くらいにあって、大変です', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3234';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '12', "section_name" = '1番のBメロ②', "lyric" = 'ねぇ、だから気持ち悪さもかわいいでしょ？
ねぇ、あきらめの悪さもかわいいでしょ？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3235';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '13', "section_name" = '1番の間奏①', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3236';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '14', "section_name" = '1番の間奏①', "lyric" = '同じ制服着ても', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3237';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '15', "section_name" = '1番の間奏②', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3238';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '16', "section_name" = '1番の間奏②', "lyric" = '同じように生きても', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3239';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '17', "section_name" = '1番の間奏③', "lyric" = '発揮したいね', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3240';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '18', "section_name" = '1番のサビ①', "lyric" = '君の変なところが好きです
わたしと違う君がいるから', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3241';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '19', "section_name" = '1番のサビ①', "lyric" = 'むずがゆいような言葉だって今、言っていこ？', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3242';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '20', "section_name" = '1番のサビ②', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3243';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '21', "section_name" = '1番のサビ②', "lyric" = '大事なことは一個', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3244';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '22', "section_name" = '1番のサビ②', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3245';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '23', "section_name" = '1番のサビ②', "lyric" = '時々は笑うこと', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3246';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '24', "section_name" = '1番のサビ③', "lyric" = 'オリジナルなこう世界を
どうやったって見せるのです', "occurrence" = '{1,1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3247';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '25', "section_name" = '1番のサビ③', "lyric" = '君のそんなとこ世界一好き', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3248';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '26', "section_name" = '2番のイントロ', "lyric" = 'え、こーこーせい？
ハイスクールスチューデント？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3249';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '27', "section_name" = '2番のイントロ', "lyric" = 'いや、それキャラクター？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3250';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '28', "section_name" = '2番のイントロ', "lyric" = 'とりあえずバイブス高い方でいきたい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3251';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '29', "section_name" = '2番のイントロ', "lyric" = 'え、いつからだっていいじゃん、いつまでとかないじゃん', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3252';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '30', "section_name" = '2番のイントロ', "lyric" = '卒業するまで、しないけどね', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3253';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '31', "section_name" = '2番のAメロ', "lyric" = 'ひたすら気ままでいーの
はまあ三年、', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3254';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '32', "section_name" = '2番のAメロ', "lyric" = 'ほらきょうは
きょうの小テストをクリアしとかなきゃね', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3255';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '33', "section_name" = '2番のAメロ', "lyric" = 'ほんとはまったく気にしてもいないけれど', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3256';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '34', "section_name" = '2番のBメロ①', "lyric" = '顔面の偏差値なんて
自分の中でしかなくて、参考程度', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3257';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '35', "section_name" = '2番のBメロ②', "lyric" = 'ねぇ、ねえねえ昨日よりもかわいいでしょ？
ねぇ、ねえって言いすぎてもかわいいでしょ？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3258';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '36', "section_name" = '2番の間奏①', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3259';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '37', "section_name" = '2番の間奏①', "lyric" = '同じ制服着ても', "occurrence" = '{3}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3260';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '38', "section_name" = '2番の間奏②', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3261';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '39', "section_name" = '2番の間奏②', "lyric" = '同じように生きても', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3262';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '40', "section_name" = '2番のサビ', "lyric" = '君の変なところが好きです
昨日と違う君がいるから', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3263';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '41', "section_name" = '2番のサビ', "lyric" = '忘れないような言葉も何度も、言っていこ？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3264';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '42', "section_name" = '2番のサビ', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3265';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '43', "section_name" = '2番のサビ', "lyric" = '大事なことは一個', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3266';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '44', "section_name" = '2番のサビ', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3267';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '45', "section_name" = '2番のサビ', "lyric" = '私が言ったってこと', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3268';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '46', "section_name" = '2番のサビ', "lyric" = 'オリジナルなこう世界を
どうやったって生きるのです', "occurrence" = '{2,NULL}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3269';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '47', "section_name" = '2番のサビ', "lyric" = '君と', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3270';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '48', "section_name" = '3番のサビ①', "lyric" = '君の変なところが好きです
わたしと違う君がいるから', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3271';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '49', "section_name" = '3番のサビ②', "lyric" = 'むずがゆいような言葉だって今、言っていこ？', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3272';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '50', "section_name" = '3番のサビ③', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3273';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '51', "section_name" = '3番のサビ③', "lyric" = '大事なことは一個', "occurrence" = '{3}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3274';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '52', "section_name" = '3番のサビ③', "lyric" = 'say yeah', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3275';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '53', "section_name" = '3番のサビ③', "lyric" = '時々は笑うこと', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3276';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '54', "section_name" = '3番のサビ④', "lyric" = 'オリジナルなこう世界を', "occurrence" = '{3}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3277';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '55', "section_name" = '3番のサビ④', "lyric" = 'どうやったって見せるのです', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3278';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '56', "section_name" = '3番のサビ⑤', "lyric" = '君のそんなとこ世界一好き', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3279';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '57', "section_name" = '3番のアウトロ', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3280';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '58', "section_name" = '3番のアウトロ', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3281';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '59', "section_name" = '3番のアウトロ', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3282';
UPDATE "public"."lyrics_dev" SET "sounds_id" = '4', "seq" = '60', "section_name" = '3番のアウトロ', "lyric" = 'こ、個性
こーこーせい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL, "is_active" = 'True' WHERE "id" = '3283';

-- ============================================================
-- 確認用: 実行後の全行を表示
-- ============================================================
SELECT id, seq, section_name, lyric, occurrence
FROM lyrics_dev
WHERE sounds_id = 4
ORDER BY seq;
