-- FRUITS ZIPPER 歌詞成型 15曲分（書き写し漏れ・位置ズレ解消済みの17曲のうち、
-- サビ繰り返し構造で自動マッチングが複雑化するピポパポ・ぴゅあいんざわーるどの
-- 2曲は対象外。アルゴリズム改良後に別途対応予定）
-- 対象: lyrics_devのみ。本番lyricsへの反映は移行時まで保留。
-- かがみ等10曲分で検証済みのアルゴリズム（列位置ベースの文字ストリームマッチング）で生成。
-- 検証: 既存の10曲+CO-個性(計419+59行)に対して本アルゴリズムを再実行し、
-- 既に実行済み・正しいlyrics_devの値と完全一致することを確認済み。

-- sounds_id=6 JAM (65行)
UPDATE lyrics_dev SET lyric = 'let''s jam！', lyric_col = NULL, col_space = NULL WHERE id = 3874;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3875;
UPDATE lyrics_dev SET lyric = '果物不足の世界でも
欲しいタイプの甘さはある', lyric_col = NULL, col_space = NULL WHERE id = 3876;
UPDATE lyrics_dev SET lyric = 'そうして手にした宝物
ずっとそこに置いておきたいけど', lyric_col = NULL, col_space = NULL WHERE id = 3877;
UPDATE lyrics_dev SET lyric = '時々ちょっとめんどうな瞬間あったり
何が普通？or 平均？比べたりもして', lyric_col = NULL, col_space = NULL WHERE id = 3878;
UPDATE lyrics_dev SET lyric = '友達同士、知らないおしゃれをしてみたり
この手を離す日も来る
それまでは', lyric_col = NULL, col_space = NULL WHERE id = 3879;
UPDATE lyrics_dev SET lyric = '君にべったりしちゃったり
おしつけちゃうラベルとかも
確かめ合えれば、たぶんあり', lyric_col = NULL, col_space = NULL WHERE id = 3880;
UPDATE lyrics_dev SET lyric = 'ジャム選んだり、好き語ったり
そんな朝ごはん食べたら
はじめちゃいましょうか？', lyric_col = NULL, col_space = NULL WHERE id = 3881;
UPDATE lyrics_dev SET lyric = 'ねえここから世界へ', lyric_col = NULL, col_space = NULL WHERE id = 3882;
UPDATE lyrics_dev SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3883;
UPDATE lyrics_dev SET lyric = 'だって毎日、愛は生きてる、ご機嫌に', lyric_col = NULL, col_space = NULL WHERE id = 3884;
UPDATE lyrics_dev SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3885;
UPDATE lyrics_dev SET lyric = 'ふたり好きな歌、歌って', lyric_col = NULL, col_space = NULL WHERE id = 3886;
UPDATE lyrics_dev SET lyric = '(let''s jam)', lyric_col = NULL, col_space = NULL WHERE id = 3887;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3888;
UPDATE lyrics_dev SET lyric = '賞味期限のないラブです', lyric_col = NULL, col_space = NULL WHERE id = 3889;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3890;
UPDATE lyrics_dev SET lyric = 'でも少しはあせりたいです', lyric_col = NULL, col_space = NULL WHERE id = 3891;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3892;
UPDATE lyrics_dev SET lyric = '君にも世界にも、今ひとつ', lyric_col = NULL, col_space = NULL WHERE id = 3893;
UPDATE lyrics_dev SET lyric = '言っておかなきゃいけない', lyric_col = NULL, col_space = NULL WHERE id = 3894;
UPDATE lyrics_dev SET lyric = 'ねえ、どうしようか、それなら、', lyric_col = NULL, col_space = NULL WHERE id = 3895;
UPDATE lyrics_dev SET lyric = 'じゃあじゃあじゃあ 「君が好き」', lyric_col = NULL, col_space = NULL WHERE id = 3896;
UPDATE lyrics_dev SET lyric = '(let''s jam)', lyric_col = NULL, col_space = NULL WHERE id = 3897;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3898;
UPDATE lyrics_dev SET lyric = '情報多めな時代でも
なぜか目につく苦さがある', lyric_col = NULL, col_space = NULL WHERE id = 3899;
UPDATE lyrics_dev SET lyric = 'だけども見えない宝物
それが大事、忘れずいたいのに', lyric_col = NULL, col_space = NULL WHERE id = 3900;
UPDATE lyrics_dev SET lyric = '時々ちょっと煮詰まることとかあったり
それが普通？いやできない？比べたりもして', lyric_col = NULL, col_space = NULL WHERE id = 3901;
UPDATE lyrics_dev SET lyric = 'お隣同士だからズレたりもするけど
この手をつなぐ時には', lyric_col = NULL, col_space = NULL WHERE id = 3902;
UPDATE lyrics_dev SET lyric = 'やさしくね', lyric_col = NULL, col_space = NULL WHERE id = 3903;
UPDATE lyrics_dev SET lyric = '君にぴったりしちゃったり
無理を言っちゃうレベルとかも
愛の裏返し、てゆうか表', lyric_col = NULL, col_space = NULL WHERE id = 3904;
UPDATE lyrics_dev SET lyric = 'パフェ作ったり、チョコもあったり
ジャムっちゃうような幸せから
かみしめちゃいましょうか', lyric_col = NULL, col_space = NULL WHERE id = 3905;
UPDATE lyrics_dev SET lyric = '世界へ', lyric_col = NULL, col_space = NULL WHERE id = 3906;
UPDATE lyrics_dev SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3907;
UPDATE lyrics_dev SET lyric = 'だって毎日、愛が増えてく、ご機嫌に', lyric_col = NULL, col_space = NULL WHERE id = 3908;
UPDATE lyrics_dev SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3909;
UPDATE lyrics_dev SET lyric = 'みんな好きなダンス踊って、', lyric_col = NULL, col_space = NULL WHERE id = 3910;
UPDATE lyrics_dev SET lyric = '踊って！', lyric_col = NULL, col_space = NULL WHERE id = 3911;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3912;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3913;
UPDATE lyrics_dev SET lyric = 'せーの
YEAH！', lyric_col = NULL, col_space = NULL WHERE id = 3914;
UPDATE lyrics_dev SET lyric = 'ずっと大切にしてね', lyric_col = NULL, col_space = NULL WHERE id = 3915;
UPDATE lyrics_dev SET lyric = 'でもとっておきすぎないでね', lyric_col = NULL, col_space = NULL WHERE id = 3916;
UPDATE lyrics_dev SET lyric = 'もっといっぱい言ってね', lyric_col = NULL, col_space = NULL WHERE id = 3917;
UPDATE lyrics_dev SET lyric = 'でも使いすぎないでね', lyric_col = NULL, col_space = NULL WHERE id = 3918;
UPDATE lyrics_dev SET lyric = 'きっと明日も会えるね', lyric_col = NULL, col_space = NULL WHERE id = 3919;
UPDATE lyrics_dev SET lyric = 'でも明後日も会えるね', lyric_col = NULL, col_space = NULL WHERE id = 3920;
UPDATE lyrics_dev SET lyric = '今日も君に会えたら', lyric_col = NULL, col_space = NULL WHERE id = 3921;
UPDATE lyrics_dev SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3922;
UPDATE lyrics_dev SET lyric = 'だって毎日、愛は生きてる、ご機嫌に', lyric_col = NULL, col_space = NULL WHERE id = 3923;
UPDATE lyrics_dev SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby', lyric_col = NULL, col_space = NULL WHERE id = 3924;
UPDATE lyrics_dev SET lyric = 'ふたり好きな歌、歌って', lyric_col = NULL, col_space = NULL WHERE id = 3925;
UPDATE lyrics_dev SET lyric = '(let''s jam)', lyric_col = NULL, col_space = NULL WHERE id = 3926;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3927;
UPDATE lyrics_dev SET lyric = '賞味期限のないラブです', lyric_col = NULL, col_space = NULL WHERE id = 3928;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3929;
UPDATE lyrics_dev SET lyric = 'でも少しはあせりたいです', lyric_col = NULL, col_space = NULL WHERE id = 3930;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3931;
UPDATE lyrics_dev SET lyric = '君にも世界にも、今ひとつ', lyric_col = NULL, col_space = NULL WHERE id = 3932;
UPDATE lyrics_dev SET lyric = '言っておかなきゃいけない', lyric_col = NULL, col_space = NULL WHERE id = 3933;
UPDATE lyrics_dev SET lyric = 'ねえ、どうしようか、それなら、', lyric_col = NULL, col_space = NULL WHERE id = 3934;
UPDATE lyrics_dev SET lyric = 'じゃあじゃあじゃあ 「君が好き」', lyric_col = NULL, col_space = NULL WHERE id = 3935;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3936;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam
Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3937;
UPDATE lyrics_dev SET lyric = 'Ja ja ja ja la ja la jam', lyric_col = NULL, col_space = NULL WHERE id = 3938;
-- sounds_id=7 KawaiiってMagic (34行)
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3939;
UPDATE lyrics_dev SET lyric = 'つまずいても　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3940;
UPDATE lyrics_dev SET lyric = 'Kawaii Kawaii Kawaii', lyric_col = NULL, col_space = NULL WHERE id = 3941;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3942;
UPDATE lyrics_dev SET lyric = '手をつないで　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3943;
UPDATE lyrics_dev SET lyric = 'Ah-ah Kawaii KawaiiってMagicだわ', lyric_col = NULL, col_space = NULL WHERE id = 3944;
UPDATE lyrics_dev SET lyric = '夢をあきらめないで', lyric_col = NULL, col_space = NULL WHERE id = 3945;
UPDATE lyrics_dev SET lyric = '遠くても会おうよ　未来で', lyric_col = NULL, col_space = NULL WHERE id = 3946;
UPDATE lyrics_dev SET lyric = 'キラキラ光る空へ', lyric_col = NULL, col_space = NULL WHERE id = 3947;
UPDATE lyrics_dev SET lyric = '勇気のかけら集めて
いくよ (yeah)', lyric_col = NULL, col_space = NULL WHERE id = 3948;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3949;
UPDATE lyrics_dev SET lyric = 'つまずいても　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3950;
UPDATE lyrics_dev SET lyric = 'Kawaii Kawaii Kawaii', lyric_col = NULL, col_space = NULL WHERE id = 3951;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3952;
UPDATE lyrics_dev SET lyric = '手をつないで　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3953;
UPDATE lyrics_dev SET lyric = 'Ah-ah Kawaii KawaiiってMagicだわ', lyric_col = NULL, col_space = NULL WHERE id = 3954;
UPDATE lyrics_dev SET lyric = '夢をあきらめないで', lyric_col = NULL, col_space = NULL WHERE id = 3955;
UPDATE lyrics_dev SET lyric = 'いつかきっと　笑おう　未来で', lyric_col = NULL, col_space = NULL WHERE id = 3956;
UPDATE lyrics_dev SET lyric = 'パチパチ光る星で
勇気のかけら見つけて', lyric_col = NULL, col_space = NULL WHERE id = 3957;
UPDATE lyrics_dev SET lyric = 'Kawaii？ Kawaii？ Kawaii？', lyric_col = NULL, col_space = NULL WHERE id = 3958;
UPDATE lyrics_dev SET lyric = 'Kawaii？ Kawaii？ Kawaii？', lyric_col = NULL, col_space = NULL WHERE id = 3959;
UPDATE lyrics_dev SET lyric = '大丈夫？', lyric_col = NULL, col_space = NULL WHERE id = 3960;
UPDATE lyrics_dev SET lyric = '大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3961;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫
つまずいても　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3962;
UPDATE lyrics_dev SET lyric = 'Kawaii Kawaii Kawaii', lyric_col = NULL, col_space = NULL WHERE id = 3963;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫
手をつないで　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3964;
UPDATE lyrics_dev SET lyric = 'Ah-ah, kawaii, kawaii, kawaii (yeah)', lyric_col = NULL, col_space = NULL WHERE id = 3965;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫
つまずいても　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3966;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫', lyric_col = NULL, col_space = NULL WHERE id = 3967;
UPDATE lyrics_dev SET lyric = 'Kawaii KawaiiってMagicだわ', lyric_col = NULL, col_space = NULL WHERE id = 3968;
UPDATE lyrics_dev SET lyric = 'きっと大丈夫　大丈夫
手をつないで　涙 Bye-bye', lyric_col = NULL, col_space = NULL WHERE id = 3969;
UPDATE lyrics_dev SET lyric = 'Ah-ah Kawaii KawaiiってMagicだわ', lyric_col = NULL, col_space = NULL WHERE id = 3970;
UPDATE lyrics_dev SET lyric = 'Kawaii Kawaii Kawaii
Kawaii Kawaii Kawaii', lyric_col = NULL, col_space = NULL WHERE id = 3971;
UPDATE lyrics_dev SET lyric = 'Kawaii Kawaii Kawaii
Kawaii Kawaii Kawaii', lyric_col = NULL, col_space = NULL WHERE id = 3972;
-- sounds_id=17 うぇるかむとぅ〜ざ♡ふるっぱー！ (37行)
UPDATE lyrics_dev SET lyric = 'Say　ハロー！ 上々！ どんなんご所望？
うぇるかむとぅ～ざ FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3561;
UPDATE lyrics_dev SET lyric = '始まるストーリー　世界攻略！ さぁ、行こう！
やっぱ NEW KAWAII じゃない？', lyric_col = NULL, col_space = NULL WHERE id = 3562;
UPDATE lyrics_dev SET lyric = '「まずは優衣ちゃん！」', lyric_col = NULL, col_space = NULL WHERE id = 3563;
UPDATE lyrics_dev SET lyric = '5秒あれば　好きにさせます。
アイドルからの推し　目指してます。', lyric_col = NULL, col_space = NULL WHERE id = 3564;
UPDATE lyrics_dev SET lyric = 'あっちもこっちも　＃ゆいわずらい
10年前線！ 振りまいてるの　七福神スマイル', lyric_col = NULL, col_space = NULL WHERE id = 3565;
UPDATE lyrics_dev SET lyric = '「ゆいとデートしよ？」', lyric_col = NULL, col_space = NULL WHERE id = 3566;
UPDATE lyrics_dev SET lyric = '「つづいては、まなふぃ～！」', lyric_col = NULL, col_space = NULL WHERE id = 3567;
UPDATE lyrics_dev SET lyric = 'みてよ！ せくしぃ　あの子ダンシンクイーン
原宿ラブ　ガチなモンスターガール', lyric_col = NULL, col_space = NULL WHERE id = 3568;
UPDATE lyrics_dev SET lyric = 'マジ真面目すぎ？ あいさつ欠かさん！
ポニテ揺らして　本日もよろしく～？', lyric_col = NULL, col_space = NULL WHERE id = 3569;
UPDATE lyrics_dev SET lyric = '「おねがいっ...しまーーーす！」', lyric_col = NULL, col_space = NULL WHERE id = 3570;
UPDATE lyrics_dev SET lyric = 'Say　ハロー！ HARAJUKUへ行こう！
お好きに Pick It FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3571;
UPDATE lyrics_dev SET lyric = '超本気(まじ) なんです！ 燦然到来　あつまれ！
最強の七色じゃない？', lyric_col = NULL, col_space = NULL WHERE id = 3572;
UPDATE lyrics_dev SET lyric = '「末っ子登場！ ノエル～！」', lyric_col = NULL, col_space = NULL WHERE id = 3573;
UPDATE lyrics_dev SET lyric = '堂々最年少　ちゅるんとDOLLY EYES
気まぐれだね　ふんわりLIKE A CAT', lyric_col = NULL, col_space = NULL WHERE id = 3574;
UPDATE lyrics_dev SET lyric = 'マルチリンガル 多彩な才　ドイツエンジャパン
わぁ～るどワイドな末っ子ちゃん', lyric_col = NULL, col_space = NULL WHERE id = 3575;
UPDATE lyrics_dev SET lyric = '「I love you Guys～」', lyric_col = NULL, col_space = NULL WHERE id = 3576;
UPDATE lyrics_dev SET lyric = '「はいはい～お次は天音！」', lyric_col = NULL, col_space = NULL WHERE id = 3577;
UPDATE lyrics_dev SET lyric = '3度の飯　カラオケ　すき！
アイドルオタク　ステージだいすき！', lyric_col = NULL, col_space = NULL WHERE id = 3578;
UPDATE lyrics_dev SET lyric = 'サバサバなツンデレーション　実は涙もろいって
みんな知ってますか～！？', lyric_col = NULL, col_space = NULL WHERE id = 3579;
UPDATE lyrics_dev SET lyric = '「ラーメンもつ鍋、すいとーよ」', lyric_col = NULL, col_space = NULL WHERE id = 3580;
UPDATE lyrics_dev SET lyric = 'Say　ハロー！ 上々！ どんなんご所望？
うぇるかむとぅ～ざ FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3581;
UPDATE lyrics_dev SET lyric = '感じる？ パッション　愛心送信　とどけて！
全世界　魅せちゃうんじゃない？', lyric_col = NULL, col_space = NULL WHERE id = 3582;
UPDATE lyrics_dev SET lyric = '「おいで～かれん～！」', lyric_col = NULL, col_space = NULL WHERE id = 3583;
UPDATE lyrics_dev SET lyric = '泣き虫でも　めげない努力
妹気質？ 実は長女です！', lyric_col = NULL, col_space = NULL WHERE id = 3584;
UPDATE lyrics_dev SET lyric = 'マカロンボイスで奔走中
期待してね♪ すくすくまつかれ　成長中～！', lyric_col = NULL, col_space = NULL WHERE id = 3585;
UPDATE lyrics_dev SET lyric = '「はーい！ 一生懸命がんばりまーす」', lyric_col = NULL, col_space = NULL WHERE id = 3586;
UPDATE lyrics_dev SET lyric = '「せーの、やっぴー！るなぴー！」', lyric_col = NULL, col_space = NULL WHERE id = 3587;
UPDATE lyrics_dev SET lyric = 'みんなを照らす　パリピポジティブ
完璧主義で☆派手にGALピ', lyric_col = NULL, col_space = NULL WHERE id = 3588;
UPDATE lyrics_dev SET lyric = '人間国宝目指すの　ふるっぱー''s歌姫(ディーヴァ)
毎日　夏仕様のハッピネス', lyric_col = NULL, col_space = NULL WHERE id = 3589;
UPDATE lyrics_dev SET lyric = '「もっともーっと愛してぴーや！」', lyric_col = NULL, col_space = NULL WHERE id = 3590;
UPDATE lyrics_dev SET lyric = '「ラストは、おすず～！」', lyric_col = NULL, col_space = NULL WHERE id = 3591;
UPDATE lyrics_dev SET lyric = 'たらこLIP　超マイペース
宇宙規模に　引き寄せてる', lyric_col = NULL, col_space = NULL WHERE id = 3592;
UPDATE lyrics_dev SET lyric = '元気印をあげちゃう　みんなにパワー！
締めの一発ギャグ、おねがい～', lyric_col = NULL, col_space = NULL WHERE id = 3593;
UPDATE lyrics_dev SET lyric = '「フルーツ　ジーッ... (今私はあなたのの心をガン見しています) パァ！」', lyric_col = NULL, col_space = NULL WHERE id = 3594;
UPDATE lyrics_dev SET lyric = 'Say　ハロー！ HARAJUKUへ行こう！
お好きに Pick It FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3595;
UPDATE lyrics_dev SET lyric = 'ぜんぶ揃った　百果繚乱　カラふる
やっぱ NEW KAWAII じゃない？', lyric_col = NULL, col_space = NULL WHERE id = 3596;
UPDATE lyrics_dev SET lyric = '遊ぼうぜ Brand new world！', lyric_col = NULL, col_space = NULL WHERE id = 3597;
-- sounds_id=19 キミコイ (45行)
UPDATE lyrics_dev SET lyric = 'My sweet heart, my sweet heart,
lovely you are like a sunshine', lyric_col = NULL, col_space = NULL WHERE id = 3742;
UPDATE lyrics_dev SET lyric = '君を待っていた
そう　出会ってわかったんだ', lyric_col = NULL, col_space = NULL WHERE id = 3743;
UPDATE lyrics_dev SET lyric = '何もかも映えないエビデイ
突如　現れし王子様', lyric_col = NULL, col_space = NULL WHERE id = 3744;
UPDATE lyrics_dev SET lyric = '君が笑えば
「キュン！」ってハートがしゃべるんだ', lyric_col = NULL, col_space = NULL WHERE id = 3745;
UPDATE lyrics_dev SET lyric = 'きっと “すきぴ” や “推し” を
超えた運命的存在', lyric_col = NULL, col_space = NULL WHERE id = 3746;
UPDATE lyrics_dev SET lyric = '笑っちゃうくらいカラフルな
恋のフィルター越しの世界', lyric_col = NULL, col_space = NULL WHERE id = 3747;
UPDATE lyrics_dev SET lyric = 'Let''s share love', lyric_col = NULL, col_space = NULL WHERE id = 3748;
UPDATE lyrics_dev SET lyric = 'Let''s share love', lyric_col = NULL, col_space = NULL WHERE id = 3749;
UPDATE lyrics_dev SET lyric = '君と', lyric_col = NULL, col_space = NULL WHERE id = 3750;
UPDATE lyrics_dev SET lyric = '「ぜったい運命だよ！」', lyric_col = NULL, col_space = NULL WHERE id = 3751;
UPDATE lyrics_dev SET lyric = 'あふれだす　あふれだす
巡り会えた喜びが', lyric_col = NULL, col_space = NULL WHERE id = 3752;
UPDATE lyrics_dev SET lyric = '好きすぎる', lyric_col = NULL, col_space = NULL WHERE id = 3753;
UPDATE lyrics_dev SET lyric = '愛しすぎる', lyric_col = NULL, col_space = NULL WHERE id = 3754;
UPDATE lyrics_dev SET lyric = 'これって…神様！？', lyric_col = NULL, col_space = NULL WHERE id = 3755;
UPDATE lyrics_dev SET lyric = '24時を回っても
解けない魔法があるよ', lyric_col = NULL, col_space = NULL WHERE id = 3756;
UPDATE lyrics_dev SET lyric = '超バズしちゃうくらい
あちあちな恋をしよう', lyric_col = NULL, col_space = NULL WHERE id = 3757;
UPDATE lyrics_dev SET lyric = 'Destiny love', lyric_col = NULL, col_space = NULL WHERE id = 3758;
UPDATE lyrics_dev SET lyric = '好きバレしてもシェアしたい
脳内でリピってるラブソング', lyric_col = NULL, col_space = NULL WHERE id = 3759;
UPDATE lyrics_dev SET lyric = 'Let''s share love', lyric_col = NULL, col_space = NULL WHERE id = 3760;
UPDATE lyrics_dev SET lyric = 'Let''s share love', lyric_col = NULL, col_space = NULL WHERE id = 3761;
UPDATE lyrics_dev SET lyric = '君と', lyric_col = NULL, col_space = NULL WHERE id = 3762;
UPDATE lyrics_dev SET lyric = '「ねぇ、ちゃんと目見て？」', lyric_col = NULL, col_space = NULL WHERE id = 3763;
UPDATE lyrics_dev SET lyric = 'あふれだす　あふれだす
見つめ合えばドキドキが', lyric_col = NULL, col_space = NULL WHERE id = 3764;
UPDATE lyrics_dev SET lyric = '祝福の', lyric_col = 1, col_space = NULL WHERE id = 3765;
UPDATE lyrics_dev SET lyric = '鐘のように', lyric_col = 2, col_space = NULL WHERE id = 3766;
UPDATE lyrics_dev SET lyric = 'Ding Dong
ハピネスじゃん！', lyric_col = 3, col_space = NULL WHERE id = 3767;
UPDATE lyrics_dev SET lyric = '24時間経ってもずっと　消えないストーリーだよ', lyric_col = NULL, col_space = NULL WHERE id = 3768;
UPDATE lyrics_dev SET lyric = '君だけのあしあと
尊くて心でスクショした', lyric_col = NULL, col_space = NULL WHERE id = 3769;
UPDATE lyrics_dev SET lyric = '運命は決められた物語じゃなく
愛する強さの名前', lyric_col = NULL, col_space = NULL WHERE id = 3770;
UPDATE lyrics_dev SET lyric = 'だから赤い糸や
ガラスの靴が　なくたって見つけ合えたんだ', lyric_col = NULL, col_space = NULL WHERE id = 3771;
UPDATE lyrics_dev SET lyric = 'もう私を離さないで', lyric_col = NULL, col_space = NULL WHERE id = 3772;
UPDATE lyrics_dev SET lyric = 'あふれだす　あふれだす
想いを今　届けよう', lyric_col = NULL, col_space = NULL WHERE id = 3773;
UPDATE lyrics_dev SET lyric = '好きすぎる', lyric_col = NULL, col_space = NULL WHERE id = 3774;
UPDATE lyrics_dev SET lyric = '愛しすぎる', lyric_col = NULL, col_space = NULL WHERE id = 3775;
UPDATE lyrics_dev SET lyric = 'あれれ？はにかんだ？', lyric_col = NULL, col_space = NULL WHERE id = 3776;
UPDATE lyrics_dev SET lyric = '100年後も　きっと来世も
好きだと言い切れるよ', lyric_col = NULL, col_space = NULL WHERE id = 3777;
UPDATE lyrics_dev SET lyric = '「一瞬」も「永遠」も', lyric_col = NULL, col_space = NULL WHERE id = 3778;
UPDATE lyrics_dev SET lyric = '君にだけ恋をしよう', lyric_col = NULL, col_space = NULL WHERE id = 3779;
UPDATE lyrics_dev SET lyric = 'Destiny love', lyric_col = NULL, col_space = NULL WHERE id = 3780;
UPDATE lyrics_dev SET lyric = 'My sweet heart, my sweet heart,
Lovely you are like a sunshine', lyric_col = NULL, col_space = NULL WHERE id = 3781;
UPDATE lyrics_dev SET lyric = 'My sweet heart, my sweet heart,
lovely Destiny lover', lyric_col = NULL, col_space = NULL WHERE id = 3782;
UPDATE lyrics_dev SET lyric = 'My sweet heart, my sweet heart,', lyric_col = NULL, col_space = NULL WHERE id = 3783;
UPDATE lyrics_dev SET lyric = 'lovely you are like a moonlight', lyric_col = NULL, col_space = NULL WHERE id = 3784;
UPDATE lyrics_dev SET lyric = 'My sweet heart, my sweet heart,', lyric_col = NULL, col_space = NULL WHERE id = 3785;
UPDATE lyrics_dev SET lyric = 'lovely Destiny lover', lyric_col = NULL, col_space = NULL WHERE id = 3786;
-- sounds_id=20 さん (29行)
UPDATE lyrics_dev SET lyric = '君のこと昨日より少しだけ
丁寧に呼んでみたら', lyric_col = NULL, col_space = NULL WHERE id = 1621;
UPDATE lyrics_dev SET lyric = 'なんだか幸せになりました', lyric_col = NULL, col_space = NULL WHERE id = 1622;
UPDATE lyrics_dev SET lyric = '日曜日、もちろん楽しみだけど
今日もみんな呼んでるから', lyric_col = NULL, col_space = NULL WHERE id = 1623;
UPDATE lyrics_dev SET lyric = 'なんだか幸せになりました', lyric_col = NULL, col_space = NULL WHERE id = 1624;
UPDATE lyrics_dev SET lyric = '天気予報に並んだ
傘を数えるよりも', lyric_col = NULL, col_space = NULL WHERE id = 1625;
UPDATE lyrics_dev SET lyric = '一緒に見上げてみたらさ
あたたかい', lyric_col = NULL, col_space = NULL WHERE id = 1626;
UPDATE lyrics_dev SET lyric = 'みんな
さんさんさんなんです
太陽です', lyric_col = NULL, col_space = NULL WHERE id = 1627;
UPDATE lyrics_dev SET lyric = '笑顔とか、笑い声だって', lyric_col = NULL, col_space = NULL WHERE id = 1628;
UPDATE lyrics_dev SET lyric = '歌おう
さんさんさんなんです
大切です', lyric_col = NULL, col_space = NULL WHERE id = 1629;
UPDATE lyrics_dev SET lyric = '人が人を、君が君を、輝かせるよ', lyric_col = NULL, col_space = NULL WHERE id = 1630;
UPDATE lyrics_dev SET lyric = 'ほんとありがとさん', lyric_col = NULL, col_space = NULL WHERE id = 1631;
UPDATE lyrics_dev SET lyric = '二人でもほんと嬉しいけれど
もう一人誘ってみたら', lyric_col = NULL, col_space = NULL WHERE id = 1632;
UPDATE lyrics_dev SET lyric = 'なんだか幸せになりました', lyric_col = NULL, col_space = NULL WHERE id = 1633;
UPDATE lyrics_dev SET lyric = 'いつの日か、家族が増えたりして
そんな想像してみたら', lyric_col = NULL, col_space = NULL WHERE id = 1634;
UPDATE lyrics_dev SET lyric = 'なんだか幸せになりました', lyric_col = NULL, col_space = NULL WHERE id = 1635;
UPDATE lyrics_dev SET lyric = '天気予報のすぐ後
占いがちょっときびしい', lyric_col = NULL, col_space = NULL WHERE id = 1636;
UPDATE lyrics_dev SET lyric = 'そんなときもこの世界は
あたたかい', lyric_col = NULL, col_space = NULL WHERE id = 1637;
UPDATE lyrics_dev SET lyric = 'みんな
さんさんさんなんです
太陽です', lyric_col = NULL, col_space = NULL WHERE id = 1638;
UPDATE lyrics_dev SET lyric = '素顔とか、小さな声だって', lyric_col = NULL, col_space = NULL WHERE id = 1639;
UPDATE lyrics_dev SET lyric = '歌おう
さんさんさんなんです
ＯＫです', lyric_col = NULL, col_space = NULL WHERE id = 1640;
UPDATE lyrics_dev SET lyric = '人が人を、君が君を、認めていくよ', lyric_col = NULL, col_space = NULL WHERE id = 1641;
UPDATE lyrics_dev SET lyric = 'ほんとありがとさん', lyric_col = NULL, col_space = NULL WHERE id = 1642;
UPDATE lyrics_dev SET lyric = 'みんな
さんさんさんなんです
太陽です', lyric_col = NULL, col_space = NULL WHERE id = 1643;
UPDATE lyrics_dev SET lyric = '笑顔とか、笑い声だって', lyric_col = NULL, col_space = NULL WHERE id = 1644;
UPDATE lyrics_dev SET lyric = 'みんな
さんさんさんなんです
太陽です', lyric_col = NULL, col_space = NULL WHERE id = 1645;
UPDATE lyrics_dev SET lyric = '素顔とか、小さな声だって', lyric_col = NULL, col_space = NULL WHERE id = 1646;
UPDATE lyrics_dev SET lyric = '歌おう
さんさんさんなんです
大切です', lyric_col = NULL, col_space = NULL WHERE id = 1647;
UPDATE lyrics_dev SET lyric = '人が人を、君が君を、輝かせるよ', lyric_col = NULL, col_space = NULL WHERE id = 1648;
UPDATE lyrics_dev SET lyric = 'ほんとありがとさん', lyric_col = NULL, col_space = NULL WHERE id = 1649;
-- sounds_id=23 ずっと、ずっと、ずっと！ (40行)
UPDATE lyrics_dev SET lyric = 'とまらない
切ないほどに　いとおしい
アイの告白(メロディー)', lyric_col = NULL, col_space = NULL WHERE id = 3702;
UPDATE lyrics_dev SET lyric = '「わたしだけ、きゅんっとさせてよ！」 って…まだ、隠したまま', lyric_col = NULL, col_space = NULL WHERE id = 3703;
UPDATE lyrics_dev SET lyric = '雪　のち　恋予報
キラキラ眩しく光るんだって', lyric_col = NULL, col_space = NULL WHERE id = 3704;
UPDATE lyrics_dev SET lyric = '言えない気持ちと　ねぇ', lyric_col = 1, col_space = NULL WHERE id = 3705;
UPDATE lyrics_dev SET lyric = '同じくらい', lyric_col = 2, col_space = 'full' WHERE id = 3706;
UPDATE lyrics_dev SET lyric = 'しゅんっと消えちゃうんだって', lyric_col = 3, col_space = 'full' WHERE id = 3707;
UPDATE lyrics_dev SET lyric = '「そんなん...だめっ！」', lyric_col = NULL, col_space = NULL WHERE id = 3708;
UPDATE lyrics_dev SET lyric = 'あと 3cmくらい？', lyric_col = NULL, col_space = NULL WHERE id = 3709;
UPDATE lyrics_dev SET lyric = 'ふたりの距離　もう溶かしたいよ', lyric_col = NULL, col_space = NULL WHERE id = 3710;
UPDATE lyrics_dev SET lyric = 'ぴったりひっついて', lyric_col = NULL, col_space = NULL WHERE id = 3711;
UPDATE lyrics_dev SET lyric = 'キミ。', lyric_col = 1, col_space = NULL WHERE id = 3712;
UPDATE lyrics_dev SET lyric = '体温　感じたいの', lyric_col = 2, col_space = NULL WHERE id = 3713;
UPDATE lyrics_dev SET lyric = '「だいじょぶ？ 寒くないの？」って意識してない？ TT みたい急接近ですっ', lyric_col = NULL, col_space = NULL WHERE id = 3714;
UPDATE lyrics_dev SET lyric = '顔もみれない', lyric_col = NULL, col_space = NULL WHERE id = 3715;
UPDATE lyrics_dev SET lyric = '困らせてばっかじゃ
どうしよう　これ以上', lyric_col = NULL, col_space = NULL WHERE id = 3716;
UPDATE lyrics_dev SET lyric = 'ずっと　ずっと　前から　ずっと　ずっと　ずっと
キミが...好きでしたっ！', lyric_col = NULL, col_space = NULL WHERE id = 3717;
UPDATE lyrics_dev SET lyric = 'その瞳(め)でぎゅっと　染められちゃってみたいの', lyric_col = NULL, col_space = NULL WHERE id = 3718;
UPDATE lyrics_dev SET lyric = 'ドキドキがゆずれない「わたしだけ見て！」', lyric_col = NULL, col_space = NULL WHERE id = 3719;
UPDATE lyrics_dev SET lyric = 'KOI・SHI・TE・RU ベイビー！ MY LOVE', lyric_col = NULL, col_space = NULL WHERE id = 3720;
UPDATE lyrics_dev SET lyric = 'なんて　妄想するだけの未来？', lyric_col = 1, col_space = NULL WHERE id = 3721;
UPDATE lyrics_dev SET lyric = '気づいてくれないかなぁ', lyric_col = 2, col_space = 'half' WHERE id = 3722;
UPDATE lyrics_dev SET lyric = '長いまつ毛と', lyric_col = 1, col_space = NULL WHERE id = 3723;
UPDATE lyrics_dev SET lyric = 'あざといリップの女友達(あのこたち)', lyric_col = 2, col_space = 'full' WHERE id = 3724;
UPDATE lyrics_dev SET lyric = '先越されたらNO...こっち向いてよ！', lyric_col = NULL, col_space = NULL WHERE id = 3725;
UPDATE lyrics_dev SET lyric = '鈍感過ぎ！ でも好き', lyric_col = 1, col_space = NULL WHERE id = 3726;
UPDATE lyrics_dev SET lyric = '不意打ち　どきゅん', lyric_col = 2, col_space = 'full' WHERE id = 3727;
UPDATE lyrics_dev SET lyric = 'バキュン！', lyric_col = 3, col_space = 'full' WHERE id = 3728;
UPDATE lyrics_dev SET lyric = '狙い撃ちですっ', lyric_col = 4, col_space = 'half' WHERE id = 3729;
UPDATE lyrics_dev SET lyric = 'ほんと...今夜も眠れない', lyric_col = NULL, col_space = NULL WHERE id = 3730;
UPDATE lyrics_dev SET lyric = 'テンション！', lyric_col = 1, col_space = NULL WHERE id = 3731;
UPDATE lyrics_dev SET lyric = 'どんどん高鳴ってる', lyric_col = 2, col_space = 'half' WHERE id = 3732;
UPDATE lyrics_dev SET lyric = '純真！', lyric_col = 1, col_space = NULL WHERE id = 3733;
UPDATE lyrics_dev SET lyric = '輝いて舞い降りたんだ「大好き。」が　もう少し....近くで', lyric_col = 2, col_space = 'half' WHERE id = 3734;
UPDATE lyrics_dev SET lyric = '勇気をください
心に積もる　あまいあまい　このキモチに', lyric_col = NULL, col_space = NULL WHERE id = 3735;
UPDATE lyrics_dev SET lyric = '嘘はつけないの　もうすぐ　溢れちゃいそうだ！', lyric_col = NULL, col_space = NULL WHERE id = 3736;
UPDATE lyrics_dev SET lyric = 'ずっと　ずっと　前から　ずっと　ずっと　ずっと
キミが...好きでしたっ！', lyric_col = NULL, col_space = NULL WHERE id = 3737;
UPDATE lyrics_dev SET lyric = 'その手で　ぎゅっと　抱きしめられてみたいの', lyric_col = NULL, col_space = NULL WHERE id = 3738;
UPDATE lyrics_dev SET lyric = 'ドキドキがゆずれない「わたしだけ見て！」', lyric_col = NULL, col_space = NULL WHERE id = 3739;
UPDATE lyrics_dev SET lyric = 'AI・SHI・TE・RU べイビー！ MY LOVE', lyric_col = NULL, col_space = NULL WHERE id = 3740;
UPDATE lyrics_dev SET lyric = 'なんて　想像してるだけじゃない
伝えるよ　今　“アイラブユー”', lyric_col = NULL, col_space = NULL WHERE id = 3741;
-- sounds_id=25 ハートのローラーコースター (57行)
UPDATE lyrics_dev SET lyric = '誰かが泣きそうな夜は', lyric_col = NULL, col_space = NULL WHERE id = 3645;
UPDATE lyrics_dev SET lyric = '満天の星をそっと届けてあげよう', lyric_col = NULL, col_space = NULL WHERE id = 3646;
UPDATE lyrics_dev SET lyric = '未来へ描く軌跡は', lyric_col = 1, col_space = NULL WHERE id = 3647;
UPDATE lyrics_dev SET lyric = '(Shooting Stars)', lyric_col = 2, col_space = 'half' WHERE id = 3648;
UPDATE lyrics_dev SET lyric = '波打つ　ハートのローラーコースター|', lyric_col = NULL, col_space = NULL WHERE id = 3649;
UPDATE lyrics_dev SET lyric = 'La la la la 走れ', lyric_col = NULL, col_space = NULL WHERE id = 3650;
UPDATE lyrics_dev SET lyric = 'La la どこまでも', lyric_col = NULL, col_space = NULL WHERE id = 3651;
UPDATE lyrics_dev SET lyric = 'La la la la 先へ', lyric_col = NULL, col_space = NULL WHERE id = 3652;
UPDATE lyrics_dev SET lyric = '繋がる光', lyric_col = NULL, col_space = NULL WHERE id = 3653;
UPDATE lyrics_dev SET lyric = 'La la la la 進め', lyric_col = NULL, col_space = NULL WHERE id = 3654;
UPDATE lyrics_dev SET lyric = 'La la どこへでも', lyric_col = NULL, col_space = NULL WHERE id = 3655;
UPDATE lyrics_dev SET lyric = 'La la la la 行こう', lyric_col = NULL, col_space = NULL WHERE id = 3656;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER！！ YEAH！！', lyric_col = NULL, col_space = NULL WHERE id = 3657;
UPDATE lyrics_dev SET lyric = '急展開でもオーライ', lyric_col = NULL, col_space = NULL WHERE id = 3658;
UPDATE lyrics_dev SET lyric = '喜怒哀楽　気分', lyric_col = 1, col_space = NULL WHERE id = 3659;
UPDATE lyrics_dev SET lyric = 'Up and Down', lyric_col = 2, col_space = NULL WHERE id = 3660;
UPDATE lyrics_dev SET lyric = '物語の途中じゃん！？', lyric_col = NULL, col_space = NULL WHERE id = 3661;
UPDATE lyrics_dev SET lyric = '楽しむチャンス！？', lyric_col = NULL, col_space = NULL WHERE id = 3662;
UPDATE lyrics_dev SET lyric = 'Take it easyだって', lyric_col = NULL, col_space = NULL WHERE id = 3663;
UPDATE lyrics_dev SET lyric = '奇想天外', lyric_col = 1, col_space = NULL WHERE id = 3664;
UPDATE lyrics_dev SET lyric = 'is サプライズ', lyric_col = 2, col_space = 'half' WHERE id = 3665;
UPDATE lyrics_dev SET lyric = 'ドキドキしちゃうほど自由に旅したい', lyric_col = NULL, col_space = NULL WHERE id = 3666;
UPDATE lyrics_dev SET lyric = 'ルールなんて決めたら', lyric_col = NULL, col_space = NULL WHERE id = 3667;
UPDATE lyrics_dev SET lyric = 'NONO', lyric_col = NULL, col_space = NULL WHERE id = 3668;
UPDATE lyrics_dev SET lyric = '思い切り叫べよ', lyric_col = NULL, col_space = NULL WHERE id = 3669;
UPDATE lyrics_dev SET lyric = 'せーの', lyric_col = NULL, col_space = NULL WHERE id = 3670;
UPDATE lyrics_dev SET lyric = 'はい！ はい！ はい！', lyric_col = NULL, col_space = NULL WHERE id = 3671;
UPDATE lyrics_dev SET lyric = 'もっと', lyric_col = NULL, col_space = NULL WHERE id = 3672;
UPDATE lyrics_dev SET lyric = 'はい！ はい！ はい！', lyric_col = NULL, col_space = NULL WHERE id = 3673;
UPDATE lyrics_dev SET lyric = 'To the next→', lyric_col = NULL, col_space = NULL WHERE id = 3674;
UPDATE lyrics_dev SET lyric = 'クールだって決めつけないで', lyric_col = NULL, col_space = NULL WHERE id = 3675;
UPDATE lyrics_dev SET lyric = 'エンジンは全開', lyric_col = NULL, col_space = NULL WHERE id = 3676;
UPDATE lyrics_dev SET lyric = 'Let''s Gol', lyric_col = NULL, col_space = NULL WHERE id = 3677;
UPDATE lyrics_dev SET lyric = 'はい！ はい！ はい！', lyric_col = NULL, col_space = NULL WHERE id = 3678;
UPDATE lyrics_dev SET lyric = 'もっと', lyric_col = NULL, col_space = NULL WHERE id = 3679;
UPDATE lyrics_dev SET lyric = 'はい！ はい！ はい！', lyric_col = NULL, col_space = NULL WHERE id = 3680;
UPDATE lyrics_dev SET lyric = '大変よくできました
がんばってるキミの笑顔', lyric_col = NULL, col_space = NULL WHERE id = 3681;
UPDATE lyrics_dev SET lyric = '守ってあげたいな', lyric_col = NULL, col_space = NULL WHERE id = 3682;
UPDATE lyrics_dev SET lyric = '幾千の可能性を超えて', lyric_col = NULL, col_space = NULL WHERE id = 3683;
UPDATE lyrics_dev SET lyric = 'キミを連れて行くよ', lyric_col = NULL, col_space = NULL WHERE id = 3684;
UPDATE lyrics_dev SET lyric = 'どこまでも行ける', lyric_col = 1, col_space = NULL WHERE id = 3685;
UPDATE lyrics_dev SET lyric = 'どこへでも行ける', lyric_col = 2, col_space = 'full' WHERE id = 3686;
UPDATE lyrics_dev SET lyric = '遥か彼方へ', lyric_col = 1, col_space = NULL WHERE id = 3687;
UPDATE lyrics_dev SET lyric = '続く', lyric_col = 2, col_space = 'full' WHERE id = 3688;
UPDATE lyrics_dev SET lyric = 'ハートのローラーコースター', lyric_col = NULL, col_space = NULL WHERE id = 3689;
UPDATE lyrics_dev SET lyric = 'La la la la 走れ', lyric_col = NULL, col_space = NULL WHERE id = 3690;
UPDATE lyrics_dev SET lyric = 'La la どこまでも', lyric_col = NULL, col_space = NULL WHERE id = 3691;
UPDATE lyrics_dev SET lyric = 'La la la la 先へ', lyric_col = NULL, col_space = NULL WHERE id = 3692;
UPDATE lyrics_dev SET lyric = '繋がる光', lyric_col = NULL, col_space = NULL WHERE id = 3693;
UPDATE lyrics_dev SET lyric = 'La la la la 進め', lyric_col = NULL, col_space = NULL WHERE id = 3694;
UPDATE lyrics_dev SET lyric = 'La la どこへでも', lyric_col = NULL, col_space = NULL WHERE id = 3695;
UPDATE lyrics_dev SET lyric = 'La la la la 行こう', lyric_col = NULL, col_space = NULL WHERE id = 3696;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3697;
UPDATE lyrics_dev SET lyric = '誰かが泣きそうな夜は
満天の星を　そっと届けてあげよう', lyric_col = NULL, col_space = NULL WHERE id = 3698;
UPDATE lyrics_dev SET lyric = '未来へ描く軌跡は', lyric_col = 1, col_space = NULL WHERE id = 3699;
UPDATE lyrics_dev SET lyric = '(Shooting Stars)', lyric_col = 2, col_space = 'half' WHERE id = 3700;
UPDATE lyrics_dev SET lyric = '波打つ　ハートのローラーコースター', lyric_col = NULL, col_space = NULL WHERE id = 3701;
-- sounds_id=27 ハピチョコ (48行)
UPDATE lyrics_dev SET lyric = 'はっぴー新年
そろそろ考えなくちゃ', lyric_col = NULL, col_space = NULL WHERE id = 892;
UPDATE lyrics_dev SET lyric = 'みんながちょっとうるさいし
まずは作戦会議', lyric_col = NULL, col_space = NULL WHERE id = 893;
UPDATE lyrics_dev SET lyric = 'おっけー元年
今からはじまる
ラブストーリーとか、', lyric_col = 1, col_space = NULL WHERE id = 894;
UPDATE lyrics_dev SET lyric = 'そんなんじゃないし
本命なんだし', lyric_col = 2, col_space = NULL WHERE id = 895;
UPDATE lyrics_dev SET lyric = '今日が本番なんてうそうそ
大事なのはここから一ヶ月でじれったいな', lyric_col = NULL, col_space = NULL WHERE id = 896;
UPDATE lyrics_dev SET lyric = '大人になったって、', lyric_col = 1, col_space = NULL WHERE id = 897;
UPDATE lyrics_dev SET lyric = 'ドキドキしてたいもんだって', lyric_col = 2, col_space = NULL WHERE id = 898;
UPDATE lyrics_dev SET lyric = '両思いの先払い', lyric_col = NULL, col_space = NULL WHERE id = 899;
UPDATE lyrics_dev SET lyric = 'うんっとっ', lyric_col = NULL, col_space = NULL WHERE id = 900;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまいの
すきすきすきすき', lyric_col = NULL, col_space = NULL WHERE id = 901;
UPDATE lyrics_dev SET lyric = 'っていう私が選んだ君はとびきりのスイート', lyric_col = NULL, col_space = NULL WHERE id = 902;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまい
一年で', lyric_col = 1, col_space = NULL WHERE id = 903;
UPDATE lyrics_dev SET lyric = '一番の贅沢でもしちゃいましょうよ', lyric_col = 2, col_space = NULL WHERE id = 904;
UPDATE lyrics_dev SET lyric = 'ちょっちょちょっと
ちょこっとは', lyric_col = 1, col_space = NULL WHERE id = 905;
UPDATE lyrics_dev SET lyric = '予算とカロリーとかはオーバーでもね', lyric_col = 2, col_space = NULL WHERE id = 906;
UPDATE lyrics_dev SET lyric = 'ちょっちょちょっとチョコレート、', lyric_col = NULL, col_space = NULL WHERE id = 907;
UPDATE lyrics_dev SET lyric = 'わたしの恋とかに
ごほうびをあげたい', lyric_col = NULL, col_space = NULL WHERE id = 908;
UPDATE lyrics_dev SET lyric = 'もう今日だって！
だいたいは決めました', lyric_col = NULL, col_space = NULL WHERE id = 909;
UPDATE lyrics_dev SET lyric = 'ご自宅用ですか？
ってなんでわかったの？', lyric_col = NULL, col_space = NULL WHERE id = 910;
UPDATE lyrics_dev SET lyric = 'そうでもやっぱ
みんなそわそわしちゃうの
そりゃそうだけどね、', lyric_col = 1, col_space = NULL WHERE id = 911;
UPDATE lyrics_dev SET lyric = '余裕見せたら
それも変かな', lyric_col = 2, col_space = NULL WHERE id = 912;
UPDATE lyrics_dev SET lyric = 'ねえ呼び出しなんてなになに？
きょうのところは帰って楽しみたいのにな', lyric_col = NULL, col_space = NULL WHERE id = 913;
UPDATE lyrics_dev SET lyric = 'でもあれわたしが、', lyric_col = 1, col_space = NULL WHERE id = 914;
UPDATE lyrics_dev SET lyric = 'ほしかったかわいいやつじゃない？', lyric_col = 2, col_space = NULL WHERE id = 915;
UPDATE lyrics_dev SET lyric = '気になる、これ片思い？', lyric_col = NULL, col_space = NULL WHERE id = 916;
UPDATE lyrics_dev SET lyric = 'まって', lyric_col = NULL, col_space = NULL WHERE id = 917;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまいの
すきすきすきすき', lyric_col = NULL, col_space = NULL WHERE id = 918;
UPDATE lyrics_dev SET lyric = 'そんなわたしにあなたがくれたとびきりのサプライズ', lyric_col = NULL, col_space = NULL WHERE id = 919;
UPDATE lyrics_dev SET lyric = 'やばいやばいやばいやばい
そんなこと', lyric_col = 1, col_space = NULL WHERE id = 920;
UPDATE lyrics_dev SET lyric = '想像もしてなかったの、眠れないね', lyric_col = 2, col_space = NULL WHERE id = 921;
UPDATE lyrics_dev SET lyric = '一ヶ月も悩むなんて
そんなの無理じゃない？', lyric_col = NULL, col_space = NULL WHERE id = 922;
UPDATE lyrics_dev SET lyric = '私、毎日が本命全力
そういうのが好きでごめん', lyric_col = NULL, col_space = NULL WHERE id = 923;
UPDATE lyrics_dev SET lyric = 'うんっとっ', lyric_col = NULL, col_space = NULL WHERE id = 924;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまいの', lyric_col = NULL, col_space = NULL WHERE id = 925;
UPDATE lyrics_dev SET lyric = 'すきすきすきすき', lyric_col = NULL, col_space = NULL WHERE id = 926;
UPDATE lyrics_dev SET lyric = 'っていう私が選んだ君はとびきりのスイート', lyric_col = NULL, col_space = NULL WHERE id = 927;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまい
一年で', lyric_col = 1, col_space = NULL WHERE id = 928;
UPDATE lyrics_dev SET lyric = '一番の贅沢でもしよ', lyric_col = 2, col_space = NULL WHERE id = 929;
UPDATE lyrics_dev SET lyric = 'うんっとっ
あまいあまいあまいあまいの', lyric_col = NULL, col_space = NULL WHERE id = 930;
UPDATE lyrics_dev SET lyric = 'すきすきすきすき', lyric_col = NULL, col_space = NULL WHERE id = 931;
UPDATE lyrics_dev SET lyric = 'っていう私が選んだ君はとびきりのスイート', lyric_col = NULL, col_space = NULL WHERE id = 932;
UPDATE lyrics_dev SET lyric = 'あまいあまいあまいあまい
一年で', lyric_col = 1, col_space = NULL WHERE id = 933;
UPDATE lyrics_dev SET lyric = '一番の贅沢でもしちゃいましょうよ', lyric_col = 2, col_space = NULL WHERE id = 934;
UPDATE lyrics_dev SET lyric = 'ちょっちょちょっと
ちょこっとは', lyric_col = 1, col_space = NULL WHERE id = 935;
UPDATE lyrics_dev SET lyric = '予算とカロリーとかはオーバーでもね', lyric_col = 2, col_space = NULL WHERE id = 936;
UPDATE lyrics_dev SET lyric = 'ちょっちょちょっとチョコレート、', lyric_col = NULL, col_space = NULL WHERE id = 937;
UPDATE lyrics_dev SET lyric = 'わたしの恋とかに
ごほうびをあげたい', lyric_col = NULL, col_space = NULL WHERE id = 938;
UPDATE lyrics_dev SET lyric = 'わたしの今日からに
ごほうびをあげたい', lyric_col = NULL, col_space = NULL WHERE id = 939;
-- sounds_id=32 ふるっぱーりー！ (46行)
UPDATE lyrics_dev SET lyric = 'Yeah! Yeah! Yeah! Yeah! Yeah! Yeah!', lyric_col = NULL, col_space = NULL WHERE id = 3599;
UPDATE lyrics_dev SET lyric = 'Ladies and gentlemen!
原宿 new kawaii スタイル
It''s showtime!', lyric_col = NULL, col_space = NULL WHERE id = 3600;
UPDATE lyrics_dev SET lyric = 'Are you ready!', lyric_col = NULL, col_space = NULL WHERE id = 3601;
UPDATE lyrics_dev SET lyric = 'We are the7人 ウワサの kawaii
ところかまわず騒がします sorry!', lyric_col = NULL, col_space = NULL WHERE id = 3602;
UPDATE lyrics_dev SET lyric = 'フロム 原宿 レペゼン カワラボ
うちらが一番アゲちゃうってこと
気づいてる?', lyric_col = NULL, col_space = NULL WHERE id = 3603;
UPDATE lyrics_dev SET lyric = 'Yo! 端から端まで new kawaii!
老若男女問わず new kawaii!', lyric_col = NULL, col_space = NULL WHERE id = 3604;
UPDATE lyrics_dev SET lyric = '言いたくなっちゃうよね new kawaii!
さあさあ! もう一緒に new kawaii!', lyric_col = NULL, col_space = NULL WHERE id = 3605;
UPDATE lyrics_dev SET lyric = 'ちぇけちぇけちぇけちぇけらーっ!
なんでもいいからノッちゃいなーっ!', lyric_col = NULL, col_space = NULL WHERE id = 3606;
UPDATE lyrics_dev SET lyric = '音楽やっぱ楽しんだもん勝ちじゃん
はい こっから歌パート', lyric_col = NULL, col_space = NULL WHERE id = 3607;
UPDATE lyrics_dev SET lyric = 'この星に生まれた kawaii は
どんなときも
チカラになる', lyric_col = NULL, col_space = NULL WHERE id = 3608;
UPDATE lyrics_dev SET lyric = '今日も明日も明後日も
信じ合える
愛に変わるからーっ!', lyric_col = NULL, col_space = NULL WHERE id = 3609;
UPDATE lyrics_dev SET lyric = 'Kawaii! Kawaii! Kawa! Kawa! Kawaii!
Kawaii! Kawaii! Kawa! Kawa! Kawaii!
Kawaii! Kawaii! Kawa! Kawa! Kawa! Kawa!', lyric_col = NULL, col_space = NULL WHERE id = 3610;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER!', lyric_col = NULL, col_space = NULL WHERE id = 3611;
UPDATE lyrics_dev SET lyric = 'Zipper! Zipper! ふるっぱーりー!
New kawaii! デリバリー!
朝まで! Shake your body!', lyric_col = NULL, col_space = NULL WHERE id = 3612;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3613;
UPDATE lyrics_dev SET lyric = 'Zipper! Zipper! ふるっぱーりー!
New kawaii! デリバリー!
朝まで! Shake your body!', lyric_col = NULL, col_space = NULL WHERE id = 3614;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3615;
UPDATE lyrics_dev SET lyric = 'Don''t stop the party!
ここがフィエスタ!
騒げ! All day! All night!', lyric_col = NULL, col_space = NULL WHERE id = 3616;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3617;
UPDATE lyrics_dev SET lyric = 'Non stop the music!
ノリノリでダンシング!
踊れ! エビバディーっ!', lyric_col = NULL, col_space = NULL WHERE id = 3618;
UPDATE lyrics_dev SET lyric = '101人目も乗っちゃってー!', lyric_col = NULL, col_space = NULL WHERE id = 3619;
UPDATE lyrics_dev SET lyric = 'はじけるビート キラキラのハート
夢を見せたいの 終わらないランド', lyric_col = NULL, col_space = NULL WHERE id = 3620;
UPDATE lyrics_dev SET lyric = '赤ちゃんからギャルピまでいんの
7人7色で はい 全員集合っ!', lyric_col = NULL, col_space = NULL WHERE id = 3621;
UPDATE lyrics_dev SET lyric = 'コールアンドレスポンス
行くよー! Sayっ!', lyric_col = NULL, col_space = NULL WHERE id = 3622;
UPDATE lyrics_dev SET lyric = 'あまねき! (あまねき!)', lyric_col = NULL, col_space = NULL WHERE id = 3623;
UPDATE lyrics_dev SET lyric = 'おすず! (おすず!)', lyric_col = NULL, col_space = NULL WHERE id = 3624;
UPDATE lyrics_dev SET lyric = 'ゆいちゃん! (ゆいちゃん!)', lyric_col = NULL, col_space = NULL WHERE id = 3625;
UPDATE lyrics_dev SET lyric = 'るなぴ! (るなぴ!)', lyric_col = NULL, col_space = NULL WHERE id = 3626;
UPDATE lyrics_dev SET lyric = 'まなふぃ! (まなふぃ!)', lyric_col = NULL, col_space = NULL WHERE id = 3627;
UPDATE lyrics_dev SET lyric = 'まつかれ! (まつかれ!)', lyric_col = NULL, col_space = NULL WHERE id = 3628;
UPDATE lyrics_dev SET lyric = 'ノエちゃん! (ノエちゃん!)', lyric_col = NULL, col_space = NULL WHERE id = 3629;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER!', lyric_col = NULL, col_space = NULL WHERE id = 3630;
UPDATE lyrics_dev SET lyric = 'この星で育った kawaii は
どんなときも 勇気になる', lyric_col = NULL, col_space = NULL WHERE id = 3631;
UPDATE lyrics_dev SET lyric = '今日も明日も明後日も 繋ぎ合える
愛に変わるからーっ!', lyric_col = NULL, col_space = NULL WHERE id = 3632;
UPDATE lyrics_dev SET lyric = 'Kawaii! Kawaii! Kawa! Kawa! Kawaii!
Kawaii! Kawaii! Kawa! Kawa! Kawaii!
Kawaii! Kawaii! Kawa! Kawa! Kawa! Kawa!', lyric_col = NULL, col_space = NULL WHERE id = 3633;
UPDATE lyrics_dev SET lyric = 'Are you ready!!', lyric_col = NULL, col_space = NULL WHERE id = 3634;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER!', lyric_col = NULL, col_space = NULL WHERE id = 3635;
UPDATE lyrics_dev SET lyric = 'Zipper! Zipper! ふるっぱーりー!
New kawaii! デリバリー!
朝まで! Shake your body!', lyric_col = NULL, col_space = NULL WHERE id = 3636;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3637;
UPDATE lyrics_dev SET lyric = 'Zipper! Zipper! ふるっぱーりー!
New kawaii! デリバリー!
朝まで! Shake your body!', lyric_col = NULL, col_space = NULL WHERE id = 3638;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3639;
UPDATE lyrics_dev SET lyric = 'Don''t stop the party!
ここがフィエスタ!
騒げ! All day! All night!', lyric_col = NULL, col_space = NULL WHERE id = 3640;
UPDATE lyrics_dev SET lyric = '100人乗っても大丈夫っ!', lyric_col = NULL, col_space = NULL WHERE id = 3641;
UPDATE lyrics_dev SET lyric = 'Non stop the music!
ノリノリでダンシング!
踊れ! エビバディーっ!', lyric_col = NULL, col_space = NULL WHERE id = 3642;
UPDATE lyrics_dev SET lyric = '101人目も乗っちゃってー!', lyric_col = NULL, col_space = NULL WHERE id = 3643;
UPDATE lyrics_dev SET lyric = 'We are FRUITS ZIPPER!', lyric_col = NULL, col_space = NULL WHERE id = 3644;
-- sounds_id=33 ふれふるサマー！ (45行)
UPDATE lyrics_dev SET lyric = '君と過ごしたい夏が
全速力　やってきた
誰にも負けない永遠の Stay Gold', lyric_col = NULL, col_space = NULL WHERE id = 652;
UPDATE lyrics_dev SET lyric = 'みんなみんな準備はどう？
楽しんだもん勝ちじゃん', lyric_col = NULL, col_space = NULL WHERE id = 653;
UPDATE lyrics_dev SET lyric = 'アソビなんだ　本気でたたかえ', lyric_col = NULL, col_space = NULL WHERE id = 654;
UPDATE lyrics_dev SET lyric = '熱くなれ　太陽よりもいちばん
熱くなれ　輝いているのは誰だ？', lyric_col = NULL, col_space = NULL WHERE id = 655;
UPDATE lyrics_dev SET lyric = 'ひとなつっこいけどちょっと泣き虫', lyric_col = NULL, col_space = NULL WHERE id = 656;
UPDATE lyrics_dev SET lyric = '原宿大好き　ダンスリーダー', lyric_col = NULL, col_space = NULL WHERE id = 657;
UPDATE lyrics_dev SET lyric = '生まれも年も違うけど', lyric_col = NULL, col_space = NULL WHERE id = 658;
UPDATE lyrics_dev SET lyric = 'ステージにあがる瞬間　切り替えるスイッチ', lyric_col = NULL, col_space = NULL WHERE id = 659;
UPDATE lyrics_dev SET lyric = '誰もが持ってるこのパワー　宇宙まで届け', lyric_col = NULL, col_space = NULL WHERE id = 660;
UPDATE lyrics_dev SET lyric = '個性的なもぎたての', lyric_col = 1, col_space = NULL WHERE id = 661;
UPDATE lyrics_dev SET lyric = 'フレッシュなフルーツ', lyric_col = 2, col_space = 'full' WHERE id = 662;
UPDATE lyrics_dev SET lyric = '熱い夏を虹色にするシャワービーナス', lyric_col = NULL, col_space = NULL WHERE id = 663;
UPDATE lyrics_dev SET lyric = '大胆不敵なスプラッシュ', lyric_col = NULL, col_space = NULL WHERE id = 664;
UPDATE lyrics_dev SET lyric = '振りまわせ　真夏の魅惑 Summer！！
熱くなれ　太陽も溶ける Hot Dream', lyric_col = NULL, col_space = NULL WHERE id = 665;
UPDATE lyrics_dev SET lyric = '声あげろ　この夏を楽しむ戦いは', lyric_col = NULL, col_space = NULL WHERE id = 666;
UPDATE lyrics_dev SET lyric = '始まっているのだから　さぁ', lyric_col = NULL, col_space = NULL WHERE id = 667;
UPDATE lyrics_dev SET lyric = 'みんなでゆくのさ　ふれふるサマービーチ
Ah　火照ったカラダ Summer Song', lyric_col = NULL, col_space = NULL WHERE id = 668;
UPDATE lyrics_dev SET lyric = 'あー　アイドル全開！極めるならやっぱりコレよね', lyric_col = NULL, col_space = NULL WHERE id = 669;
UPDATE lyrics_dev SET lyric = 'グループみんなを歌でひっぱる　それなら任せて', lyric_col = NULL, col_space = NULL WHERE id = 670;
UPDATE lyrics_dev SET lyric = '誰よりポジティブでパリピ　楽しまなきゃでしょ', lyric_col = NULL, col_space = NULL WHERE id = 671;
UPDATE lyrics_dev SET lyric = 'この夏　いちばんの', lyric_col = 1, col_space = NULL WHERE id = 672;
UPDATE lyrics_dev SET lyric = '弾けそうなスタイルで', lyric_col = 2, col_space = NULL WHERE id = 673;
UPDATE lyrics_dev SET lyric = '誰よりも君の心を掴むんだ', lyric_col = NULL, col_space = NULL WHERE id = 674;
UPDATE lyrics_dev SET lyric = '決戦の瞬間(とき)が', lyric_col = 1, col_space = NULL WHERE id = 675;
UPDATE lyrics_dev SET lyric = 'キター！', lyric_col = 2, col_space = 'full' WHERE id = 676;
UPDATE lyrics_dev SET lyric = '振りまわせ　空も飛べちゃうくらい
熱くなれ　砂浜も焦がすほどに', lyric_col = NULL, col_space = NULL WHERE id = 677;
UPDATE lyrics_dev SET lyric = '声あげろ　ひと夏の約束', lyric_col = 1, col_space = NULL WHERE id = 678;
UPDATE lyrics_dev SET lyric = '交わした
ままで　今　君はどこにいるの？', lyric_col = 2, col_space = 'full' WHERE id = 679;
UPDATE lyrics_dev SET lyric = 'いっしょに最高の瞬間', lyric_col = NULL, col_space = NULL WHERE id = 680;
UPDATE lyrics_dev SET lyric = '記憶に残そう', lyric_col = NULL, col_space = NULL WHERE id = 681;
UPDATE lyrics_dev SET lyric = 'この夏は　いつまでも終わらない', lyric_col = NULL, col_space = NULL WHERE id = 682;
UPDATE lyrics_dev SET lyric = 'この夏に　君が焼き付けるのは誰？', lyric_col = NULL, col_space = NULL WHERE id = 683;
UPDATE lyrics_dev SET lyric = '声あげろ　永遠の始まり　それはそう', lyric_col = NULL, col_space = NULL WHERE id = 684;
UPDATE lyrics_dev SET lyric = 'きっとこの場所だから　さぁ', lyric_col = NULL, col_space = NULL WHERE id = 685;
UPDATE lyrics_dev SET lyric = 'みんなでゆくのさ　ふれふるサマービーチ
Ah　火照ったカラダ Summer Song', lyric_col = NULL, col_space = NULL WHERE id = 686;
UPDATE lyrics_dev SET lyric = '振りまわせ　真夏の魅惑 Summer！！
熱くなれ　太陽も溶ける Hot Dream', lyric_col = NULL, col_space = NULL WHERE id = 687;
UPDATE lyrics_dev SET lyric = '声あげろ　この夏を楽しむ戦いは', lyric_col = NULL, col_space = NULL WHERE id = 688;
UPDATE lyrics_dev SET lyric = '始まっているのだから　さぁ', lyric_col = NULL, col_space = NULL WHERE id = 689;
UPDATE lyrics_dev SET lyric = 'みんなで飛ぶのさ　ふれふるサマービーチ', lyric_col = NULL, col_space = NULL WHERE id = 690;
UPDATE lyrics_dev SET lyric = 'Ah　火照ったカラダ　燃やそう', lyric_col = 1, col_space = NULL WHERE id = 691;
UPDATE lyrics_dev SET lyric = '(まだまだーー)', lyric_col = 2, col_space = NULL WHERE id = 692;
UPDATE lyrics_dev SET lyric = 'フレーフレーフレッシュ
この夏の主役に輝くのは', lyric_col = NULL, col_space = NULL WHERE id = 693;
UPDATE lyrics_dev SET lyric = 'フレーフレーフレッシュ
他の誰でもないとしたらワタシ', lyric_col = NULL, col_space = NULL WHERE id = 694;
UPDATE lyrics_dev SET lyric = 'みんなでゆくのさ　ふれふるサマービーチ
Ah　火照ったカラダ Summer Song', lyric_col = NULL, col_space = NULL WHERE id = 695;
UPDATE lyrics_dev SET lyric = 'Ah...', lyric_col = NULL, col_space = NULL WHERE id = 696;
-- sounds_id=35 わたしの一番かわいいところ (57行)
UPDATE lyrics_dev SET lyric = 'あれ気付いちゃいましたか？', lyric_col = NULL, col_space = NULL WHERE id = 1;
UPDATE lyrics_dev SET lyric = 'うまれて30秒。で最初に聞いた言葉は', lyric_col = NULL, col_space = NULL WHERE id = 2;
UPDATE lyrics_dev SET lyric = '当たり前にそりゃ覚えてないけど
嬉しかったはず', lyric_col = NULL, col_space = NULL WHERE id = 3;
UPDATE lyrics_dev SET lyric = '今でもだいたいのことは
かわってないっていうかそりゃ', lyric_col = NULL, col_space = NULL WHERE id = 4;
UPDATE lyrics_dev SET lyric = '中身は変わっていますので、その辺でも評価！', lyric_col = 1, col_space = NULL WHERE id = 5;
UPDATE lyrics_dev SET lyric = '(おねがい！)', lyric_col = 2, col_space = NULL WHERE id = 6;
UPDATE lyrics_dev SET lyric = '携帯のアンテナを光らせて', lyric_col = NULL, col_space = NULL WHERE id = 7;
UPDATE lyrics_dev SET lyric = 'それが超キュートなあの頃だって知ってたり。', lyric_col = NULL, col_space = NULL WHERE id = 8;
UPDATE lyrics_dev SET lyric = 'っていうかアンテナって何っていってるような', lyric_col = NULL, col_space = NULL WHERE id = 9;
UPDATE lyrics_dev SET lyric = 'わたしに
付き合ってくれるの好き、', lyric_col = NULL, col_space = NULL WHERE id = 10;
UPDATE lyrics_dev SET lyric = '逆にでもわたしのどこが好き？', lyric_col = NULL, col_space = NULL WHERE id = 11;
UPDATE lyrics_dev SET lyric = 'ねえ？ねえ？ねえ？', lyric_col = NULL, col_space = NULL WHERE id = 12;
UPDATE lyrics_dev SET lyric = 'わたしの一番、かわいいところに
気付いてる', lyric_col = NULL, col_space = NULL WHERE id = 13;
UPDATE lyrics_dev SET lyric = 'そんな君が一番すごいすごいよすごすぎる！', lyric_col = NULL, col_space = NULL WHERE id = 14;
UPDATE lyrics_dev SET lyric = 'そして君が知ってるわたしが一番かわいいの、', lyric_col = NULL, col_space = NULL WHERE id = 15;
UPDATE lyrics_dev SET lyric = 'わたしもそれに気付いた！', lyric_col = NULL, col_space = NULL WHERE id = 16;
UPDATE lyrics_dev SET lyric = 'だから
それかわいい、あれかわいいなんて', lyric_col = NULL, col_space = NULL WHERE id = 17;
UPDATE lyrics_dev SET lyric = '誰かわいい、それかわいいなんて', lyric_col = NULL, col_space = NULL WHERE id = 18;
UPDATE lyrics_dev SET lyric = '言わないで、わたし以外なんてやだ', lyric_col = NULL, col_space = NULL WHERE id = 19;
UPDATE lyrics_dev SET lyric = 'なんてありえない？', lyric_col = NULL, col_space = NULL WHERE id = 20;
UPDATE lyrics_dev SET lyric = 'わたし気付いちゃいました', lyric_col = NULL, col_space = NULL WHERE id = 21;
UPDATE lyrics_dev SET lyric = '毎日何十秒、褒められまくったお菓子は', lyric_col = NULL, col_space = NULL WHERE id = 22;
UPDATE lyrics_dev SET lyric = '他よりちょっと甘くなるって
前に聞いたような', lyric_col = NULL, col_space = NULL WHERE id = 23;
UPDATE lyrics_dev SET lyric = 'さすがにそれなんか変だけど
わたしは言われたいタイプでして', lyric_col = NULL, col_space = NULL WHERE id = 24;
UPDATE lyrics_dev SET lyric = 'もっとわかりやすくていいんだよ、お待ちしてます', lyric_col = 1, col_space = NULL WHERE id = 25;
UPDATE lyrics_dev SET lyric = '(おねがい！)', lyric_col = 2, col_space = NULL WHERE id = 26;
UPDATE lyrics_dev SET lyric = '何しても', lyric_col = 1, col_space = NULL WHERE id = 27;
UPDATE lyrics_dev SET lyric = 'どんな顔', lyric_col = 2, col_space = NULL WHERE id = 28;
UPDATE lyrics_dev SET lyric = '見せてても', lyric_col = 3, col_space = NULL WHERE id = 29;
UPDATE lyrics_dev SET lyric = 'いつも超キュートだって確信してるのは', lyric_col = NULL, col_space = NULL WHERE id = 30;
UPDATE lyrics_dev SET lyric = 'なんだかさ知らなかったタイプの運命の
人なの？', lyric_col = NULL, col_space = NULL WHERE id = 31;
UPDATE lyrics_dev SET lyric = '付き合ったりは無理ごめん', lyric_col = NULL, col_space = NULL WHERE id = 32;
UPDATE lyrics_dev SET lyric = '逆にでもそれより楽しいよ', lyric_col = NULL, col_space = NULL WHERE id = 33;
UPDATE lyrics_dev SET lyric = 'ね！ね！ね！', lyric_col = NULL, col_space = NULL WHERE id = 34;
UPDATE lyrics_dev SET lyric = 'わたしの一番、かわいいところを
よく見てる', lyric_col = NULL, col_space = NULL WHERE id = 35;
UPDATE lyrics_dev SET lyric = 'そんな君がほんとに超ラッキーな人すぎる！', lyric_col = NULL, col_space = NULL WHERE id = 36;
UPDATE lyrics_dev SET lyric = 'そして君が何年たってもそう思えるように', lyric_col = NULL, col_space = NULL WHERE id = 37;
UPDATE lyrics_dev SET lyric = 'わたしはそれに気付いた', lyric_col = NULL, col_space = NULL WHERE id = 38;
UPDATE lyrics_dev SET lyric = '会えないときも、どんな表情してるかとか
気持ちわるいくらい想像しちゃうから', lyric_col = NULL, col_space = NULL WHERE id = 39;
UPDATE lyrics_dev SET lyric = 'それかわいいあれかわいいよって', lyric_col = NULL, col_space = NULL WHERE id = 40;
UPDATE lyrics_dev SET lyric = 'ほんとにかわいいっていって', lyric_col = NULL, col_space = NULL WHERE id = 41;
UPDATE lyrics_dev SET lyric = 'わたしの一番、かわいいところに
気付いてる', lyric_col = NULL, col_space = NULL WHERE id = 42;
UPDATE lyrics_dev SET lyric = 'そんな君が一番すごいすごいよすごすぎる！', lyric_col = NULL, col_space = NULL WHERE id = 43;
UPDATE lyrics_dev SET lyric = 'そして君が知ってるわたしが一番かわいいの、', lyric_col = NULL, col_space = NULL WHERE id = 44;
UPDATE lyrics_dev SET lyric = 'わたしもそれに気付いた！', lyric_col = NULL, col_space = NULL WHERE id = 45;
UPDATE lyrics_dev SET lyric = 'わたしの一番、かわいいところを
よく見てる', lyric_col = NULL, col_space = NULL WHERE id = 46;
UPDATE lyrics_dev SET lyric = 'そんな君がほんとに超ラッキーな人すぎる！', lyric_col = NULL, col_space = NULL WHERE id = 47;
UPDATE lyrics_dev SET lyric = 'そして君が何年たってもそう思えるように', lyric_col = NULL, col_space = NULL WHERE id = 48;
UPDATE lyrics_dev SET lyric = 'わたしはそれに気付いた', lyric_col = NULL, col_space = NULL WHERE id = 49;
UPDATE lyrics_dev SET lyric = 'わたしの一番、かわいいところに
気付いてる', lyric_col = NULL, col_space = NULL WHERE id = 50;
UPDATE lyrics_dev SET lyric = 'そんな君が一番すごいすごいよすごすぎる！', lyric_col = NULL, col_space = NULL WHERE id = 51;
UPDATE lyrics_dev SET lyric = 'そして君が知ってるわたしが一番かわいいの、', lyric_col = NULL, col_space = NULL WHERE id = 52;
UPDATE lyrics_dev SET lyric = 'わたしもそれに気付いた！', lyric_col = NULL, col_space = NULL WHERE id = 53;
UPDATE lyrics_dev SET lyric = 'だから
それかわいい、あれかわいいなんて', lyric_col = NULL, col_space = NULL WHERE id = 54;
UPDATE lyrics_dev SET lyric = '誰かわいい、それかわいいなんて', lyric_col = NULL, col_space = NULL WHERE id = 55;
UPDATE lyrics_dev SET lyric = '言わないで、わたし以外なんてやだ', lyric_col = NULL, col_space = NULL WHERE id = 56;
UPDATE lyrics_dev SET lyric = 'なんてありえない？', lyric_col = NULL, col_space = NULL WHERE id = 57;
-- sounds_id=43 成長期なので。 (50行)
UPDATE lyrics_dev SET lyric = 'なんでも、かんでも、全部を、
完璧、ちょっぴり丁寧にこなすって', lyric_col = NULL, col_space = NULL WHERE id = 4580;
UPDATE lyrics_dev SET lyric = '難しいって', lyric_col = 1, col_space = NULL WHERE id = 4581;
UPDATE lyrics_dev SET lyric = '誰かは言うけれど', lyric_col = 2, col_space = 'full' WHERE id = 4582;
UPDATE lyrics_dev SET lyric = '(できる、できる！わたし、できる！)', lyric_col = NULL, col_space = NULL WHERE id = 4583;
UPDATE lyrics_dev SET lyric = '大事な　大事な　大事な　大事な
大事なきみに出会えたんです', lyric_col = NULL, col_space = NULL WHERE id = 4584;
UPDATE lyrics_dev SET lyric = '嬉しいんです', lyric_col = NULL, col_space = NULL WHERE id = 4585;
UPDATE lyrics_dev SET lyric = 'だから、やるしかないの！', lyric_col = NULL, col_space = NULL WHERE id = 4586;
UPDATE lyrics_dev SET lyric = '(できる、できる！みんなで、できる！)', lyric_col = NULL, col_space = NULL WHERE id = 4587;
UPDATE lyrics_dev SET lyric = '不器用だって', lyric_col = NULL, col_space = NULL WHERE id = 4588;
UPDATE lyrics_dev SET lyric = 'ねむむだって', lyric_col = NULL, col_space = NULL WHERE id = 4589;
UPDATE lyrics_dev SET lyric = '未完成だって', lyric_col = NULL, col_space = NULL WHERE id = 4590;
UPDATE lyrics_dev SET lyric = '(ノビシロ見せつけるもん！)', lyric_col = NULL, col_space = NULL WHERE id = 4591;
UPDATE lyrics_dev SET lyric = '1日が204時間にならんかな？？', lyric_col = NULL, col_space = NULL WHERE id = 4592;
UPDATE lyrics_dev SET lyric = 'ほしいモノはただ一つ　でも、
ひ　み　つ', lyric_col = NULL, col_space = NULL WHERE id = 4593;
UPDATE lyrics_dev SET lyric = '今日も貪欲なんです
コレわたし達でーす', lyric_col = NULL, col_space = NULL WHERE id = 4594;
UPDATE lyrics_dev SET lyric = 'まだまだだ　バタバタタ
頑張るるのだだ', lyric_col = NULL, col_space = NULL WHERE id = 4595;
UPDATE lyrics_dev SET lyric = '君の夢とわたしの夢が同じだって知った日から', lyric_col = NULL, col_space = NULL WHERE id = 4596;
UPDATE lyrics_dev SET lyric = '(世界がSHINYです！)', lyric_col = NULL, col_space = NULL WHERE id = 4597;
UPDATE lyrics_dev SET lyric = 'きみが居れば叶えられる気がする', lyric_col = NULL, col_space = NULL WHERE id = 4598;
UPDATE lyrics_dev SET lyric = 'だってわたし達、成長期なので。', lyric_col = NULL, col_space = NULL WHERE id = 4599;
UPDATE lyrics_dev SET lyric = 'なんでも、かんでも、大好き、
ギュッてし、天使の対応無理かもって', lyric_col = NULL, col_space = NULL WHERE id = 4600;
UPDATE lyrics_dev SET lyric = 'そりゃそうです。', lyric_col = 1, col_space = NULL WHERE id = 4601;
UPDATE lyrics_dev SET lyric = 'こちとら人間なので。', lyric_col = 2, col_space = NULL WHERE id = 4602;
UPDATE lyrics_dev SET lyric = '(しゃーない、しゃーない！
しゃーない、しゃーないよ！)', lyric_col = NULL, col_space = NULL WHERE id = 4603;
UPDATE lyrics_dev SET lyric = 'だけど大事な大事な大事な仲間たちには
ドドカンと', lyric_col = 1, col_space = NULL WHERE id = 4604;
UPDATE lyrics_dev SET lyric = 'めちゃドカンと', lyric_col = 2, col_space = 'full' WHERE id = 4605;
UPDATE lyrics_dev SET lyric = '正面から向き合うの', lyric_col = NULL, col_space = NULL WHERE id = 4606;
UPDATE lyrics_dev SET lyric = '(話し合いはゼッタイ！)', lyric_col = NULL, col_space = NULL WHERE id = 4607;
UPDATE lyrics_dev SET lyric = '道に迷っちゃうのは週8だけど', lyric_col = NULL, col_space = NULL WHERE id = 4608;
UPDATE lyrics_dev SET lyric = '早起きしてダッシュするから大丈夫！', lyric_col = NULL, col_space = NULL WHERE id = 4609;
UPDATE lyrics_dev SET lyric = 'エナジー溜めるし、', lyric_col = 1, col_space = NULL WHERE id = 4610;
UPDATE lyrics_dev SET lyric = '大丈夫！', lyric_col = 2, col_space = NULL WHERE id = 4611;
UPDATE lyrics_dev SET lyric = 'かなり貪欲なんです
ちょっとワガママでーす', lyric_col = NULL, col_space = NULL WHERE id = 4612;
UPDATE lyrics_dev SET lyric = 'アレもしたい！コレもしたい！
全部したいのだだ', lyric_col = NULL, col_space = NULL WHERE id = 4613;
UPDATE lyrics_dev SET lyric = '涙出るくらい応援してくれる君を守らせて', lyric_col = NULL, col_space = NULL WHERE id = 4614;
UPDATE lyrics_dev SET lyric = '(一緒にReady Go！)', lyric_col = NULL, col_space = NULL WHERE id = 4615;
UPDATE lyrics_dev SET lyric = 'その笑顔しかいらない気がしちゃう', lyric_col = NULL, col_space = NULL WHERE id = 4616;
UPDATE lyrics_dev SET lyric = 'だってわたし達、成長期なので。', lyric_col = NULL, col_space = NULL WHERE id = 4617;
UPDATE lyrics_dev SET lyric = '君と見たい景色も', lyric_col = NULL, col_space = NULL WHERE id = 4618;
UPDATE lyrics_dev SET lyric = '君としたい話も', lyric_col = NULL, col_space = NULL WHERE id = 4619;
UPDATE lyrics_dev SET lyric = '君”を知りたいわたしも', lyric_col = NULL, col_space = NULL WHERE id = 4620;
UPDATE lyrics_dev SET lyric = '君に教えたい“わたし”も', lyric_col = NULL, col_space = NULL WHERE id = 4621;
UPDATE lyrics_dev SET lyric = 'まだまだまだまだまだまだ…', lyric_col = NULL, col_space = NULL WHERE id = 4622;
UPDATE lyrics_dev SET lyric = '今日も貪欲なんです
コレわたし達でーす', lyric_col = NULL, col_space = NULL WHERE id = 4623;
UPDATE lyrics_dev SET lyric = 'まだまだだ　バタバタタ
頑張るるのだだ', lyric_col = NULL, col_space = NULL WHERE id = 4624;
UPDATE lyrics_dev SET lyric = '君の夢とわたしの夢が同じだって知った日から', lyric_col = NULL, col_space = NULL WHERE id = 4625;
UPDATE lyrics_dev SET lyric = '(一緒にReady Go！)', lyric_col = NULL, col_space = NULL WHERE id = 4626;
UPDATE lyrics_dev SET lyric = 'きみが居れば叶えられる気がする', lyric_col = NULL, col_space = NULL WHERE id = 4627;
UPDATE lyrics_dev SET lyric = 'たまにわたし達、成長痛です。', lyric_col = NULL, col_space = NULL WHERE id = 4628;
UPDATE lyrics_dev SET lyric = 'だってわたし達、成長期なので。', lyric_col = NULL, col_space = NULL WHERE id = 4629;
-- sounds_id=49 ふるっぱれーど (59行)
UPDATE lyrics_dev SET lyric = 'いっせーの
はじまりの合図', lyric_col = NULL, col_space = NULL WHERE id = 3425;
UPDATE lyrics_dev SET lyric = '全体、前にならえ！', lyric_col = NULL, col_space = NULL WHERE id = 3426;
UPDATE lyrics_dev SET lyric = 'OK！
それじゃはしゃごう', lyric_col = NULL, col_space = NULL WHERE id = 3427;
UPDATE lyrics_dev SET lyric = 'Let''s go FRUITS ZIPPER', lyric_col = NULL, col_space = NULL WHERE id = 3428;
UPDATE lyrics_dev SET lyric = 'papa-n papa-n
(いちにさんしごー！)', lyric_col = NULL, col_space = NULL WHERE id = 3429;
UPDATE lyrics_dev SET lyric = 'papa-n papa-n', lyric_col = NULL, col_space = NULL WHERE id = 3430;
UPDATE lyrics_dev SET lyric = '(いちにさん)', lyric_col = NULL, col_space = NULL WHERE id = 3431;
UPDATE lyrics_dev SET lyric = '(いぇい！)', lyric_col = NULL, col_space = NULL WHERE id = 3432;
UPDATE lyrics_dev SET lyric = 'なんとなく超いい感じ', lyric_col = NULL, col_space = NULL WHERE id = 3433;
UPDATE lyrics_dev SET lyric = 'おしゃれをしたりちょっぴりドキドキ', lyric_col = NULL, col_space = NULL WHERE id = 3434;
UPDATE lyrics_dev SET lyric = '前髪は拘りの見せ所だし', lyric_col = 1, col_space = NULL WHERE id = 3435;
UPDATE lyrics_dev SET lyric = '(いのち笑)', lyric_col = 2, col_space = NULL WHERE id = 3436;
UPDATE lyrics_dev SET lyric = '誰よりも自分愛していこう', lyric_col = NULL, col_space = NULL WHERE id = 3437;
UPDATE lyrics_dev SET lyric = '自由でいたいもん', lyric_col = NULL, col_space = NULL WHERE id = 3438;
UPDATE lyrics_dev SET lyric = 'ラブで世界を廻そう', lyric_col = NULL, col_space = NULL WHERE id = 3439;
UPDATE lyrics_dev SET lyric = '(はい　せーの！)', lyric_col = NULL, col_space = NULL WHERE id = 3440;
UPDATE lyrics_dev SET lyric = 'カラフルっパレード
ボクらはみな何かに恋してる', lyric_col = NULL, col_space = NULL WHERE id = 3441;
UPDATE lyrics_dev SET lyric = 'きゅんときゅんが出会い
止まれないでしょ！進め！', lyric_col = NULL, col_space = NULL WHERE id = 3442;
UPDATE lyrics_dev SET lyric = 'がんばれ！
信じることでココロを抱きしめて', lyric_col = NULL, col_space = NULL WHERE id = 3443;
UPDATE lyrics_dev SET lyric = 'ぎゅってしたら大丈夫だよ　ほら　ね', lyric_col = NULL, col_space = NULL WHERE id = 3444;
UPDATE lyrics_dev SET lyric = 'ワンツーあふれる感情', lyric_col = NULL, col_space = NULL WHERE id = 3445;
UPDATE lyrics_dev SET lyric = 'ワンチャン！で飛び出し渋滞', lyric_col = NULL, col_space = NULL WHERE id = 3446;
UPDATE lyrics_dev SET lyric = 'やっちゃった完全に後悔', lyric_col = NULL, col_space = NULL WHERE id = 3447;
UPDATE lyrics_dev SET lyric = 'あたまがとけちゃうの', lyric_col = NULL, col_space = NULL WHERE id = 3448;
UPDATE lyrics_dev SET lyric = 'ノー', lyric_col = 1, col_space = NULL WHERE id = 3449;
UPDATE lyrics_dev SET lyric = 'ノー', lyric_col = 2, col_space = NULL WHERE id = 3450;
UPDATE lyrics_dev SET lyric = 'ノー', lyric_col = 3, col_space = NULL WHERE id = 3451;
UPDATE lyrics_dev SET lyric = '暗い暗い地球の果てで
ボクらは手探り繰り返すよ', lyric_col = NULL, col_space = NULL WHERE id = 3452;
UPDATE lyrics_dev SET lyric = '目の前のリアルさえも見失ってしまわぬように', lyric_col = NULL, col_space = NULL WHERE id = 3453;
UPDATE lyrics_dev SET lyric = '精一杯走り続けるよ', lyric_col = NULL, col_space = NULL WHERE id = 3454;
UPDATE lyrics_dev SET lyric = 'YO　シャッター越しじゃわかんない心裏', lyric_col = NULL, col_space = NULL WHERE id = 3455;
UPDATE lyrics_dev SET lyric = 'よくみてみてよあっという間に', lyric_col = NULL, col_space = NULL WHERE id = 3456;
UPDATE lyrics_dev SET lyric = '今日が昨日に明日が昨日に', lyric_col = NULL, col_space = NULL WHERE id = 3457;
UPDATE lyrics_dev SET lyric = '明後日も明明後日も', lyric_col = NULL, col_space = NULL WHERE id = 3458;
UPDATE lyrics_dev SET lyric = 'ただ過去に', lyric_col = NULL, col_space = NULL WHERE id = 3459;
UPDATE lyrics_dev SET lyric = 'あの時の思いもひとりきりで抱えないで', lyric_col = NULL, col_space = NULL WHERE id = 3460;
UPDATE lyrics_dev SET lyric = '一緒に行こう', lyric_col = NULL, col_space = NULL WHERE id = 3461;
UPDATE lyrics_dev SET lyric = 'ねぇ約束だよ', lyric_col = NULL, col_space = NULL WHERE id = 3462;
UPDATE lyrics_dev SET lyric = '誰よりも自分愛していこう', lyric_col = NULL, col_space = NULL WHERE id = 3463;
UPDATE lyrics_dev SET lyric = '自由でいたいもん', lyric_col = NULL, col_space = NULL WHERE id = 3464;
UPDATE lyrics_dev SET lyric = 'ラブで世界を廻そう', lyric_col = NULL, col_space = NULL WHERE id = 3465;
UPDATE lyrics_dev SET lyric = '(はい　せーの！)', lyric_col = NULL, col_space = NULL WHERE id = 3466;
UPDATE lyrics_dev SET lyric = 'カラフルっパレード
あのコもみな何かに恋してる', lyric_col = NULL, col_space = NULL WHERE id = 3467;
UPDATE lyrics_dev SET lyric = 'ピカピカの時代
飾りたいでしょ！進め！', lyric_col = NULL, col_space = NULL WHERE id = 3468;
UPDATE lyrics_dev SET lyric = '胸張れっ！
声を上げてさあ大好きを届け合おう', lyric_col = NULL, col_space = NULL WHERE id = 3469;
UPDATE lyrics_dev SET lyric = 'ぐっときたら感動しちゃうかもね', lyric_col = NULL, col_space = NULL WHERE id = 3470;
UPDATE lyrics_dev SET lyric = 'ワンツーあふれる感情', lyric_col = NULL, col_space = NULL WHERE id = 3471;
UPDATE lyrics_dev SET lyric = 'ワンチャン！で超えちゃう限界', lyric_col = NULL, col_space = NULL WHERE id = 3472;
UPDATE lyrics_dev SET lyric = 'やっぱね完全に正解', lyric_col = NULL, col_space = NULL WHERE id = 3473;
UPDATE lyrics_dev SET lyric = '未来は明るいの', lyric_col = NULL, col_space = NULL WHERE id = 3474;
UPDATE lyrics_dev SET lyric = 'カラフルっパレード
ボクらはみな何かに恋してる', lyric_col = NULL, col_space = NULL WHERE id = 3475;
UPDATE lyrics_dev SET lyric = 'きゅんときゅんが出会い
止まれないでしょ！進め！', lyric_col = NULL, col_space = NULL WHERE id = 3476;
UPDATE lyrics_dev SET lyric = 'がんばれ！
信じることでココロを抱きしめて', lyric_col = NULL, col_space = NULL WHERE id = 3477;
UPDATE lyrics_dev SET lyric = '最高の輝きをもういっちょ！', lyric_col = NULL, col_space = NULL WHERE id = 3478;
UPDATE lyrics_dev SET lyric = 'ほい！', lyric_col = NULL, col_space = NULL WHERE id = 3479;
UPDATE lyrics_dev SET lyric = '最強の味方だよ', lyric_col = NULL, col_space = NULL WHERE id = 3480;
UPDATE lyrics_dev SET lyric = 'Weare FRUITS ZIPPER！！', lyric_col = NULL, col_space = NULL WHERE id = 3481;
UPDATE lyrics_dev SET lyric = 'papa-n papa-n
(いちにさんしごー！)', lyric_col = NULL, col_space = NULL WHERE id = 3482;
UPDATE lyrics_dev SET lyric = 'papa-n papa-n
(いちにさんしごー！)', lyric_col = NULL, col_space = NULL WHERE id = 3483;
-- sounds_id=507 ぱわーオブらぶ (58行)
UPDATE lyrics_dev SET lyric = 'ぱぱわわ、ぱぱわぱぱ、
ぱぱわわ、ぱぱわぱぱ、ぱぱわわ、ぱぱわぱぱ、ぱ', lyric_col = NULL, col_space = NULL WHERE id = 4823;
UPDATE lyrics_dev SET lyric = 'ぱぱわわ、ぱぱわぱぱ、
ぱぱわわ、ぱぱわぱぱ、ぱぱわわ、ぱぱわぱぱ、ぱ', lyric_col = NULL, col_space = NULL WHERE id = 4824;
UPDATE lyrics_dev SET lyric = '右手に「ぱ」', lyric_col = NULL, col_space = NULL WHERE id = 4825;
UPDATE lyrics_dev SET lyric = '左手に「わ」', lyric_col = NULL, col_space = NULL WHERE id = 4826;
UPDATE lyrics_dev SET lyric = 'あわせてパワー', lyric_col = NULL, col_space = NULL WHERE id = 4827;
UPDATE lyrics_dev SET lyric = 'フルパワーです', lyric_col = NULL, col_space = NULL WHERE id = 4828;
UPDATE lyrics_dev SET lyric = '右手にこれ', lyric_col = NULL, col_space = NULL WHERE id = 4829;
UPDATE lyrics_dev SET lyric = '左手にそれ', lyric_col = NULL, col_space = NULL WHERE id = 4830;
UPDATE lyrics_dev SET lyric = 'あわせてらぶ', lyric_col = NULL, col_space = NULL WHERE id = 4831;
UPDATE lyrics_dev SET lyric = 'そのパワーです', lyric_col = NULL, col_space = NULL WHERE id = 4832;
UPDATE lyrics_dev SET lyric = '(わたしを見て君が元気になって、
その君を見たわたしがまた元気になる
パワーの循環、永久機関、そんなパワー)', lyric_col = NULL, col_space = NULL WHERE id = 4833;
UPDATE lyrics_dev SET lyric = '(パワーがあればなんでもできるから
さらにもうちょっとパワーを増やして
もっとなんでもできるってパワー)', lyric_col = NULL, col_space = NULL WHERE id = 4834;
UPDATE lyrics_dev SET lyric = '心ちょっとだけ充電まっててね', lyric_col = NULL, col_space = NULL WHERE id = 4835;
UPDATE lyrics_dev SET lyric = 'つまり愛をためて、好きをためて、', lyric_col = NULL, col_space = NULL WHERE id = 4836;
UPDATE lyrics_dev SET lyric = 'からだちょっとだけ充電まっててね', lyric_col = NULL, col_space = NULL WHERE id = 4837;
UPDATE lyrics_dev SET lyric = 'そしてたまりたまります、これ', lyric_col = NULL, col_space = NULL WHERE id = 4838;
UPDATE lyrics_dev SET lyric = '世界中の笑顔ここにあつめてWER', lyric_col = NULL, col_space = NULL WHERE id = 4839;
UPDATE lyrics_dev SET lyric = 'エブリbody body に愛と夢をチャージします', lyric_col = NULL, col_space = NULL WHERE id = 4840;
UPDATE lyrics_dev SET lyric = '宇宙中のパワーここにあつめてPA', lyric_col = NULL, col_space = NULL WHERE id = 4841;
UPDATE lyrics_dev SET lyric = '地球飛び出すくらいに気持ちを叫ぼうよ
oh yeah', lyric_col = NULL, col_space = NULL WHERE id = 4842;
UPDATE lyrics_dev SET lyric = 'わたしのパワーあなたのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4843;
UPDATE lyrics_dev SET lyric = 'だれかのパワーみんなのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4844;
UPDATE lyrics_dev SET lyric = 'パパパワー、ママパワー、', lyric_col = NULL, col_space = NULL WHERE id = 4845;
UPDATE lyrics_dev SET lyric = 'おじいちゃんおばあちゃんパワー、
好きな人パワー', lyric_col = NULL, col_space = NULL WHERE id = 4846;
UPDATE lyrics_dev SET lyric = 'ごはんのパワー、おやつのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4847;
UPDATE lyrics_dev SET lyric = 'おふろのパワー、すいみんパワー', lyric_col = NULL, col_space = NULL WHERE id = 4848;
UPDATE lyrics_dev SET lyric = 'このパワー、そのパワー、', lyric_col = NULL, col_space = NULL WHERE id = 4849;
UPDATE lyrics_dev SET lyric = 'ぜんぶあわせてフルパワー', lyric_col = NULL, col_space = NULL WHERE id = 4850;
UPDATE lyrics_dev SET lyric = 'まるとって「は」', lyric_col = NULL, col_space = NULL WHERE id = 4851;
UPDATE lyrics_dev SET lyric = 'そのままで「わ」', lyric_col = NULL, col_space = NULL WHERE id = 4852;
UPDATE lyrics_dev SET lyric = 'あわせて「はわ？」', lyric_col = NULL, col_space = NULL WHERE id = 4853;
UPDATE lyrics_dev SET lyric = 'ゼロパワーです？', lyric_col = NULL, col_space = NULL WHERE id = 4854;
UPDATE lyrics_dev SET lyric = '右手わたし', lyric_col = NULL, col_space = NULL WHERE id = 4855;
UPDATE lyrics_dev SET lyric = '左手は君', lyric_col = NULL, col_space = NULL WHERE id = 4856;
UPDATE lyrics_dev SET lyric = 'あわせてらぶ', lyric_col = NULL, col_space = NULL WHERE id = 4857;
UPDATE lyrics_dev SET lyric = 'みんなでらぶ', lyric_col = NULL, col_space = NULL WHERE id = 4858;
UPDATE lyrics_dev SET lyric = '(強い力とか弱い力とか重力とか電磁気力とか、
パワー界隈も色々あります、結局ぜんぶがパワー)', lyric_col = NULL, col_space = NULL WHERE id = 4859;
UPDATE lyrics_dev SET lyric = '(自分を愛してあげなきゃ
誰かを愛するパワーも生まれないって、
大切なことを続ける言葉のパワー)', lyric_col = NULL, col_space = NULL WHERE id = 4860;
UPDATE lyrics_dev SET lyric = '世界中、輝く光あつめてWER', lyric_col = NULL, col_space = NULL WHERE id = 4861;
UPDATE lyrics_dev SET lyric = 'エブリbody body とその未来を照らしちゃいます', lyric_col = NULL, col_space = NULL WHERE id = 4862;
UPDATE lyrics_dev SET lyric = '宇宙中、轟く存在(ひと)になってふるっぱー', lyric_col = NULL, col_space = NULL WHERE id = 4863;
UPDATE lyrics_dev SET lyric = '地球飛び出すくらいにこの歌、歌おうよ
oh yeah', lyric_col = NULL, col_space = NULL WHERE id = 4864;
UPDATE lyrics_dev SET lyric = 'たまにちょっとだけお手を拝借で', lyric_col = NULL, col_space = NULL WHERE id = 4865;
UPDATE lyrics_dev SET lyric = 'つまり手をつないだりもしたい', lyric_col = NULL, col_space = NULL WHERE id = 4866;
UPDATE lyrics_dev SET lyric = 'あとはちょっとだけ見つめ合ったりね', lyric_col = NULL, col_space = NULL WHERE id = 4867;
UPDATE lyrics_dev SET lyric = 'そしてわかる？わかります、よね', lyric_col = NULL, col_space = NULL WHERE id = 4868;
UPDATE lyrics_dev SET lyric = '世界中の笑顔ここにあつめてWER', lyric_col = NULL, col_space = NULL WHERE id = 4869;
UPDATE lyrics_dev SET lyric = 'エブリbody body に愛と夢をチャージします', lyric_col = NULL, col_space = NULL WHERE id = 4870;
UPDATE lyrics_dev SET lyric = '宇宙中のパワーここにあつめてPA', lyric_col = NULL, col_space = NULL WHERE id = 4871;
UPDATE lyrics_dev SET lyric = '地球飛び出すくらいに気持ちを叫ぼうよ
oh yeah', lyric_col = NULL, col_space = NULL WHERE id = 4872;
UPDATE lyrics_dev SET lyric = 'わたしのパワー、あなたのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4873;
UPDATE lyrics_dev SET lyric = 'だれかのパワー、みんなのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4874;
UPDATE lyrics_dev SET lyric = 'パパパワー、ママパワー、', lyric_col = NULL, col_space = NULL WHERE id = 4875;
UPDATE lyrics_dev SET lyric = 'おじいちゃんおばあちゃんパワー、
好きな人パワー', lyric_col = NULL, col_space = NULL WHERE id = 4876;
UPDATE lyrics_dev SET lyric = 'ごはんのパワー、おやつのパワー', lyric_col = NULL, col_space = NULL WHERE id = 4877;
UPDATE lyrics_dev SET lyric = 'おふろのパワー、すいみんパワー', lyric_col = NULL, col_space = NULL WHERE id = 4878;
UPDATE lyrics_dev SET lyric = 'このパワー、そのパワー、', lyric_col = NULL, col_space = NULL WHERE id = 4879;
UPDATE lyrics_dev SET lyric = 'ぜんぶあわせてフルパワー', lyric_col = NULL, col_space = NULL WHERE id = 4880;
-- sounds_id=508 センセーション (37行)
UPDATE lyrics_dev SET lyric = 'はぁ、こんがらがって
混沌　混濁の世界じゃ', lyric_col = NULL, col_space = NULL WHERE id = 7001;
UPDATE lyrics_dev SET lyric = 'もう、やってられないし
見えない　聞こえない', lyric_col = NULL, col_space = NULL WHERE id = 7002;
UPDATE lyrics_dev SET lyric = 'そう、グーチョキパーの
ジャンケンでも負ける気しないわ', lyric_col = NULL, col_space = NULL WHERE id = 7003;
UPDATE lyrics_dev SET lyric = '気持ちでは負けないし　切り取るの', lyric_col = NULL, col_space = NULL WHERE id = 7004;
UPDATE lyrics_dev SET lyric = 'こう見えたって　心の中
ガラス製なの', lyric_col = NULL, col_space = NULL WHERE id = 7005;
UPDATE lyrics_dev SET lyric = '見えない？　見えない？', lyric_col = NULL, col_space = NULL WHERE id = 7006;
UPDATE lyrics_dev SET lyric = 'ワレモノ注意　切り込み中尉', lyric_col = NULL, col_space = NULL WHERE id = 7007;
UPDATE lyrics_dev SET lyric = 'なんでもかんでも期待しないでよ', lyric_col = NULL, col_space = NULL WHERE id = 7008;
UPDATE lyrics_dev SET lyric = 'アイヘイチュー　ヘイチュー', lyric_col = NULL, col_space = NULL WHERE id = 7009;
UPDATE lyrics_dev SET lyric = '凄惨な街の現状　計算外　むしろ平常？
ノイズだらけこの世界', lyric_col = NULL, col_space = NULL WHERE id = 7010;
UPDATE lyrics_dev SET lyric = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱　狂騒　センセーション', lyric_col = NULL, col_space = NULL WHERE id = 7011;
UPDATE lyrics_dev SET lyric = 'わたし　なんでもかんでもお見通しなの
そう有能', lyric_col = NULL, col_space = NULL WHERE id = 7012;
UPDATE lyrics_dev SET lyric = 'カッティン　カッティン　切り裂いて', lyric_col = NULL, col_space = NULL WHERE id = 7013;
UPDATE lyrics_dev SET lyric = 'ねぇ、アソぼ？', lyric_col = NULL, col_space = NULL WHERE id = 7014;
UPDATE lyrics_dev SET lyric = 'あぁ、彷徨ったって
巻き戻りゃしないわ', lyric_col = NULL, col_space = NULL WHERE id = 7015;
UPDATE lyrics_dev SET lyric = 'もう、やってられないし
癒えない　癒えない', lyric_col = NULL, col_space = NULL WHERE id = 7016;
UPDATE lyrics_dev SET lyric = 'そんじょそこらの
奴らと一緒にしないで', lyric_col = NULL, col_space = NULL WHERE id = 7017;
UPDATE lyrics_dev SET lyric = 'わたしの中じゃ1番なの', lyric_col = NULL, col_space = NULL WHERE id = 7018;
UPDATE lyrics_dev SET lyric = 'そうは言っても　本当のとこ
誰も彼も', lyric_col = NULL, col_space = NULL WHERE id = 7019;
UPDATE lyrics_dev SET lyric = '知らない　知らない', lyric_col = NULL, col_space = NULL WHERE id = 7020;
UPDATE lyrics_dev SET lyric = 'ハレモノだって　バケモノだって', lyric_col = NULL, col_space = NULL WHERE id = 7021;
UPDATE lyrics_dev SET lyric = 'あいつもこいつも酷い仕打ちよね', lyric_col = NULL, col_space = NULL WHERE id = 7022;
UPDATE lyrics_dev SET lyric = 'アイヘイチュー　ヘイチュー', lyric_col = NULL, col_space = NULL WHERE id = 7023;
UPDATE lyrics_dev SET lyric = '体裁だけ気にしちゃって
平静だけは装って', lyric_col = NULL, col_space = NULL WHERE id = 7024;
UPDATE lyrics_dev SET lyric = '一寸先闇の世界　アイ　アイ', lyric_col = NULL, col_space = NULL WHERE id = 7025;
UPDATE lyrics_dev SET lyric = 'もしもにっちもさっちも行かない時はね
ありゃま、絶唱　残響　センセーション', lyric_col = NULL, col_space = NULL WHERE id = 7026;
UPDATE lyrics_dev SET lyric = 'わたし　なんでもかんでもお見通しなの
So,　you　know？', lyric_col = NULL, col_space = NULL WHERE id = 7027;
UPDATE lyrics_dev SET lyric = 'カッティン カッティン 切り裂いて', lyric_col = NULL, col_space = NULL WHERE id = 7028;
UPDATE lyrics_dev SET lyric = '刻むだけ Ah', lyric_col = NULL, col_space = NULL WHERE id = 7029;
UPDATE lyrics_dev SET lyric = '凄惨な街の現状　計算外　むしろ平常？
ノイズだらけこの世界', lyric_col = NULL, col_space = NULL WHERE id = 7030;
UPDATE lyrics_dev SET lyric = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱　狂騒　センセーション', lyric_col = NULL, col_space = NULL WHERE id = 7031;
UPDATE lyrics_dev SET lyric = 'わたし　なんでもかんでもお見通しなの
そう有能', lyric_col = 1, col_space = NULL WHERE id = 7032;
UPDATE lyrics_dev SET lyric = 'カッティン　カッティン
アソびましょ', lyric_col = 2, col_space = 'full' WHERE id = 7033;
UPDATE lyrics_dev SET lyric = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱　狂騒　センセーション', lyric_col = NULL, col_space = NULL WHERE id = 7034;
UPDATE lyrics_dev SET lyric = 'わたし　なんでもかんでもお見通しなの
そう言うの', lyric_col = NULL, col_space = NULL WHERE id = 7035;
UPDATE lyrics_dev SET lyric = 'カッティン　カッティン　切り裂いて', lyric_col = NULL, col_space = NULL WHERE id = 7036;
UPDATE lyrics_dev SET lyric = 'ねぇ、アソぼ？', lyric_col = NULL, col_space = NULL WHERE id = 7037;
