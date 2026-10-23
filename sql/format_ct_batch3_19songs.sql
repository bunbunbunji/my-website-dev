-- CANDY TUNE 歌詞成型: 完成形入力と完全一致を確認した19曲分
-- (format_ct_verified9.sqlで実行済みの9曲の続き)
--
-- 各曲とも lyrics_tool.py の reconstruct_from_edited で自動突き合わせ、
-- render結果が完成形入力と1文字違わず一致することを検証済み。
-- 自動化できなかった箇所（内容の追加・行またぎの再配分など）は
-- 個別に手動確認のうえ値を決定し、同じ検証を通している。
--
-- 対象: 必殺あざとポーズ、HAPPY BOUNCE BIRTHDAY、すーぱー優勝ちゅーーん！、
--       アイしちゃってます♡、シャットダウン！、TUNE MY WAY、倍倍FIGHT！、
--       絶対きゃんちゅー宣言っ！、CATCH YOU、LASTING TUNE、エトセトLOVE YOU、
--       スペシャル感謝祭、ナナイロプロローグ、レベチかわいい！、
--       君もゾンビですか ゾンビですね、夏しかサマーー！♡、
--       推し♡好き♡しんどい、未完な青春、永遠Twilight


-- 必殺あざとポーズ (sounds_id=72): 45件
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　ドキドキ隠して' WHERE "id" = 2010;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　君とデート' WHERE "id" = 2011;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　魔法をかけてよ' WHERE "id" = 2012;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　あいらびゅー　らびゅー' WHERE "id" = 2013;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きらり　メイクして' WHERE "id" = 2014;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 2019;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 2020;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 2021;
UPDATE "public"."lyrics_dev" SET "lyric" = '私自信ないけど　初めてばかりだけど
きっときっと　この気持ちだけは' WHERE "id" = 2022;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰にも負けないくらい　君と一緒に居たい' WHERE "id" = 2023;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう一歩　さぁもう一歩' WHERE "id" = 2024;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 2025;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 2026;
UPDATE "public"."lyrics_dev" SET "lyric" = '触れていたい左手　ぎゅっと' WHERE "id" = 2028;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　ドキドキ隠して' WHERE "id" = 2035;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　君とデート' WHERE "id" = 2036;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　魔法をかけてよ' WHERE "id" = 2037;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　あいらびゅー　らびゅー' WHERE "id" = 2038;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ひらり　揺らすスカート' WHERE "id" = 2039;
UPDATE "public"."lyrics_dev" SET "lyric" = '胸のリボン　完璧' WHERE "id" = 2040;
UPDATE "public"."lyrics_dev" SET "lyric" = '香水は甘め　君の好み' WHERE "id" = 2041;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 2044;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 2045;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 2046;
UPDATE "public"."lyrics_dev" SET "lyric" = '君も緊張してる？　初めて見たその服
きっときっと今日私のため' WHERE "id" = 2047;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そんな意外なとこも　独り占めしたくなる' WHERE "id" = 2048;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうちょっと　ねぇもうちょっと' WHERE "id" = 2049;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 2050;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 2051;
UPDATE "public"."lyrics_dev" SET "lyric" = '今日は君の横　予約しちゃった' WHERE "id" = 2052;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　ドキドキ隠して' WHERE "id" = 2061;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　君とデート' WHERE "id" = 2062;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　魔法をかけてよ' WHERE "id" = 2063;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　あいらびゅー　らびゅー' WHERE "id" = 2064;
UPDATE "public"."lyrics_dev" SET "lyric" = '上目遣い　困り顔
好きなタイプ「私」にしちゃうぞ' WHERE "id" = 2065;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だけどけどけどけど君のこと' WHERE "id" = 2068;
UPDATE "public"."lyrics_dev" SET "lyric" = '譲れないのなぜなぜ？（うーん、好き！）' WHERE "id" = 2069;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっと
君のこと知りたいんだって' WHERE "id" = 2070;
UPDATE "public"."lyrics_dev" SET "lyric" = '触れていたい左手　ぎゅっと' WHERE "id" = 2071;
UPDATE "public"."lyrics_dev" SET "lyric" = '気付かない？　ひらがなでも2文字ね' WHERE "id" = 2075;
UPDATE "public"."lyrics_dev" SET "lyric" = '離したくないの　だから' WHERE "id" = 2077;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　ドキドキ隠して' WHERE "id" = 2079;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　君とデート' WHERE "id" = 2080;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　魔法をかけてよ' WHERE "id" = 2081;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow　あいらびゅー　らびゅー' WHERE "id" = 2082;

-- HAPPY BOUNCE BIRTHDAY (sounds_id=74): 28件
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy born day, Happy cake day, Happy birthday to you to you
dear あなた' WHERE "id" = 4630;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 4631;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you to you…', "lyric_col" = 2 WHERE "id" = 4632;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you　喜びのキャンドルを灯して' WHERE "id" = 4636;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you　心を込めて歌おう' WHERE "id" = 4639;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, Happy birthday to you' WHERE "id" = 4646;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, And wish your smile(おめでとう)' WHERE "id" = 4647;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, Happy birthday to you
Happy birthday to you, And wish your smile' WHERE "id" = 4648;
UPDATE "public"."lyrics_dev" SET "lyric" = 'セレブレーション dear あなた' WHERE "id" = 4649;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コングラッチュレーション dear あなた' WHERE "id" = 4650;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アドレーション　マザー　ファザー
So Happy Bounce！(Bounce！)Bounce！(Bounce！)Bounce！
(Bounce！)Birthday！' WHERE "id" = 4651;
UPDATE "public"."lyrics_dev" SET "lyric" = 'セレブレーション dear あなた' WHERE "id" = 4652;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コングラッチュレーション dear あなた' WHERE "id" = 4653;
UPDATE "public"."lyrics_dev" SET "lyric" = '大好きだよ Happy birthday to you to you... dear あなた' WHERE "id" = 4654;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you　祝福をメロディーに託して' WHERE "id" = 4657;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you　祈りを込めて歌おう' WHERE "id" = 4660;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy born day, Happy cake day, Happy birthday to you to you
dear あなた' WHERE "id" = 4667;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 4668;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you to you…', "lyric_col" = 2 WHERE "id" = 4669;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, Happy birthday to you' WHERE "id" = 4671;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, And wish your smile' WHERE "id" = 4672;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you, Happy birthday to you
Happy birthday to you, And wish your smile' WHERE "id" = 4673;
UPDATE "public"."lyrics_dev" SET "lyric" = 'セレブレーション dear あなた' WHERE "id" = 4674;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コングラッチュレーション dear あなた' WHERE "id" = 4675;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アドレーション　マザー　ファザー
So Happy Bounce！(Bounce！)Bounce！(Bounce！)Bounce！
(Bounce！)Birthday！' WHERE "id" = 4676;
UPDATE "public"."lyrics_dev" SET "lyric" = 'セレブレーション dear あなた' WHERE "id" = 4677;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コングラッチュレーション dear あなた' WHERE "id" = 4678;
UPDATE "public"."lyrics_dev" SET "lyric" = '大好きだよ Happy birthday to you to you… dear あなた' WHERE "id" = 4679;

-- すーぱー優勝ちゅーーん！ (sounds_id=186): 97件
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6643;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6644;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6645;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6646;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6647;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6648;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6649;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6650;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はぴ！はぴ！どっかん！最好調！）' WHERE "id" = 6653;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はぴ！はぴ！どっかん！絶好調！）' WHERE "id" = 6655;
UPDATE "public"."lyrics_dev" SET "lyric" = '負けないじゃなくて　負けっこないじゃん' WHERE "id" = 6656;
UPDATE "public"."lyrics_dev" SET "lyric" = 'がんばるって　なんかさー　楽しいじゃん' WHERE "id" = 6657;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ごはん美味しいし　アガるQOL' WHERE "id" = 6658;
UPDATE "public"."lyrics_dev" SET "lyric" = '止まんにゃい成長期　びがっぷ！マイメン' WHERE "id" = 6659;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Hey Yo！' WHERE "id" = 6660;
UPDATE "public"."lyrics_dev" SET "lyric" = '競える仲間がいるのって　最高！' WHERE "id" = 6661;
UPDATE "public"."lyrics_dev" SET "lyric" = '超えれる自分がいるのって　最強！' WHERE "id" = 6662;
UPDATE "public"."lyrics_dev" SET "lyric" = '悪魔てきにキャワいいんだ　バーロー！' WHERE "id" = 6663;
UPDATE "public"."lyrics_dev" SET "lyric" = '主役ですもの　いっとーしょー！' WHERE "id" = 6667;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生　一生　超どセンター' WHERE "id" = 6668;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6669;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6670;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どったんばったん　ぴったんぺったん' WHERE "id" = 6671;
UPDATE "public"."lyrics_dev" SET "lyric" = 'るんるんらんらん　わーきゃー' WHERE "id" = 6672;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6673;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はい優勝！）', "lyric_col" = 2 WHERE "id" = 6674;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゅんきゅんどっきん　うーきゃー' WHERE "id" = 6676;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6678;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6679;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6680;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6681;
UPDATE "public"."lyrics_dev" SET "lyric" = '2番も優勝ちゅーーん！GO！' WHERE "id" = 6682;
UPDATE "public"."lyrics_dev" SET "lyric" = '実際　天才！　わっかるー！' WHERE "id" = 6683;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんて言ってるそばから　カンガルー！？' WHERE "id" = 6684;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ばっちこいや！の精神力で本日もMake it！' WHERE "id" = 6685;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さあ！熱狂！友情！沸騰！感動！High！優勝っ！' WHERE "id" = 6686;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やれそうじゃなくて　やるっきゃないじゃん' WHERE "id" = 6687;
UPDATE "public"."lyrics_dev" SET "lyric" = '挑戦ってさ　なんかさー　嬉しいじゃん' WHERE "id" = 6688;
UPDATE "public"."lyrics_dev" SET "lyric" = 'めちゃんこ元気に　今日もQ.E.D' WHERE "id" = 6689;
UPDATE "public"."lyrics_dev" SET "lyric" = '輝いてこーぜ　わっつぁっぷ？マイメン' WHERE "id" = 6690;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6691;
UPDATE "public"."lyrics_dev" SET "lyric" = '（うんうん！うんうん！）', "lyric_col" = 2 WHERE "id" = 6692;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんてったって！ぜんぶ！ぜんぶ！かわいいっ！' WHERE "id" = 6694;
UPDATE "public"."lyrics_dev" SET "lyric" = 'かっ！わっ！いーーーーーっ！！' WHERE "id" = 6695;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんなときでも　いっとーしょー！' WHERE "id" = 6699;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生　一生　超どセンター' WHERE "id" = 6700;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6701;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6702;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わんわんにゃーにゃー　ぴょんぴょん' WHERE "id" = 6704;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6705;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はい優勝！）', "lyric_col" = 2 WHERE "id" = 6706;
UPDATE "public"."lyrics_dev" SET "lyric" = 'りんりんぽんぽん　ぷんぷんぐんぐん' WHERE "id" = 6707;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ばんばんずっきん　どっひゃー' WHERE "id" = 6708;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6710;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6711;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6712;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6713;
UPDATE "public"."lyrics_dev" SET "lyric" = '優勝！優勝！ゼッタイ優勝っ！' WHERE "id" = 6714;
UPDATE "public"."lyrics_dev" SET "lyric" = '失敗しても愛嬌で　優勝っ！' WHERE "id" = 6715;
UPDATE "public"."lyrics_dev" SET "lyric" = '優勝！優勝！ゼッタイ優勝っ！' WHERE "id" = 6716;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やり方なんてどーだって　優勝っ！' WHERE "id" = 6717;
UPDATE "public"."lyrics_dev" SET "lyric" = '優勝！優勝！ゼッタイ優勝っ！' WHERE "id" = 6718;
UPDATE "public"."lyrics_dev" SET "lyric" = '叶えたい夢があるから　優勝っ！' WHERE "id" = 6719;
UPDATE "public"."lyrics_dev" SET "lyric" = '優勝！優勝！ゼッタイ優勝っ！' WHERE "id" = 6720;
UPDATE "public"."lyrics_dev" SET "lyric" = '結局のとこ　うちらが優勝っ！' WHERE "id" = 6721;
UPDATE "public"."lyrics_dev" SET "lyric" = '笑い合って一緒になって　前進
なんて素敵な　大前提' WHERE "id" = 6722;
UPDATE "public"."lyrics_dev" SET "lyric" = '励まし合ったり　ねっ
めちゃくちゃにどこまでもいこーっ！' WHERE "id" = 6723;
UPDATE "public"."lyrics_dev" SET "lyric" = '今も　これからも　優勝です！' WHERE "id" = 6724;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなと　みんなで　優勝でーーす！' WHERE "id" = 6725;
UPDATE "public"."lyrics_dev" SET "lyric" = '主役ですもの　いっとーしょー！' WHERE "id" = 6729;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生　一生　超どセンター' WHERE "id" = 6730;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6731;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6732;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どったんばったん　ぴったんぺったん' WHERE "id" = 6733;
UPDATE "public"."lyrics_dev" SET "lyric" = 'るんるんらんらん　わーきゃー' WHERE "id" = 6734;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6735;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はい優勝！）', "lyric_col" = 2 WHERE "id" = 6736;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゅんきゅんどっきん　うーきゃー' WHERE "id" = 6738;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6740;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6741;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6742;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6743;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6744;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6745;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6746;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6747;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6748;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6749;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6750;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6751;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6752;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6753;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6754;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6755;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6756;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6757;
UPDATE "public"."lyrics_dev" SET "lyric" = '優勝！優勝！うちらが優勝っ！' WHERE "id" = 6758;

-- アイしちゃってます♡ (sounds_id=56): 34件
UPDATE "public"."lyrics_dev" SET "lyric" = '愛しちゃって溶けちゃう～！！' WHERE "id" = 5804;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5805;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5806;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5807;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5808;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！' WHERE "id" = 5809;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP POP POP POP ROCK CANDY!' WHERE "id" = 5810;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メロすぎちゃって、きゅん！愛♡' WHERE "id" = 5824;
UPDATE "public"."lyrics_dev" SET "lyric" = '取り消したハートマーク本当はわざとだよ' WHERE "id" = 5825;
UPDATE "public"."lyrics_dev" SET "lyric" = '好きすぎちゃって、きゅん！愛♡' WHERE "id" = 5826;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コイしちゃって♡　アイしちゃってます♡' WHERE "id" = 5830;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP POP POP POP ROCK CANDY!' WHERE "id" = 5832;
UPDATE "public"."lyrics_dev" SET "lyric" = 'バレちゃうくらいがまぁOK！' WHERE "id" = 5836;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 5837;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5838;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5839;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5840;
UPDATE "public"."lyrics_dev" SET "lyric" = '君とあたし
混ざりたい' WHERE "id" = 5844;
UPDATE "public"."lyrics_dev" SET "lyric" = 'それくらいに
マーブルでラブかも' WHERE "id" = 5845;
UPDATE "public"."lyrics_dev" SET "lyric" = '愛しちゃって溶けちゃう～！！' WHERE "id" = 5846;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メロすぎちゃって、きゅん！愛♡' WHERE "id" = 5847;
UPDATE "public"."lyrics_dev" SET "lyric" = '気合い入りすぎ？引かれたらガン萎え↓' WHERE "id" = 5848;
UPDATE "public"."lyrics_dev" SET "lyric" = '好きすぎちゃって、きゅん！愛♡' WHERE "id" = 5849;
UPDATE "public"."lyrics_dev" SET "lyric" = '恥ずすぎて無理！ってそんな余裕もない' WHERE "id" = 5850;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5859;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 5860;
UPDATE "public"."lyrics_dev" SET "lyric" = '愛しちゃって溶けちゃう～！！' WHERE "id" = 5861;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メロすぎちゃって、きゅん！愛♡' WHERE "id" = 5862;
UPDATE "public"."lyrics_dev" SET "lyric" = '好きすぎちゃって、きゅん！愛♡' WHERE "id" = 5864;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コイしちゃって♡　アイしちゃってます♡' WHERE "id" = 5869;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5870;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5871;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5872;
UPDATE "public"."lyrics_dev" SET "lyric" = 'POP ROCK CANDY！POP ROCK CANDY！' WHERE "id" = 5873;

-- シャットダウン！ (sounds_id=75): 24件
UPDATE "public"."lyrics_dev" SET "lyric" = 'スクロール禁止令！時代逆行！' WHERE "id" = 6517;
UPDATE "public"."lyrics_dev" SET "lyric" = 'デジタルデバイスシャットダウン万歳！' WHERE "id" = 6518;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでデトックス！' WHERE "id" = 6519;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでMISSION TUNE！' WHERE "id" = 6520;
UPDATE "public"."lyrics_dev" SET "lyric" = '(MISSION TUNE！)' WHERE "id" = 6522;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6526;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6527;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ　あたしラメラメ
リアルが1番キャワ♡' WHERE "id" = 6529;
UPDATE "public"."lyrics_dev" SET "lyric" = '汗はダメダメ？いや、おkおk！
もっとあたしを見て' WHERE "id" = 6530;
UPDATE "public"."lyrics_dev" SET "lyric" = 'デジタルデバイスシャットダウン万歳！' WHERE "id" = 6533;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでデトックス！' WHERE "id" = 6534;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでMISSION TUNE！' WHERE "id" = 6535;
UPDATE "public"."lyrics_dev" SET "lyric" = 'What′s up?
アバターはいらない' WHERE "id" = 6536;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6542;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6543;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ　あたしラメラメ
リアルが1番沼♡' WHERE "id" = 6545;
UPDATE "public"."lyrics_dev" SET "lyric" = '汗はダメダメ？いや、おkおk！
もっと全力で来て' WHERE "id" = 6546;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっとラメラメ　君とラメラメ' WHERE "id" = 6548;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ　あたしラメラメ
リアルが1番キャワ♡' WHERE "id" = 6552;
UPDATE "public"."lyrics_dev" SET "lyric" = '汗はダメダメ？いや、おkおk！
もっとあたしを見て' WHERE "id" = 6553;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっとラメラメ　君とラメラメ
直接確かめて♡' WHERE "id" = 6555;
UPDATE "public"."lyrics_dev" SET "lyric" = 'デジタルデバイスシャットダウン万歳！' WHERE "id" = 6556;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでデトックス！' WHERE "id" = 6557;
UPDATE "public"."lyrics_dev" SET "lyric" = '表出ろ！デジタルはNO！
うちらと君とでMISSION TUNE！' WHERE "id" = 6558;

-- TUNE MY WAY (sounds_id=53): 54件
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かが決めたHzおさまらないで', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6329;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6330;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6331;
UPDATE "public"."lyrics_dev" SET "lyric" = '(Turning Tuning)', "lyric_col" = 2 WHERE "id" = 6332;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やりたい事書き詰めたココロノート', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6333;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6334;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6335;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6336;
UPDATE "public"."lyrics_dev" SET "lyric" = '少しずれた周波数 集めてメロディーにしよう' WHERE "id" = 6337;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ベロシティMAX CHANCE!　響かす　JUMP' WHERE "id" = 6338;
UPDATE "public"."lyrics_dev" SET "lyric" = '巡り会えた波長　溶かして', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6339;
UPDATE "public"."lyrics_dev" SET "lyric" = '遥か　宙に舞え', "lyric_col" = 2 WHERE "id" = 6340;
UPDATE "public"."lyrics_dev" SET "lyric" = '笑って泣いて　進んでいくんだ　自分らしく' WHERE "id" = 6342;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6343;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6344;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あがいて　はって　もがいてだって　自分らしく' WHERE "id" = 6345;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま　解き放つんだムーヴ', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6346;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6347;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6348;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6350;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6351;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6352;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6355;
UPDATE "public"."lyrics_dev" SET "lyric" = '(Burning Tuning)', "lyric_col" = 2 WHERE "id" = 6356;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6357;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6358;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6359;
UPDATE "public"."lyrics_dev" SET "lyric" = '(万人チューニング)', "lyric_col" = 2 WHERE "id" = 6360;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CHOICE!　引き出す　AMP
決意見えた波長　揺らいで' WHERE "id" = 6363;
UPDATE "public"."lyrics_dev" SET "lyric" = '遥か　宙に舞え' WHERE "id" = 6364;
UPDATE "public"."lyrics_dev" SET "lyric" = '迷ってたって　進んでいくんだ　時間だけは' WHERE "id" = 6366;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6367;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6368;
UPDATE "public"."lyrics_dev" SET "lyric" = '悩んで　待って　彷徨ってないで 自分らしく' WHERE "id" = 6369;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま　解き放つんだムーヴ', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6370;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6371;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6372;
UPDATE "public"."lyrics_dev" SET "lyric" = 'フルドライブ歪ませ　半端は嫌さ' WHERE "id" = 6373;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6374;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6375;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6376;
UPDATE "public"."lyrics_dev" SET "lyric" = '分かってるんだ　答えはいつも自分らしく' WHERE "id" = 6391;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6392;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6393;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あがいて　はって
もがいて だって　自分らしく' WHERE "id" = 6394;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま　解き放つんだムーヴ', "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6395;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6396;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6397;
UPDATE "public"."lyrics_dev" SET "lyric" = 'フルボリューム鳴らして　半端は嫌さ' WHERE "id" = 6398;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY　TUNE MY WAY' WHERE "id" = 6399;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6400;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6401;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'half' WHERE "id" = 6402;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6403;

-- 倍倍FIGHT！ (sounds_id=70): 80件
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE' WHERE "id" = 569;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE）' WHERE "id" = 570;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE' WHERE "id" = 571;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT　倍倍FIGHT by CANDY TUNE）' WHERE "id" = 572;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 573;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なりたい　在りたい　けど　だけど...', "lyric_col" = 2 WHERE "id" = 574;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 575;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なりたい　在りたい　けど　だけど...', "lyric_col" = 2 WHERE "id" = 576;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かを救うということは　過去の自分も救うことです' WHERE "id" = 577;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かを愛すということは　本当の自分を大好きになることです' WHERE "id" = 578;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
何回転んでも　立ち上がれ' WHERE "id" = 579;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
厄介な問題も飛び越えろ' WHERE "id" = 580;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 581;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍倍倍倍）', "lyric_col" = 2 WHERE "id" = 582;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 583;
UPDATE "public"."lyrics_dev" SET "lyric" = '（byebye byebye）', "lyric_col" = 2 WHERE "id" = 584;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の　バイのバイでもっと行こうよ' WHERE "id" = 585;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT' WHERE "id" = 586;
UPDATE "public"."lyrics_dev" SET "lyric" = '飽き性　根性ない状況' WHERE "id" = 587;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やめたい　やめたい　けどだけど...' WHERE "id" = 588;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やめたい　やめたい　けどだけど...' WHERE "id" = 590;
UPDATE "public"."lyrics_dev" SET "lyric" = '何かを犠牲にすることは　何かを目指すということです' WHERE "id" = 591;
UPDATE "public"."lyrics_dev" SET "lyric" = '何かを目指すということは　何かを本気で信じるということです' WHERE "id" = 592;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
なんてまあ素敵なこの人生' WHERE "id" = 593;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
だって私はそう私だもん' WHERE "id" = 594;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 595;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍倍倍倍）', "lyric_col" = 2 WHERE "id" = 596;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 597;
UPDATE "public"."lyrics_dev" SET "lyric" = '（byebye byebye）', "lyric_col" = 2 WHERE "id" = 598;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の　バイのバイでもっと行こうよ' WHERE "id" = 599;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT' WHERE "id" = 600;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE' WHERE "id" = 601;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE）' WHERE "id" = 602;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE' WHERE "id" = 603;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT　倍倍FIGHT　by CANDY TUNE）' WHERE "id" = 604;
UPDATE "public"."lyrics_dev" SET "lyric" = '自分を大事に　本音を大事に　つまずいたって', "lyric_col" = 1 WHERE "id" = 605;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 606;
UPDATE "public"."lyrics_dev" SET "lyric" = '強い人間になりたかったって？今からなれるさ', "lyric_col" = 1 WHERE "id" = 607;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 608;
UPDATE "public"."lyrics_dev" SET "lyric" = '有言実行　言葉に宿った魂信じて', "lyric_col" = 1 WHERE "id" = 609;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 610;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かと比べて落ち込んだって　自分は自分さ', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 611;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 612;
UPDATE "public"."lyrics_dev" SET "lyric" = '半径100km　幸せで満たしたいな', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 613;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 614;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 615;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 616;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 617;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 618;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 619;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍倍アクティブ　byebyeパッシブ', "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 620;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 621;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 622;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 623;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 624;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 625;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 626;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 627;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 628;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 629;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 630;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 631;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
なんと言われても諦めぬ' WHERE "id" = 632;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
人生これっきり　一度っきり' WHERE "id" = 633;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
何回転んでも　立ち上がれ' WHERE "id" = 634;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT
厄介な問題も飛び越えろ' WHERE "id" = 635;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 636;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍倍倍倍）', "lyric_col" = 2 WHERE "id" = 637;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 638;
UPDATE "public"."lyrics_dev" SET "lyric" = '（byebye byebye）', "lyric_col" = 2 WHERE "id" = 639;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の　バイのバイでもっと行こうよ' WHERE "id" = 640;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍倍FIGHT　倍倍倍FIGHT' WHERE "id" = 641;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 642;
UPDATE "public"."lyrics_dev" SET "lyric" = '原宿から世界へ！', "lyric_col" = 2 WHERE "id" = 643;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 646;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 647;
UPDATE "public"."lyrics_dev" SET "lyric" = '忙しなくて疲れたならちょっと休むかい？', "lyric_col" = 1 WHERE "id" = 648;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 649;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 650;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT　倍FIGHT　倍FIGHT', "lyric_col" = 2 WHERE "id" = 651;

-- 絶対きゃんちゅー宣言っ！ (sounds_id=69): 48件
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6106;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6107;
UPDATE "public"."lyrics_dev" SET "lyric" = 'C！A！N！D！Y！T！U！N！E！
きゃんちゅー！！' WHERE "id" = 6108;
UPDATE "public"."lyrics_dev" SET "lyric" = 'C！A！N！D！Y！T！U！N！E！
きゃんちゅー！！' WHERE "id" = 6109;
UPDATE "public"."lyrics_dev" SET "lyric" = 'C！A！N！D！Y！T！U！N！E！
きゃんちゅー！！' WHERE "id" = 6110;
UPDATE "public"."lyrics_dev" SET "lyric" = 'C！A！N！D！Y！T！U！N！E！
きゃんちゅー！！' WHERE "id" = 6111;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あー！ゆー！れでぃーーーっ！！' WHERE "id" = 6112;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いくぜ！
Yes！We are 最強CANDY TUNE！
絶賛！ガチャついちゃってまーす！' WHERE "id" = 6114;
UPDATE "public"."lyrics_dev" SET "lyric" = 'テンションHighなアイドル！
がむしゃらにLet''s Sing a Song！！' WHERE "id" = 6115;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yes！We are 絶対CANDY TUNE！
大切なのって“愛”だもん！' WHERE "id" = 6116;
UPDATE "public"."lyrics_dev" SET "lyric" = '精一杯の大好き！届けるから！
よっ・ろっ・しっ・くっっ！！！' WHERE "id" = 6117;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CANDY TUNE！！' WHERE "id" = 6125;
UPDATE "public"."lyrics_dev" SET "lyric" = '犬すき！(Fu～) 赤子すき！(Fu～)
平成ギャルリスペクト！　(Pon！Pon！)' WHERE "id" = 6127;
UPDATE "public"."lyrics_dev" SET "lyric" = '「アガってこー！(Fu-Fu～)
ブチアガってこー！(Fu-Fu～)」' WHERE "id" = 6128;
UPDATE "public"."lyrics_dev" SET "lyric" = '「超はっぴー！マジ最高っ♡」' WHERE "id" = 6130;
UPDATE "public"."lyrics_dev" SET "lyric" = '母性のかたまり！　(うりゃおい！)
カメラもめちゃうま！　(うりゃおい！)' WHERE "id" = 6132;
UPDATE "public"."lyrics_dev" SET "lyric" = '「あなたのハートにフォーカスしちゃうぞ！」' WHERE "id" = 6133;
UPDATE "public"."lyrics_dev" SET "lyric" = '「はいはーい！よそ見禁止っ♡」' WHERE "id" = 6135;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いくぜ！
Yes！We are 最強CANDY TUNE！
絶賛！ガチャついちゃってまーす！' WHERE "id" = 6136;
UPDATE "public"."lyrics_dev" SET "lyric" = 'テンションHighなアイドル！
がむしゃらにLet''s Sing a Song！！' WHERE "id" = 6137;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yes！We are 絶対CANDY TUNE！
偶然じゃない“運命”だもん！' WHERE "id" = 6138;
UPDATE "public"."lyrics_dev" SET "lyric" = '7人揃ったら！どんな場所も！
スっ・テっ・―っ・ジっっ！！！' WHERE "id" = 6139;
UPDATE "public"."lyrics_dev" SET "lyric" = 'お肌がマシュマロ！　(ふわふわ！)
癒し系食いしん坊！　(ふわふわ！)' WHERE "id" = 6141;
UPDATE "public"."lyrics_dev" SET "lyric" = '「おなかすいたーー！」' WHERE "id" = 6142;
UPDATE "public"."lyrics_dev" SET "lyric" = 'からの～！
だいたいいっつもニコニコ！
なちこ！(なちこ！)
なちこ！(なちこ！)' WHERE "id" = 6143;
UPDATE "public"."lyrics_dev" SET "lyric" = '「ねぇねぇ、
わたしにもひとくちちょーだい♡」' WHERE "id" = 6144;
UPDATE "public"."lyrics_dev" SET "lyric" = '性格おっとり　おバレリーナ！　(いいじゃん！)
実は　おつよい破壊神！　(いいじゃん！)' WHERE "id" = 6146;
UPDATE "public"."lyrics_dev" SET "lyric" = '「皆さまのことちゃんと見つけるばい」' WHERE "id" = 6147;
UPDATE "public"."lyrics_dev" SET "lyric" = '「み～っけ！はにゃまるうう♡」' WHERE "id" = 6149;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いくぜ！
Yes！We are 最強CANDY TUNE！
絶賛！ガチャついちゃってまーす！' WHERE "id" = 6150;
UPDATE "public"."lyrics_dev" SET "lyric" = 'テンションHighなアイドル！
がむしゃらにLet''s Sing a Song！！' WHERE "id" = 6151;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yes！We are 絶対CANDY TUNE！
涙も“キャンディー”だもん！' WHERE "id" = 6152;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yeah,真面目な黒猫ちゃん！　(Hey！Yo！)
ウィンク完璧じゃん！　(Hey！Yo！)' WHERE "id" = 6155;
UPDATE "public"."lyrics_dev" SET "lyric" = '「オッケー！狙い撃ちしまーす！」' WHERE "id" = 6156;
UPDATE "public"."lyrics_dev" SET "lyric" = '叫べEverybody！
きりちゃん！(きりちゃん！)
きりちゃん！(きりちゃん！)' WHERE "id" = 6157;
UPDATE "public"."lyrics_dev" SET "lyric" = '「全員まとめて！ハイ、ばっきゅん♡」' WHERE "id" = 6158;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さみしがり屋な王子様！　(イケメン！)
ポエマー＆エンジェルフェイス！　(イケメン！)' WHERE "id" = 6160;
UPDATE "public"."lyrics_dev" SET "lyric" = '「キミを守るためならなんだってできるよ！」' WHERE "id" = 6161;
UPDATE "public"."lyrics_dev" SET "lyric" = '「もう大丈夫！
きゃんちゅーワールドへ、さあおいで♡」' WHERE "id" = 6163;
UPDATE "public"."lyrics_dev" SET "lyric" = '圧倒的にポジティブ！　(Hi！Hi！)
存在がミラーボール！　(Hi！Hi！)' WHERE "id" = 6165;
UPDATE "public"."lyrics_dev" SET "lyric" = '「みんなの幸せがわたしの幸せでーす！」' WHERE "id" = 6166;
UPDATE "public"."lyrics_dev" SET "lyric" = '「今日もめっっちゃくちゃ、だいすきー♡」' WHERE "id" = 6168;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いくぜ！
Yes！We are 最強CANDY TUNE！
絶賛！ガチャついちゃってまーす！' WHERE "id" = 6169;
UPDATE "public"."lyrics_dev" SET "lyric" = 'テンションHighなアイドル！
がむしゃらにLet''s Sing a Song！！' WHERE "id" = 6170;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yes！We are 絶対CANDY TUNE！
大切なのって“愛”だもん！' WHERE "id" = 6171;
UPDATE "public"."lyrics_dev" SET "lyric" = '精一杯の大好き！今ここから！
よっ・ろっ・しっ・くっっ！！！' WHERE "id" = 6172;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CANDY TUNE！！' WHERE "id" = 6180;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yeah！きゃんちゅーっ' WHERE "id" = 6181;

-- CATCH YOU (sounds_id=50): 22件
UPDATE "public"."lyrics_dev" SET "lyric" = '君を虜にしちゃうから(フッフー!!!!!!!)' WHERE "id" = 5072;
UPDATE "public"."lyrics_dev" SET "lyric" = '脳内に住み着いちゃえ(ハイハイハイハイ!!!!!!!)' WHERE "id" = 5074;
UPDATE "public"."lyrics_dev" SET "lyric" = '二度と手放さないから(フッフー!!!!!!!)' WHERE "id" = 5076;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CATCH YOU＊きゃんちゅー＊CATCH YOU＊きゃんちゅー＊CATCH YOU' WHERE "id" = 5077;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5078;
UPDATE "public"."lyrics_dev" SET "lyric" = '(ナイ!!!!!!!)', "lyric_col" = 2 WHERE "id" = 5079;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5090;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キャッチ', "lyric_col" = 2 WHERE "id" = 5091;
UPDATE "public"."lyrics_dev" SET "lyric" = '「ばっちこーい!!!!!!!」' WHERE "id" = 5093;
UPDATE "public"."lyrics_dev" SET "lyric" = '君を虜にしちゃうから(フッフー!!!!!!!)' WHERE "id" = 5095;
UPDATE "public"."lyrics_dev" SET "lyric" = '脳内に住み着いちゃえ(ハイハイハイハイ!!!!!!!)' WHERE "id" = 5097;
UPDATE "public"."lyrics_dev" SET "lyric" = '二度と手放さないから(フッフー!!!!!!!)' WHERE "id" = 5099;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CATCH YOU＊きゃんちゅー＊CATCH YOU＊きゃんちゅー＊CATCH YOU' WHERE "id" = 5100;
UPDATE "public"."lyrics_dev" SET "lyric" = '止まってる暇なんて無いでしょう？(ナイ!!!!!!!)' WHERE "id" = 5101;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ハイハイハイ！ハイハイハイ！
ハイハイハイハイハイハイハイ！' WHERE "id" = 5103;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ハイハイハイ！ハイハイハイ！
ハイハイハイハイハイハイハイ！' WHERE "id" = 5104;
UPDATE "public"."lyrics_dev" SET "lyric" = '声を出してCATCH YOU' WHERE "id" = 5107;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さぁ打ち抜くよホームラン(フッフー!!!!!!!)' WHERE "id" = 5110;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CATCH YOU＊きゃんちゅー＊CATCH YOU＊きゃんちゅー＊CATCH YOU' WHERE "id" = 5111;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CATCH YOU＊きゃんちゅー＊CATCH YOU＊きゃんちゅー＊CATCH YOU' WHERE "id" = 5113;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5114;
UPDATE "public"."lyrics_dev" SET "lyric" = '(ナイ!!!!!!!)', "lyric_col" = 2 WHERE "id" = 5115;

-- LASTING TUNE (sounds_id=52): 5件
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんなときも', "lyric_col" = NULL WHERE "id" = 5974;
UPDATE "public"."lyrics_dev" SET "lyric" = '隣で笑っていたいな　遠回りも
キャンディーになったね食べちゃうぞ', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 5975;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まっくらな道ぽっきりなとき', "lyric_col" = NULL WHERE "id" = 5983;
UPDATE "public"."lyrics_dev" SET "lyric" = 'それでも孤独感はない　手が触れたの確かな存在に
アイラビュー！', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 5984;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこまででも
行ってみよう' WHERE "id" = 5993;

-- エトセトLOVE YOU (sounds_id=59): 41件
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6003;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あれもこれもそれどれもが' WHERE "id" = 6004;
UPDATE "public"."lyrics_dev" SET "lyric" = '全部全部物足りない' WHERE "id" = 6005;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だってもっとああしてこうして' WHERE "id" = 6006;
UPDATE "public"."lyrics_dev" SET "lyric" = '他にもあるのetc（エトセトラ）' WHERE "id" = 6007;
UPDATE "public"."lyrics_dev" SET "lyric" = '言葉にしてくれなきゃわからない' WHERE "id" = 6008;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なのに私も言葉にできない' WHERE "id" = 6009;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっと君に伝えたいことがいっぱいあるのに' WHERE "id" = 6011;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6014;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し？欲しい？恋しい？それ以外？' WHERE "id" = 6016;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し！欲しい！恋しい！それ以上！' WHERE "id" = 6019;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6021;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6022;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6023;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6025;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6026;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6027;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6028;
UPDATE "public"."lyrics_dev" SET "lyric" = '夢みがちくらいが羨ましい
これはフィクション？' WHERE "id" = 6029;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いやノンフィクション' WHERE "id" = 6030;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どっちにしろ結局のところ' WHERE "id" = 6031;
UPDATE "public"."lyrics_dev" SET "lyric" = '求めるのハッピーエンド' WHERE "id" = 6032;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっと君と見てみたい景色いっぱいあるのに' WHERE "id" = 6033;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6036;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し？欲しい？恋しい？それ以外？' WHERE "id" = 6038;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し！欲しい！恋しい！それ以上？' WHERE "id" = 6041;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6043;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6044;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6045;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU？' WHERE "id" = 6046;
UPDATE "public"."lyrics_dev" SET "lyric" = '好きがつまってるなんてさ、ずるい！' WHERE "id" = 6048;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6049;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し？欲しい？恋しい？それ以外？' WHERE "id" = 6051;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し！欲しい！恋しい！それ以上！' WHERE "id" = 6054;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6056;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6057;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6058;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6060;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6061;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6062;
UPDATE "public"."lyrics_dev" SET "lyric" = 'エトセトLOVE YOU！' WHERE "id" = 6063;

-- スペシャル感謝祭 (sounds_id=511): 78件
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6559;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6560;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6561;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と今を生きてる！感謝！＆スペシャル　プレシャス' WHERE "id" = 6562;
UPDATE "public"."lyrics_dev" SET "lyric" = '全力疾走で駆け抜けてった　あの人は今どこにいるかな' WHERE "id" = 6563;
UPDATE "public"."lyrics_dev" SET "lyric" = '追い風だって向かい風だって　自由に乗りこなしてみたいな' WHERE "id" = 6564;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6565;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6566;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6567;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6568;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6569;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6570;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6571;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6572;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6573;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6574;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6575;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6576;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6577;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3 WHERE "id" = 6578;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 4 WHERE "id" = 6579;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゃんちゅー in my head　どんな時も大切な人を想えば' WHERE "id" = 6580;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さんきゅー　いっぱいで　言葉になんない気持ちが溢れそうだよ' WHERE "id" = 6581;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6582;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6583;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6584;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6585;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6586;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6587;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と　過去や', "lyric_col" = 1 WHERE "id" = 6588;
UPDATE "public"."lyrics_dev" SET "lyric" = '未来じゃなくてさ今を生きてる！', "lyric_col" = 2 WHERE "id" = 6589;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！＆スペシャル　プレシャス' WHERE "id" = 6590;
UPDATE "public"."lyrics_dev" SET "lyric" = 'I''m a, You are, We are, They''re 仲間' WHERE "id" = 6591;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Brother, Sister, Mother, Father 仲間' WHERE "id" = 6593;
UPDATE "public"."lyrics_dev" SET "lyric" = 'I''m a, You are, We are, They''re 仲間' WHERE "id" = 6595;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Brother, Sister, Mother, Father 仲間' WHERE "id" = 6597;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Do Dance！Do Dance！', "lyric_col" = 1 WHERE "id" = 6599;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Do Dance！Do Dance！', "lyric_col" = 2 WHERE "id" = 6600;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝の数だけ頑張る理由をたくさん見つけたよ', "lyric_col" = 1 WHERE "id" = 6601;
UPDATE "public"."lyrics_dev" SET "lyric" = '(プレシャス)', "lyric_col" = 2 WHERE "id" = 6602;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ふとした時に足元に落ちてる幸せ見つけたよ', "lyric_col" = 1 WHERE "id" = 6603;
UPDATE "public"."lyrics_dev" SET "lyric" = '(スペシャル)', "lyric_col" = 2 WHERE "id" = 6604;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かがいるから頑張れるんだってことに気づいたよ', "lyric_col" = 1 WHERE "id" = 6605;
UPDATE "public"."lyrics_dev" SET "lyric" = '(プレシャス)', "lyric_col" = 2 WHERE "id" = 6606;
UPDATE "public"."lyrics_dev" SET "lyric" = '嬉しい時に「嬉しい」と伝えたい人が仲間だよ', "lyric_col" = 1 WHERE "id" = 6607;
UPDATE "public"."lyrics_dev" SET "lyric" = '(スペシャル)', "lyric_col" = 2 WHERE "id" = 6608;
UPDATE "public"."lyrics_dev" SET "lyric" = '悲しい時に「悲しい」と言えなくたって友達だよ', "lyric_col" = 1 WHERE "id" = 6609;
UPDATE "public"."lyrics_dev" SET "lyric" = '(プレシャス)', "lyric_col" = 2 WHERE "id" = 6610;
UPDATE "public"."lyrics_dev" SET "lyric" = '失敗　後悔　意味付け次第でポジティブな経験', "lyric_col" = 1 WHERE "id" = 6611;
UPDATE "public"."lyrics_dev" SET "lyric" = '(スペシャル)', "lyric_col" = 2 WHERE "id" = 6612;
UPDATE "public"."lyrics_dev" SET "lyric" = '荒波だって向かい風だって糧にしてどんといけ', "lyric_col" = 1 WHERE "id" = 6613;
UPDATE "public"."lyrics_dev" SET "lyric" = '(プレシャス)', "lyric_col" = 2 WHERE "id" = 6614;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6615;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 6616;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 3, "col_space" = 'full' WHERE "id" = 6617;
UPDATE "public"."lyrics_dev" SET "lyric" = 'スペシャル　感謝', "lyric_col" = 4 WHERE "id" = 6618;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6619;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6620;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6621;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス' WHERE "id" = 6622;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゃんちゅー in my head　どんな時も大切な人を想えば' WHERE "id" = 6623;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さんきゅー　いっぱいで　言葉になんない気持ちが', "lyric_col" = 1 WHERE "id" = 6624;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6625;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6626;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6627;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6628;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6629;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル　プレシャス', "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6630;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6631;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と　過去や', "lyric_col" = 1 WHERE "id" = 6632;
UPDATE "public"."lyrics_dev" SET "lyric" = '未来じゃなくてさ今を生きてる！', "lyric_col" = 2 WHERE "id" = 6633;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！＆スペシャル　プレシャス' WHERE "id" = 6634;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere,　心の中に　わたしたちがいるでしょ？' WHERE "id" = 6635;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere,　思い出してね Over and Over' WHERE "id" = 6636;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere,　心の中に　わたしたちがいるでしょ？' WHERE "id" = 6637;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere,　思い出してね Over and Over' WHERE "id" = 6638;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 6640;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 6641;

-- ナナイロプロローグ (sounds_id=62): 36件
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6197;
UPDATE "public"."lyrics_dev" SET "lyric" = '(一人だけじゃ)', "lyric_col" = 2 WHERE "id" = 6198;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6199;
UPDATE "public"."lyrics_dev" SET "lyric" = '(出来なかった)', "lyric_col" = 2 WHERE "id" = 6200;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6201;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6202;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6203;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6205;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6208;
UPDATE "public"."lyrics_dev" SET "lyric" = '(今に続く)', "lyric_col" = 2 WHERE "id" = 6209;
UPDATE "public"."lyrics_dev" SET "lyric" = '大事な　時間だった', "lyric_col" = NULL WHERE "id" = 6210;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう一度はじめよう　プロローグ', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 6211;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6226;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6227;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6228;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6229;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6230;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6231;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6232;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6235;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6237;
UPDATE "public"."lyrics_dev" SET "lyric" = '(溢れそうな)', "lyric_col" = 2 WHERE "id" = 6238;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6243;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6244;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だから大丈夫', "lyric_col" = NULL WHERE "id" = 6248;
UPDATE "public"."lyrics_dev" SET "lyric" = '雲の向こう側で青空が待ってる', "lyric_col" = NULL WHERE "id" = 6249;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 6258;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 6259;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6261;
UPDATE "public"."lyrics_dev" SET "lyric" = '(傘を閉じた)', "lyric_col" = 2 WHERE "id" = 6262;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1, "col_space" = 'full' WHERE "id" = 6263;
UPDATE "public"."lyrics_dev" SET "lyric" = '(その先でさ)', "lyric_col" = 2 WHERE "id" = 6264;
UPDATE "public"."lyrics_dev" SET "lyric" = '素敵な景色　見よう　(一緒に)' WHERE "id" = 6266;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah...', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 6267;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ここのみんなで　(ここのみんなで)', "lyric_col" = NULL WHERE "id" = 6272;
UPDATE "public"."lyrics_dev" SET "lyric" = '終わらない　旅路へ', "lyric_col" = NULL, "col_space" = NULL WHERE "id" = 6273;

-- レベチかわいい！ (sounds_id=64): 32件
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1464;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1465;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1466;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1467;
UPDATE "public"."lyrics_dev" SET "lyric" = '存在自体が超KAWAIIし♡てことは正義だし！', "lyric_col" = 1 WHERE "id" = 1468;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1469;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1471;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1472;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1473;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1474;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1475;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1476;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなハートにGAL飼って♡ぶちアガって♡' WHERE "id" = 1478;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1483;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1484;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キラキラ太陽みたいってよりは' WHERE "id" = 1488;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ギラギラのラメ☆' WHERE "id" = 1489;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1490;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1491;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1492;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1493;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1494;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1495;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1496;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1497;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1498;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1499;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなハートにGAL飼って♡ぶちアガって♡' WHERE "id" = 1501;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1506;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1507;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1520;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1521;

-- 君もゾンビですか ゾンビですね (sounds_id=67): 35件
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか　ゾンビですね' WHERE "id" = 1401;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もげちゃったり　千切れちゃったりたりらり' WHERE "id" = 1402;
UPDATE "public"."lyrics_dev" SET "lyric" = '底なしの乾きに Deadly' WHERE "id" = 1403;
UPDATE "public"."lyrics_dev" SET "lyric" = '右往左往で Wow wow wow' WHERE "id" = 1404;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか　ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1405;
UPDATE "public"."lyrics_dev" SET "lyric" = 'うごめくVoice and Growl' WHERE "id" = 1408;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Magical じゃなくて Chemical' WHERE "id" = 1410;
UPDATE "public"."lyrics_dev" SET "lyric" = '今度のWeekends' WHERE "id" = 1413;
UPDATE "public"."lyrics_dev" SET "lyric" = '暗い暗い暗い森の中' WHERE "id" = 1415;
UPDATE "public"."lyrics_dev" SET "lyric" = '←かわいい' WHERE "id" = 1416;
UPDATE "public"."lyrics_dev" SET "lyric" = '暗い暗い暗い影の中' WHERE "id" = 1418;
UPDATE "public"."lyrics_dev" SET "lyric" = '←よわいー' WHERE "id" = 1419;
UPDATE "public"."lyrics_dev" SET "lyric" = '死して彷徨い　来るぞ　さぁ Run！' WHERE "id" = 1420;
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか　ゾンビですね
もげちゃったり　千切れちゃったりたりらり' WHERE "id" = 1421;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけ見つめて Deadly
冥界に　冥界に　冥界に　冥界' WHERE "id" = 1422;
UPDATE "public"."lyrics_dev" SET "lyric" = '私ゾンビですか　ゾンビですよ
歌ったり　囓っちゃったりたりらり' WHERE "id" = 1423;
UPDATE "public"."lyrics_dev" SET "lyric" = '底なしの乾きに Deadly
右往左往で Wow wow wow' WHERE "id" = 1424;
UPDATE "public"."lyrics_dev" SET "lyric" = '眠れない夜　月夜月夜に' WHERE "id" = 1425;
UPDATE "public"."lyrics_dev" SET "lyric" = '腐乱腐乱腐乱　のが可愛い' WHERE "id" = 1426;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんな時代に　朽ち果てそうでも' WHERE "id" = 1428;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか　ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1431;
UPDATE "public"."lyrics_dev" SET "lyric" = '夢見たBad end' WHERE "id" = 1443;
UPDATE "public"."lyrics_dev" SET "lyric" = '喰らえ喰らえ喰らえ思うがまま' WHERE "id" = 1446;
UPDATE "public"."lyrics_dev" SET "lyric" = '←たのしい' WHERE "id" = 1447;
UPDATE "public"."lyrics_dev" SET "lyric" = '喰らえ喰らえ喰らえお皿まで' WHERE "id" = 1449;
UPDATE "public"."lyrics_dev" SET "lyric" = '←うまいー' WHERE "id" = 1450;
UPDATE "public"."lyrics_dev" SET "lyric" = '死して彷徨い　来るぞ　さぁ Run！' WHERE "id" = 1451;
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか　ゾンビですね
もげちゃったり　千切れちゃったりたりらり' WHERE "id" = 1452;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけ見つめて Deadly
冥界に　冥界に　冥界に　冥界' WHERE "id" = 1453;
UPDATE "public"."lyrics_dev" SET "lyric" = '私ゾンビですか　ゾンビですよ
歌ったり　囓っちゃったりたりらり' WHERE "id" = 1454;
UPDATE "public"."lyrics_dev" SET "lyric" = '底なしの乾きに Deadly
右往左往で Wow wow wow' WHERE "id" = 1455;
UPDATE "public"."lyrics_dev" SET "lyric" = '眠れない夜　月夜月夜に' WHERE "id" = 1456;
UPDATE "public"."lyrics_dev" SET "lyric" = '腐乱腐乱腐乱　のが可愛い' WHERE "id" = 1457;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんな時代に　朽ち果てそうでも' WHERE "id" = 1459;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか　ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1462;

-- 夏しかサマーー！♡ (sounds_id=66): 12件
UPDATE "public"."lyrics_dev" SET "lyric" = 'あいす！' WHERE "id" = 6454;
UPDATE "public"."lyrics_dev" SET "lyric" = 'らむね！' WHERE "id" = 6456;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゆかた！' WHERE "id" = 6460;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みずぎ！' WHERE "id" = 6462;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう夏しか勝たん！', "lyric_col" = NULL WHERE "id" = 6464;
UPDATE "public"."lyrics_dev" SET "lyric" = '夏しか勝たん！', "lyric_col" = NULL WHERE "id" = 6465;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すいか！' WHERE "id" = 6492;
UPDATE "public"."lyrics_dev" SET "lyric" = '花火！' WHERE "id" = 6494;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Sing on Summer' WHERE "id" = 6509;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Sing on Summer' WHERE "id" = 6511;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Sing on Summer' WHERE "id" = 6513;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Sing on Summer' WHERE "id" = 6515;

-- 推し♡好き♡しんどい (sounds_id=68): 79件
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1925;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1926;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1927;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2 WHERE "id" = 1928;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！
推し　好き　しんどい！' WHERE "id" = 1929;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！
推しが好きすぎて　しんどい！' WHERE "id" = 1930;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あ゛～　もう無理！
好きの許容量がオーバー
なーんもする気になんない' WHERE "id" = 1931;
UPDATE "public"."lyrics_dev" SET "lyric" = '推しって　世界を救ってない？' WHERE "id" = 1933;
UPDATE "public"."lyrics_dev" SET "lyric" = '好き過ぎて　食べちゃいたい' WHERE "id" = 1934;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ポケットに入れて　持ち帰りたい' WHERE "id" = 1935;
UPDATE "public"."lyrics_dev" SET "lyric" = '剥製にして　お部屋に飾りたい' WHERE "id" = 1936;
UPDATE "public"."lyrics_dev" SET "lyric" = 'え　それはちょっと引くわ' WHERE "id" = 1937;
UPDATE "public"."lyrics_dev" SET "lyric" = 'SNS　更新だけで' WHERE "id" = 1938;
UPDATE "public"."lyrics_dev" SET "lyric" = '酸素が　濃くなる感覚', "lyric_col" = 1 WHERE "id" = 1939;
UPDATE "public"."lyrics_dev" SET "lyric" = '(わかるー)', "lyric_col" = 2 WHERE "id" = 1940;
UPDATE "public"."lyrics_dev" SET "lyric" = '日々日々　輝き増してく' WHERE "id" = 1941;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もはや　太陽' WHERE "id" = 1942;
UPDATE "public"."lyrics_dev" SET "lyric" = '「あ゛～　好き」' WHERE "id" = 1943;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝説レベルで　尊いって！
好きが過ぎて　わけがわかんない' WHERE "id" = 1944;
UPDATE "public"."lyrics_dev" SET "lyric" = '日常　支障きたしてます
はい！推し　好き　(はぁ)しんどい！' WHERE "id" = 1945;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって　てててて　てぇてぇって！' WHERE "id" = 1946;
UPDATE "public"."lyrics_dev" SET "lyric" = '語彙力　終わってるよ' WHERE "id" = 1947;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もおーー！' WHERE "id" = 1949;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だいすき！(こっちゃん！)' WHERE "id" = 1950;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1951;
UPDATE "public"."lyrics_dev" SET "lyric" = '(なちこ！)', "lyric_col" = 2 WHERE "id" = 1952;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1953;
UPDATE "public"."lyrics_dev" SET "lyric" = '(しーちゃん！)', "lyric_col" = 2 WHERE "id" = 1954;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1955;
UPDATE "public"."lyrics_dev" SET "lyric" = '(きりちゃん！)', "lyric_col" = 2 WHERE "id" = 1956;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1957;
UPDATE "public"."lyrics_dev" SET "lyric" = '(りのまる！)', "lyric_col" = 2 WHERE "id" = 1958;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1959;
UPDATE "public"."lyrics_dev" SET "lyric" = '(なったん！)', "lyric_col" = 2 WHERE "id" = 1960;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1961;
UPDATE "public"."lyrics_dev" SET "lyric" = '(びびちゃん！)', "lyric_col" = 2 WHERE "id" = 1962;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！' WHERE "id" = 1964;
UPDATE "public"."lyrics_dev" SET "lyric" = '説明するね！　キュートアグレッションとは
かわいいものを見ることによって引き起こされる衝動的行動である。
かわいいと思った対象を噛んだりつまんだり
きつく抱きしめたい衝動を感じることがあるとされる。つまりは' WHERE "id" = 1965;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！
推し　好き　しんどい！' WHERE "id" = 1966;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！
推しが好きすぎて　しんどい！' WHERE "id" = 1967;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かと　シェアしたいけど' WHERE "id" = 1968;
UPDATE "public"."lyrics_dev" SET "lyric" = '解釈　揉めたくないしなあ', "lyric_col" = 1 WHERE "id" = 1969;
UPDATE "public"."lyrics_dev" SET "lyric" = '(こればっかりは)', "lyric_col" = 2 WHERE "id" = 1970;
UPDATE "public"."lyrics_dev" SET "lyric" = '君という　存在が私の' WHERE "id" = 1971;
UPDATE "public"."lyrics_dev" SET "lyric" = '生きてる　理由' WHERE "id" = 1972;
UPDATE "public"."lyrics_dev" SET "lyric" = '「あ゛～　優勝」' WHERE "id" = 1973;
UPDATE "public"."lyrics_dev" SET "lyric" = '宇宙クラスで　尊いって！
同じ時代　生きてる最高' WHERE "id" = 1974;
UPDATE "public"."lyrics_dev" SET "lyric" = '君次第の人生だ
もお！推し　好き　(はぁ)しんどい！' WHERE "id" = 1975;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって　てててて　てぇてぇって!' WHERE "id" = 1976;
UPDATE "public"."lyrics_dev" SET "lyric" = '偏差値3　くらいだよ' WHERE "id" = 1977;
UPDATE "public"."lyrics_dev" SET "lyric" = '全部　すっ飛ばし　最優先
君のこと　推してます' WHERE "id" = 1978;
UPDATE "public"."lyrics_dev" SET "lyric" = '痛いくらいに好き、て　ほんとにあるんだね' WHERE "id" = 1979;
UPDATE "public"."lyrics_dev" SET "lyric" = '初恋の100万倍　胸が痛いよ' WHERE "id" = 1980;
UPDATE "public"."lyrics_dev" SET "lyric" = '甘い底なし沼に　もっと溺れさせてね' WHERE "id" = 1981;
UPDATE "public"."lyrics_dev" SET "lyric" = '君で　いっぱいだから' WHERE "id" = 1982;
UPDATE "public"."lyrics_dev" SET "lyric" = '「てぇてぇ　てててて　てぇてぇてぇ」' WHERE "id" = 1983;
UPDATE "public"."lyrics_dev" SET "lyric" = '(※昨日よりももっと好きだよ)' WHERE "id" = 1984;
UPDATE "public"."lyrics_dev" SET "lyric" = '「てぇてぇ　てててて　てぇてぇてぇ」' WHERE "id" = 1985;
UPDATE "public"."lyrics_dev" SET "lyric" = '(※産まれてきてくれて　ありがとう)' WHERE "id" = 1986;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝説レベルで　尊いって！
好きが過ぎて　わけがわかんない' WHERE "id" = 1987;
UPDATE "public"."lyrics_dev" SET "lyric" = '日常　支障きたしてます
はい！推し　好き　(はぁ)しんどい！' WHERE "id" = 1988;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって　てててて　てぇてぇって！' WHERE "id" = 1989;
UPDATE "public"."lyrics_dev" SET "lyric" = '語彙力　終わってるよ' WHERE "id" = 1990;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もおーー！' WHERE "id" = 1992;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だいすき！(こっちゃん！)' WHERE "id" = 1993;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1994;
UPDATE "public"."lyrics_dev" SET "lyric" = '(なちこ！)', "lyric_col" = 2 WHERE "id" = 1995;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1996;
UPDATE "public"."lyrics_dev" SET "lyric" = '(しーちゃん！)', "lyric_col" = 2 WHERE "id" = 1997;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 1998;
UPDATE "public"."lyrics_dev" SET "lyric" = '(きりちゃん！)', "lyric_col" = 2 WHERE "id" = 1999;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 2000;
UPDATE "public"."lyrics_dev" SET "lyric" = '(りのまる！)', "lyric_col" = 2 WHERE "id" = 2001;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 2002;
UPDATE "public"."lyrics_dev" SET "lyric" = '(なったん！)', "lyric_col" = 2 WHERE "id" = 2003;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 2004;
UPDATE "public"."lyrics_dev" SET "lyric" = '(びびちゃん！)', "lyric_col" = 2 WHERE "id" = 2005;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し　好き　しんどい！
推し　好き　しんどい！' WHERE "id" = 2007;
UPDATE "public"."lyrics_dev" SET "lyric" = '推しが好きすぎて　しんどい！' WHERE "id" = 2008;

-- 未完な青春 (sounds_id=73): 8件
UPDATE "public"."lyrics_dev" SET "lyric" = '“逢いたくなる”　それだけで愛だよ' WHERE "id" = 5737;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 1 WHERE "id" = 5740;
UPDATE "public"."lyrics_dev" SET "lyric_col" = 2, "col_space" = 'full' WHERE "id" = 5741;
UPDATE "public"."lyrics_dev" SET "lyric" = '走れ！', "lyric_col" = 3 WHERE "id" = 5742;
UPDATE "public"."lyrics_dev" SET "lyric" = '世界はまるで宝箱の中', "lyric_col" = NULL WHERE "id" = 5744;
UPDATE "public"."lyrics_dev" SET "lyric" = '溢れる「LOVE YOU」', "lyric_col" = NULL WHERE "id" = 5745;
UPDATE "public"."lyrics_dev" SET "col_space" = 'full' WHERE "id" = 5748;
UPDATE "public"."lyrics_dev" SET "col_space" = NULL WHERE "id" = 5749;

-- 永遠Twilight (sounds_id=65): 4件
UPDATE "public"."lyrics_dev" SET "lyric" = '見上げる度に浮かぶのはそう', "lyric_col" = NULL WHERE "id" = 6079;
UPDATE "public"."lyrics_dev" SET "lyric" = '永遠にずっと同じこのTwilight', "lyric_col" = NULL WHERE "id" = 6080;
UPDATE "public"."lyrics_dev" SET "lyric" = '君を想うキモチは永遠にずっと消えない', "lyric_col" = NULL WHERE "id" = 6104;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あのTwilight', "lyric_col" = NULL WHERE "id" = 6105;
