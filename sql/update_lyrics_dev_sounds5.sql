-- ============================================================
-- lyrics_dev 更新: sounds_id=5「Going!」(id:3787〜3873, 87行)
-- truelyric.txt（成型済み）を完成形として全行を照合・修正。
--
-- 主な修正内容:
--   ・全角/半角スペース、丸括弧、波ダッシュ(〜→～)の表記統一
--   ・複数行に分かれていた歌詞を、真の1行表示に合わせて結合
--   ・別レコードとして分かれている単語を lyric_col/col_space でインライン連結
--     （例: 最強メンタリティ + この現在地 → 1行表示）
--   ・「もうチュードク」等の2フレーズ結合行は、2つ目のoccurrence値を削除
--     （1行化に伴い、先頭の値のみ保持）
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

UPDATE "public"."lyrics_dev" SET "lyric" = 'Going・Going・Going・Going・Going・Goingフルッパー (Hey)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3787; -- seq=1 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Jumping・Jumping・Jumping・Jumping・Jumping・Jumping
踊りだしますか？？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3789; -- seq=3 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '(FRUITS ZIPPER！)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3791; -- seq=5 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '最強メンタリティ', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 3792; -- seq=6 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = 'この現在地', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3793; -- seq=7 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '押すだけじゃないの？', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3794; -- seq=8 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Enterキー', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3795; -- seq=9 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '本音チラつかす', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3796; -- seq=10 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Zip up！ Zip down！', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3797; -- seq=11 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '何度だって', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3798; -- seq=12 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '失敗したい', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3799; -- seq=13 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'このドキドキは何でしょう？', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3802; -- seq=16 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = '恋の万華鏡？', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3803; -- seq=17 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ビバ異端児　そうさ個性が大事', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3805; -- seq=19 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'たまによそみしてたら置いてかれるから', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3806; -- seq=20 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = '(ちゅ！ ちゅ！ チューモク)', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3807; -- seq=21 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '飛び出し注意　なんて無視して', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3808; -- seq=22 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '「今夜こそ！」', "occurrence" = NULL, "lyric_col" = 2, "col_space" = 'half' WHERE "id" = 3809; -- seq=23 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = '(踊ろう踊ろう踊ろう)', "occurrence" = NULL, "lyric_col" = 3, "col_space" = NULL WHERE "id" = 3810; -- seq=24 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほんとかマジかは後にして　いっさいがっさい弱音はポポイポイ', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3814; -- seq=28 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ここでもう一言いいですか～？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3815; -- seq=29 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'いいよ～～↑', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3816; -- seq=30 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうチュードク (Hey↓) 不満幾千億 (Hey↓)', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3817; -- seq=31 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '超モードク(Hey↓) ぶっちゃけのモード　ふぉ～　ふぉ～う', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3819; -- seq=33 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '理不尽に不信　変われるぜ Cool Cool Lady', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3820; -- seq=34 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうチュードク (Hey↓) やばい重症ロック (Hey↓)', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3821; -- seq=35 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = 'はいチューモクはーい↑ きっかけは今日も　ふぉ～　ふぉ～う', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3823; -- seq=37 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '円陣で自信　増し増しで Cool Cool Lady', "occurrence" = '{1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3824; -- seq=38 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Going・Going・Going・Going・Going・Goingフルッパー (Hey)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3825; -- seq=39 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゲートリバーブに感じるバブり生まれる前からフォローミー Yo', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3826; -- seq=40 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ディスコ・ディスコ・ディスコ・ディスコ・ディスコ・ディスコ
ディスコミュニケーション', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3827; -- seq=41 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '熱弁・詭弁もごっちゃのジョーシキ
聴いてくれなきゃ　嫌ーね　嫌ーね　嫌ーね', "occurrence" = '{1,1}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3828; -- seq=42 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '(FRUITS ZIPPER！)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3829; -- seq=43 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ウザいくらいの', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3830; -- seq=44 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'カンフル剤', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3831; -- seq=45 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '個性とコスメの', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3832; -- seq=46 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ギャングスタ', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3833; -- seq=47 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '自尊ヴァイヴス', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3834; -- seq=48 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '激アゲ中な', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3835; -- seq=49 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '負ける気がせん！', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3836; -- seq=50 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんちゅーか！', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3837; -- seq=51 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ソウル・香港・ロンドンに・パリに', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3838; -- seq=52 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ブラジル・ニューヨーク・', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3839; -- seq=53 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'バンクーバー', "occurrence" = NULL, "lyric_col" = 3, "col_space" = NULL WHERE "id" = 3840; -- seq=54 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '満腹中枢バグったLove', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 3841; -- seq=55 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = '地球ZipしてTaxiったら', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3842; -- seq=56 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '守りすぎてばっかじゃモチベーションもダウン', "occurrence" = NULL, "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3844; -- seq=58 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = '(ちゅ！ ちゅ！ チューモク)', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3845; -- seq=59 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '時は金なり　まだ見ぬ世界で', "occurrence" = NULL, "lyric_col" = 1, "col_space" = NULL WHERE "id" = 3846; -- seq=60 (lyric,lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '今夜だけ！', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3847; -- seq=61 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = '歌おう歌おう歌おう', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3848; -- seq=62 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'やる気も勇気もそこそこで　シンデレラなんてズルすぎてチート', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3850; -- seq=64 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '人畜無害の顔ですが　ほんとは野心ありよりのありっぽーい', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3852; -- seq=66 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'さらにもう一言いいですか～？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3853; -- seq=67 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'いいよ～～↑', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3854; -- seq=68 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうチュードク(Hey↓) 不満幾千億(Hey↓)', "occurrence" = '{3}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3855; -- seq=69 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '超モードク(Hey↓) ぶっちゃけのモード　ふぉ～　ふぉ～う', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3857; -- seq=71 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '理不尽に不信　変われるぜ Cool Cool Lady', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3858; -- seq=72 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうチュードク(Hey↓) やばい重症ロック(Hey↓)', "occurrence" = '{4}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3859; -- seq=73 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = 'はいチューモクはーい↑ きっかけは今日も　ふぉ～　ふぉ～う', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3861; -- seq=75 (lyric,occurrence)
UPDATE "public"."lyrics_dev" SET "lyric" = '円陣で自信　増し増しで Cool Cool Lady', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3862; -- seq=76 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Going・Going・Going・Going・Going・Goingフルッパー (Hey)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3863; -- seq=77 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ステージにハードに溢れるバブり 生まれたまんまでClap ya hands', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3864; -- seq=78 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Jumping・Jumping・Jumping・Jumping・Jumping・Jumping
踊りだしますか？？', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3865; -- seq=79 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '狭しい世界のVS常識
愛はバルクだ', "occurrence" = '{2,NULL}', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 3866; -- seq=80 (lyric_col,col_space)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Pump Up Pump Up Pump Up', "occurrence" = NULL, "lyric_col" = 2, "col_space" = NULL WHERE "id" = 3867; -- seq=81 (lyric_col)
UPDATE "public"."lyrics_dev" SET "lyric" = 'Going・Going・Going・Going・Going・Goingフルッパー (Hey)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3868; -- seq=82 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゲートリバーブに感じるバブみ生まれる前からフォローミー Yo', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3869; -- seq=83 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = 'ディスコ・ディスコ・ディスコ・ディスコ・ディスコ・ディスコ
ディスコミュニケーション', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3870; -- seq=84 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '聴いてくれなきゃ　嫌ーね・嫌ーね・嫌ーね', "occurrence" = '{2}', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3872; -- seq=86 (lyric)
UPDATE "public"."lyrics_dev" SET "lyric" = '(FRUITS ZIPPER！)', "occurrence" = NULL, "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 3873; -- seq=87 (lyric)
