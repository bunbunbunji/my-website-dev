-- 全角スペース→半角スペース統一（Sheet4での手入力結果を反映）
-- 対象: sqlコンバーター_.xlsm の Sheet4 で、歌詞内の全角スペースを
-- 半角スペースに変換したもの。文言そのものの変更はなし（空白文字の
-- 種類のみ）。Pythonで現在のlyrics_devと突き合わせ、空白のみの差分
-- であることを確認済み（不一致0件）。

UPDATE "public"."lyrics_dev" SET "lyric" = '解釈違いの ロマンス手を振って
それじゃ、私、行くね。' WHERE "id" = 1900;
UPDATE "public"."lyrics_dev" SET "lyric" = '湾岸ルーレット ハイウェイ
乗り込んだら もうどこへだって行けそう' WHERE "id" = 1902;
UPDATE "public"."lyrics_dev" SET "lyric" = '夜が明ける頃は 違う私で' WHERE "id" = 1903;
UPDATE "public"."lyrics_dev" SET "lyric" = '今更 泣きついたって
無駄よ 許してあげない
きっと きっと きっとよ' WHERE "id" = 1910;
UPDATE "public"."lyrics_dev" SET "lyric" = '湾岸ルーレット ハイウェイ
乗り込んだら もうどこへだって行けそう' WHERE "id" = 1912;
UPDATE "public"."lyrics_dev" SET "lyric" = '夜が明ける頃は 違う私で' WHERE "id" = 1913;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すこし すこしずつ変われるチャンス' WHERE "id" = 1915;
UPDATE "public"."lyrics_dev" SET "lyric" = '湾岸ルーレット ハイウェイ
涙にそっと 都会のネオンを映す
きらり まとい 素敵 大人になれる' WHERE "id" = 1916;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そうよ 悲しまないで感じるでしょ 予感' WHERE "id" = 1918;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すこし すこしずつ変われるチャンス' WHERE "id" = 1924;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ビバ異端児 そうさ個性が大事' WHERE "id" = 3805;
UPDATE "public"."lyrics_dev" SET "lyric" = '飛び出し注意 なんて無視して' WHERE "id" = 3808;
UPDATE "public"."lyrics_dev" SET "lyric" = '超モードク(Hey↓) ぶっちゃけのモード(ふぉ～ ふぉ～う)' WHERE "id" = 3819;
UPDATE "public"."lyrics_dev" SET "lyric" = '理不尽に不信 変われるぜ Cool Cool Lady' WHERE "id" = 3820;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はいチューモク(はーい↑) きっかけは今日も(ふぉ～ ふぉ～う)' WHERE "id" = 3823;
UPDATE "public"."lyrics_dev" SET "lyric" = '円陣で自信 増し増しで Cool Cool Lady' WHERE "id" = 3824;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ディスコ・ディスコ・ディスコ・ディスコ・
ディスコ・ディスコ ディスコミュニケーション' WHERE "id" = 3827;
UPDATE "public"."lyrics_dev" SET "lyric" = '熱弁・詭弁もごっちゃのジョーシキ
聴いてくれなきゃ 嫌ーね 嫌ーね 嫌ーね' WHERE "id" = 3828;
UPDATE "public"."lyrics_dev" SET "lyric" = '時は金なり まだ見ぬ世界で' WHERE "id" = 3846;
UPDATE "public"."lyrics_dev" SET "lyric" = '超モードク(Hey↓) ぶっちゃけのモード(ふぉ～ ふぉ～う)' WHERE "id" = 3857;
UPDATE "public"."lyrics_dev" SET "lyric" = '理不尽に不信 変われるぜ Cool Cool Lady' WHERE "id" = 3858;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はいチューモク(はーい↑) きっかけは今日も(ふぉ～ ふぉ～う)' WHERE "id" = 3861;
UPDATE "public"."lyrics_dev" SET "lyric" = '円陣で自信 増し増しで Cool Cool Lady' WHERE "id" = 3862;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ディスコ・ディスコ・ディスコ・ディスコ・
ディスコ・ディスコ ディスコミュニケーション' WHERE "id" = 3870;
UPDATE "public"."lyrics_dev" SET "lyric" = '聴いてくれなきゃ 嫌ーね・嫌ーね・嫌ーね' WHERE "id" = 3872;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫' WHERE "id" = 3939;
UPDATE "public"."lyrics_dev" SET "lyric" = 'つまずいても 涙 Bye-bye' WHERE "id" = 3940;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫' WHERE "id" = 3942;
UPDATE "public"."lyrics_dev" SET "lyric" = '手をつないで 涙 Bye-bye' WHERE "id" = 3943;
UPDATE "public"."lyrics_dev" SET "lyric" = '遠くても会おうよ 未来で' WHERE "id" = 3946;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫' WHERE "id" = 3949;
UPDATE "public"."lyrics_dev" SET "lyric" = 'つまずいても 涙 Bye-bye' WHERE "id" = 3950;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫' WHERE "id" = 3952;
UPDATE "public"."lyrics_dev" SET "lyric" = '手をつないで 涙 Bye-bye' WHERE "id" = 3953;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつかきっと 笑おう 未来で' WHERE "id" = 3956;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫
つまずいても 涙 Bye-bye' WHERE "id" = 3962;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫
手をつないで 涙 Bye-bye' WHERE "id" = 3964;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫
つまずいても 涙 Bye-bye' WHERE "id" = 3966;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫' WHERE "id" = 3967;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと大丈夫 大丈夫
手をつないで 涙 Bye-bye' WHERE "id" = 3969;
UPDATE "public"."lyrics_dev" SET "lyric" = '超次元 まじまじ' WHERE "id" = 145;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アアア チェック ワンツー' WHERE "id" = 175;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ああ 超次元 まじまじ' WHERE "id" = 193;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ステキ フォーメーション☆' WHERE "id" = 201;
UPDATE "public"."lyrics_dev" SET "lyric" = '瞳の真ん中 ブラックホールみたいだね' WHERE "id" = 210;
UPDATE "public"."lyrics_dev" SET "lyric" = '予想もつかないような 何かしたい' WHERE "id" = 211;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度でも さぁ' WHERE "id" = 214;
UPDATE "public"."lyrics_dev" SET "lyric" = '開港の瞬間 帆を揚げ進む Right now' WHERE "id" = 1574;
UPDATE "public"."lyrics_dev" SET "lyric" = 'しぶき上げ荒れ狂うWaves 手懐けてみせる' WHERE "id" = 1584;
UPDATE "public"."lyrics_dev" SET "lyric" = '開演の瞬間 君の瞳をRock on' WHERE "id" = 1613;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Say ハロー！ 上々！ どんなんご所望？
うぇるかむとぅ～ざ FRUITS ZIPPER' WHERE "id" = 3561;
UPDATE "public"."lyrics_dev" SET "lyric" = '始まるストーリー 世界攻略！ さぁ、行こう！
やっぱ NEW KAWAII じゃない？' WHERE "id" = 3562;
UPDATE "public"."lyrics_dev" SET "lyric" = '5秒あれば 好きにさせます。
アイドルからの推し 目指してます。' WHERE "id" = 3564;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あっちもこっちも ＃ゆいわずらい
10年前線！ 振りまいてるの 七福神スマイル' WHERE "id" = 3565;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みてよ！ せくしぃ あの子ダンシンクイーン
原宿ラブ ガチなモンスターガール' WHERE "id" = 3568;
UPDATE "public"."lyrics_dev" SET "lyric" = 'マジ真面目すぎ？ あいさつ欠かさん！
ポニテ揺らして 本日もよろしく～？' WHERE "id" = 3569;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Say ハロー！ HARAJUKUへ行こう！
お好きに Pick It FRUITS ZIPPER' WHERE "id" = 3571;
UPDATE "public"."lyrics_dev" SET "lyric" = '超本気(まじ) なんです！ 燦然到来 あつまれ！
最強の七色じゃない？' WHERE "id" = 3572;
UPDATE "public"."lyrics_dev" SET "lyric" = '堂々最年少 ちゅるんとDOLLY EYES
気まぐれだね ふんわりLIKE A CAT' WHERE "id" = 3574;
UPDATE "public"."lyrics_dev" SET "lyric" = 'マルチリンガル 多彩な才 ドイツエンジャパン
わぁ～るどワイドな末っ子ちゃん' WHERE "id" = 3575;
UPDATE "public"."lyrics_dev" SET "lyric" = '3度の飯 カラオケ すき！
アイドルオタク ステージだいすき！' WHERE "id" = 3578;
UPDATE "public"."lyrics_dev" SET "lyric" = 'サバサバなツンデレーション 実は涙もろいって
みんな知ってますか～！？' WHERE "id" = 3579;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Say ハロー！ 上々！ どんなんご所望？
うぇるかむとぅ～ざ FRUITS ZIPPER' WHERE "id" = 3581;
UPDATE "public"."lyrics_dev" SET "lyric" = '感じる？ パッション 愛心送信 とどけて！
全世界 魅せちゃうんじゃない？' WHERE "id" = 3582;
UPDATE "public"."lyrics_dev" SET "lyric" = '泣き虫でも めげない努力
妹気質？ 実は長女です！' WHERE "id" = 3584;
UPDATE "public"."lyrics_dev" SET "lyric" = 'マカロンボイスで奔走中
期待してね♪ すくすくまつかれ 成長中～！' WHERE "id" = 3585;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなを照らす パリピポジティブ
完璧主義で☆派手にGALピ' WHERE "id" = 3588;
UPDATE "public"."lyrics_dev" SET "lyric" = '人間国宝目指すの ふるっぱー''s歌姫(ディーヴァ)
毎日 夏仕様のハッピネス' WHERE "id" = 3589;
UPDATE "public"."lyrics_dev" SET "lyric" = 'たらこLIP 超マイペース
宇宙規模に 引き寄せてる' WHERE "id" = 3592;
UPDATE "public"."lyrics_dev" SET "lyric" = '元気印をあげちゃう みんなにパワー！
締めの一発ギャグ、おねがい～' WHERE "id" = 3593;
UPDATE "public"."lyrics_dev" SET "lyric" = '「フルーツ ジーッ... (今私はあなたのの心をガン見しています) パァ！」' WHERE "id" = 3594;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Say ハロー！ HARAJUKUへ行こう！
お好きに Pick It FRUITS ZIPPER' WHERE "id" = 3595;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぜんぶ揃った 百果繚乱 カラふる
やっぱ NEW KAWAII じゃない？' WHERE "id" = 3596;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ますかるのゆあ ふるふるる' WHERE "id" = 1091;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ますかるのゆあ ふるふるる' WHERE "id" = 1115;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ますかるのゆあ ふるふるる' WHERE "id" = 1123;
UPDATE "public"."lyrics_dev" SET "lyric" = '君を待っていた
そう 出会ってわかったんだ' WHERE "id" = 3743;
UPDATE "public"."lyrics_dev" SET "lyric" = '何もかも映えないエビデイ
突如 現れし王子様' WHERE "id" = 3744;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あふれだす あふれだす
巡り会えた喜びが' WHERE "id" = 3752;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あふれだす あふれだす
見つめ合えばドキドキが' WHERE "id" = 3764;
UPDATE "public"."lyrics_dev" SET "lyric" = '24時間経ってもずっと 消えないストーリーだよ' WHERE "id" = 3768;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だから赤い糸や
ガラスの靴が なくたって見つけ合えたんだ' WHERE "id" = 3771;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あふれだす あふれだす
想いを今 届けよう' WHERE "id" = 3773;
UPDATE "public"."lyrics_dev" SET "lyric" = '100年後も きっと来世も
好きだと言い切れるよ' WHERE "id" = 3777;
UPDATE "public"."lyrics_dev" SET "lyric" = '「愛してください」と心臓
差し出して生きるの もういいの' WHERE "id" = 3973;
UPDATE "public"."lyrics_dev" SET "lyric" = '私が私であること
抱きしめた ただそれだけ' WHERE "id" = 3974;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなが手にした武器では
立てないや ただそれだけ' WHERE "id" = 3976;
UPDATE "public"."lyrics_dev" SET "lyric" = '傷つけないと いつか' WHERE "id" = 3977;
UPDATE "public"."lyrics_dev" SET "lyric" = '傷つけられると カルマ' WHERE "id" = 3979;
UPDATE "public"."lyrics_dev" SET "lyric" = 'この星の外へ今 ついて来たいなら' WHERE "id" = 3981;
UPDATE "public"."lyrics_dev" SET "lyric" = '流星の剣(つるぎ)に硝子(がらす)の鎧(よろい)
誰にも屈しない 戦わないまま' WHERE "id" = 3983;
UPDATE "public"."lyrics_dev" SET "lyric" = '守り抜くからね 心という結晶(クリスタル)' WHERE "id" = 3984;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メテオに乗れ 乙女よ' WHERE "id" = 3986;
UPDATE "public"."lyrics_dev" SET "lyric" = '誓えよ 乙女よ' WHERE "id" = 3987;
UPDATE "public"."lyrics_dev" SET "lyric" = '恐れるもの 振り解いて' WHERE "id" = 3988;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ときめきだけがすべて 光を信じて' WHERE "id" = 3989;
UPDATE "public"."lyrics_dev" SET "lyric" = '二度と負けない ヴァルキリー' WHERE "id" = 3990;
UPDATE "public"."lyrics_dev" SET "lyric" = '「許してください」と低頭(ていとう)
無罪を請(こ)われても ねぇきっと' WHERE "id" = 3994;
UPDATE "public"."lyrics_dev" SET "lyric" = '私は天使じゃないから
さよならね ただ それだけ' WHERE "id" = 3995;
UPDATE "public"."lyrics_dev" SET "lyric" = '何を信じればいい？ とにかく駆けるさ' WHERE "id" = 4000;
UPDATE "public"."lyrics_dev" SET "lyric" = '流星の剣(つるぎ)に硝子(がらす)の鎧(よろい)
誰にも屈しない 戦わないまま' WHERE "id" = 4002;
UPDATE "public"."lyrics_dev" SET "lyric" = '守り抜くからね 心というクリスタル' WHERE "id" = 4003;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メテオに乗れ 乙女よ' WHERE "id" = 4005;
UPDATE "public"."lyrics_dev" SET "lyric" = '誓えよ 乙女よ' WHERE "id" = 4006;
UPDATE "public"."lyrics_dev" SET "lyric" = '恐れるもの ふり解いて' WHERE "id" = 4007;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ときめきだけがすべて 光を信じて' WHERE "id" = 4008;
UPDATE "public"."lyrics_dev" SET "lyric" = '二度と負けない ヴァルキリー' WHERE "id" = 4009;
UPDATE "public"."lyrics_dev" SET "lyric" = '好きなものがあるの ただそれだけ
疑わないでいいの ただまっすぐ 前' WHERE "id" = 4016;
UPDATE "public"."lyrics_dev" SET "lyric" = '抱きしめてたいの 友情という反射(リフレクション)
すべて連れてゆくから' WHERE "id" = 4017;
UPDATE "public"."lyrics_dev" SET "lyric" = '流星の剣(つるぎ)に硝子(がらす)の鎧(よろい)
誰にも屈しない 戦わないまま' WHERE "id" = 4019;
UPDATE "public"."lyrics_dev" SET "lyric" = '守り抜くからね 心という結晶(クリスタル)' WHERE "id" = 4020;
UPDATE "public"."lyrics_dev" SET "lyric" = 'メテオに乗れ 乙女よ' WHERE "id" = 4022;
UPDATE "public"."lyrics_dev" SET "lyric" = '誓えよ 乙女よ' WHERE "id" = 4023;
UPDATE "public"."lyrics_dev" SET "lyric" = '恐れるもの 振り解いて' WHERE "id" = 4024;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ときめきだけがすべて 光を信じて' WHERE "id" = 4025;
UPDATE "public"."lyrics_dev" SET "lyric" = '二度と負けない ヴァルキリー' WHERE "id" = 4026;
UPDATE "public"."lyrics_dev" SET "lyric" = '瞳の奥の祈り 叶えて' WHERE "id" = 4028;
UPDATE "public"."lyrics_dev" SET "lyric" = 'とまらない
切ないほどに いとおしい
アイの告白(メロディー)' WHERE "id" = 3702;
UPDATE "public"."lyrics_dev" SET "lyric" = '雪 のち 恋予報
キラキラ眩しく光るんだって' WHERE "id" = 3704;
UPDATE "public"."lyrics_dev" SET "lyric" = '言えない気持ちと ねぇ' WHERE "id" = 3705;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ふたりの距離 もう溶かしたいよ' WHERE "id" = 3710;
UPDATE "public"."lyrics_dev" SET "lyric" = '体温 感じたいの' WHERE "id" = 3713;
UPDATE "public"."lyrics_dev" SET "lyric" = '困らせてばっかじゃ
どうしよう これ以上' WHERE "id" = 3716;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっと ずっと 前から ずっと ずっと ずっと
キミが...好きでしたっ！' WHERE "id" = 3717;
UPDATE "public"."lyrics_dev" SET "lyric" = 'その瞳(め)でぎゅっと 染められちゃってみたいの' WHERE "id" = 3718;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんて 妄想するだけの未来？' WHERE "id" = 3721;
UPDATE "public"."lyrics_dev" SET "lyric" = '不意打ち どきゅん' WHERE "id" = 3727;
UPDATE "public"."lyrics_dev" SET "lyric" = '輝いて舞い降りたんだ「大好き。」が もう少し....近くで' WHERE "id" = 3734;
UPDATE "public"."lyrics_dev" SET "lyric" = '勇気をください
心に積もる あまいあまい このキモチに' WHERE "id" = 3735;
UPDATE "public"."lyrics_dev" SET "lyric" = '嘘はつけないの もうすぐ 溢れちゃいそうだ！' WHERE "id" = 3736;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっと ずっと 前から ずっと ずっと ずっと
キミが...好きでしたっ！' WHERE "id" = 3737;
UPDATE "public"."lyrics_dev" SET "lyric" = 'その手で ぎゅっと 抱きしめられてみたいの' WHERE "id" = 3738;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんて 想像してるだけじゃない
伝えるよ 今 “アイラブユー”' WHERE "id" = 3741;
UPDATE "public"."lyrics_dev" SET "lyric" = '波打つ ハートのローラーコースター|' WHERE "id" = 3649;
UPDATE "public"."lyrics_dev" SET "lyric" = '喜怒哀楽 気分' WHERE "id" = 3659;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かが泣きそうな夜は
満天の星を そっと届けてあげよう' WHERE "id" = 3698;
UPDATE "public"."lyrics_dev" SET "lyric" = '波打つ ハートのローラーコースター' WHERE "id" = 3701;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりぷりぷりっと プリプリプリティー' WHERE "id" = 747;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はぴはぴはぴっと ハピハピハッピー' WHERE "id" = 748;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぶらぶらぶらっと ブラブラブラボー' WHERE "id" = 749;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はーい さあみんなあそぼう' WHERE "id" = 753;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりぷりぷりっと プリプリプリティー' WHERE "id" = 774;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はぴはぴはぴっと ハピハピハッピー' WHERE "id" = 775;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぶらぶらぶらっと ブラブラブラボー' WHERE "id" = 776;
UPDATE "public"."lyrics_dev" SET "lyric" = '毎日 毎毎日 Do what you like' WHERE "id" = 784;
UPDATE "public"."lyrics_dev" SET "lyric" = '大好き 大大好き Do what you like' WHERE "id" = 786;
UPDATE "public"."lyrics_dev" SET "lyric" = '胸がいっぱい いっぱい Do what you like' WHERE "id" = 788;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんか照れちゃうな どぅわどぅわどぅわちゃらいっ！' WHERE "id" = 790;
UPDATE "public"."lyrics_dev" SET "lyric" = '得意も不得意も 得手も苦手も' WHERE "id" = 806;
UPDATE "public"."lyrics_dev" SET "lyric" = '晴れのち雨も 雨のち晴れも' WHERE "id" = 808;
UPDATE "public"."lyrics_dev" SET "lyric" = '忘れないでね 君と僕とのお約束' WHERE "id" = 813;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりぷりぷりっと プリプリプリティー' WHERE "id" = 828;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はぴはぴはぴっと ハピハピハッピー' WHERE "id" = 829;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぶらぶらぶらっと ブラブラブラボー' WHERE "id" = 830;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ピポパ って言うだけで
え、ハッピー' WHERE "id" = 2990;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キラキラ まぶしくて
ついつい ウィンクしちゃう' WHERE "id" = 2995;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつまでも (も!)' WHERE "id" = 2998;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこまでも (も!)' WHERE "id" = 3000;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なによりも (も!)' WHERE "id" = 3002;
UPDATE "public"."lyrics_dev" SET "lyric" = 'だれよりも (も!)' WHERE "id" = 3004;
UPDATE "public"."lyrics_dev" SET "lyric" = 'NEW KAWAII ってなーに
知りたくなーい？' WHERE "id" = 3009;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すごいね (すごいね!) OK (OK!)' WHERE "id" = 3012;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ちょ、まって
ちょ、まって
ちょ、まって 今' WHERE "id" = 3015;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すごいね (すごいね!) OK (OK!)' WHERE "id" = 3036;
UPDATE "public"."lyrics_dev" SET "lyric" = 'NEW KAWAII ってなーに
知りたくなーい？' WHERE "id" = 3050;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もーっともっともっと おかわりちょうだい' WHERE "id" = 3051;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すごいね (すごいね!) OK (OK!)' WHERE "id" = 3053;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんでもかんでも かわいいんだもん' WHERE "id" = 3055;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ちょ、まって
ちょ、まって
ちょ、まって 今' WHERE "id" = 3056;
UPDATE "public"."lyrics_dev" SET "lyric" = 'え、まって
え、まって
え、まって 今' WHERE "id" = 3057;
UPDATE "public"."lyrics_dev" SET "lyric" = '激流 予測不可能に身を任せ' WHERE "id" = 3073;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どデカい事 ハッタリかましてこう' WHERE "id" = 3099;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そんなUP＆DOWN 繰り返しながら' WHERE "id" = 3117;
UPDATE "public"."lyrics_dev" SET "lyric" = '少年と少女 いつかのような青春を' WHERE "id" = 3119;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday だれもみんな
それぞれの甘酸っぱさを持って生きてる' WHERE "id" = 3491;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday 君といれば
そのままでも変わっても良いって知ってる' WHERE "id" = 3494;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday だれもみんな
それぞれの甘酸っぱさを持って生きてる' WHERE "id" = 3504;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday 君がいれば
生きているそれだけで良いって知ってる' WHERE "id" = 3507;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday だれもみんな' WHERE "id" = 3513;
UPDATE "public"."lyrics_dev" SET "lyric" = 'everyday 君といれば
そのままでも変わっても良いって知ってる' WHERE "id" = 3516;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と過ごしたい夏が
全速力 やってきた
誰にも負けない永遠の Stay Gold' WHERE "id" = 652;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アソビなんだ 本気でたたかえ' WHERE "id" = 654;
UPDATE "public"."lyrics_dev" SET "lyric" = '熱くなれ 太陽よりもいちばん
熱くなれ 輝いているのは誰だ？' WHERE "id" = 655;
UPDATE "public"."lyrics_dev" SET "lyric" = '原宿大好き ダンスリーダー' WHERE "id" = 657;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ステージにあがる瞬間 切り替えるスイッチ' WHERE "id" = 659;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰もが持ってるこのパワー 宇宙まで届け' WHERE "id" = 660;
UPDATE "public"."lyrics_dev" SET "lyric" = '振りまわせ 真夏の魅惑 Summer！！
熱くなれ 太陽も溶ける Hot Dream' WHERE "id" = 665;
UPDATE "public"."lyrics_dev" SET "lyric" = '声あげろ この夏を楽しむ戦いは' WHERE "id" = 666;
UPDATE "public"."lyrics_dev" SET "lyric" = '始まっているのだから さぁ' WHERE "id" = 667;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなでゆくのさ ふれふるサマービーチ
Ah 火照ったカラダ Summer Song' WHERE "id" = 668;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あー アイドル全開！極めるならやっぱりコレよね' WHERE "id" = 669;
UPDATE "public"."lyrics_dev" SET "lyric" = 'グループみんなを歌でひっぱる それなら任せて' WHERE "id" = 670;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰よりポジティブでパリピ 楽しまなきゃでしょ' WHERE "id" = 671;
UPDATE "public"."lyrics_dev" SET "lyric" = 'この夏 いちばんの' WHERE "id" = 672;
UPDATE "public"."lyrics_dev" SET "lyric" = '振りまわせ 空も飛べちゃうくらい
熱くなれ 砂浜も焦がすほどに' WHERE "id" = 677;
UPDATE "public"."lyrics_dev" SET "lyric" = '声あげろ ひと夏の約束' WHERE "id" = 678;
UPDATE "public"."lyrics_dev" SET "lyric" = '交わした
ままで 今 君はどこにいるの？' WHERE "id" = 679;
UPDATE "public"."lyrics_dev" SET "lyric" = 'この夏は いつまでも終わらない' WHERE "id" = 682;
UPDATE "public"."lyrics_dev" SET "lyric" = 'この夏に 君が焼き付けるのは誰？' WHERE "id" = 683;
UPDATE "public"."lyrics_dev" SET "lyric" = '声あげろ 永遠の始まり それはそう' WHERE "id" = 684;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっとこの場所だから さぁ' WHERE "id" = 685;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなでゆくのさ ふれふるサマービーチ
Ah 火照ったカラダ Summer Song' WHERE "id" = 686;
UPDATE "public"."lyrics_dev" SET "lyric" = '振りまわせ 真夏の魅惑 Summer！！
熱くなれ 太陽も溶ける Hot Dream' WHERE "id" = 687;
UPDATE "public"."lyrics_dev" SET "lyric" = '声あげろ この夏を楽しむ戦いは' WHERE "id" = 688;
UPDATE "public"."lyrics_dev" SET "lyric" = '始まっているのだから さぁ' WHERE "id" = 689;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなで飛ぶのさ ふれふるサマービーチ' WHERE "id" = 690;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah 火照ったカラダ 燃やそう' WHERE "id" = 691;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなでゆくのさ ふれふるサマービーチ
Ah 火照ったカラダ Summer Song' WHERE "id" = 695;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度 バカと呼ばれたって
もしもあざ笑われたって' WHERE "id" = 101;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつも 真っ直ぐでいられるのは…' WHERE "id" = 102;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつも 真っ直ぐでいられるのは…' WHERE "id" = 103;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつも 真っ直ぐでいられるのは…
君が…' WHERE "id" = 104;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度 バカと呼ばれたって
もしもあざ笑われたって' WHERE "id" = 115;
UPDATE "public"."lyrics_dev" SET "lyric" = '大丈夫！(ほら) 大丈夫！(ほら)
大丈夫！(ほら) 大丈夫だよ！' WHERE "id" = 117;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつも 真っ直ぐでいられるのは
君がいるから' WHERE "id" = 120;
UPDATE "public"."lyrics_dev" SET "lyric" = '明日も(その) 明日も(その)
明日も(その) 明日もずっと' WHERE "id" = 121;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ねぇ 知ってるかな？
こんなに愛してること' WHERE "id" = 123;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ねぇ 知ってるかな？
キツい夜どうしてるか' WHERE "id" = 126;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度 バカと呼ばれたって
もしもあざ笑われたって' WHERE "id" = 133;
UPDATE "public"."lyrics_dev" SET "lyric" = '明日も(その) 明日も(その)
明日も(その) 明日もずっと' WHERE "id" = 135;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度 バカと呼ばれたって
もしもあざ笑われたって' WHERE "id" = 137;
UPDATE "public"."lyrics_dev" SET "lyric" = '大丈夫！(ほら) 大丈夫！(ほら)
大丈夫！(ほら) 大丈夫だよ！' WHERE "id" = 139;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつも 真っ直ぐでいられるのは
君がいるから' WHERE "id" = 142;
UPDATE "public"."lyrics_dev" SET "lyric" = '明日も(その) 明日も(その)
明日も(その) 明日もずっと' WHERE "id" = 143;
UPDATE "public"."lyrics_dev" SET "lyric" = '爽やかな朝日 まだ静かな街' WHERE "id" = 58;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんなドラマ待ってるのか ワクワクで開くドア' WHERE "id" = 59;
UPDATE "public"."lyrics_dev" SET "lyric" = '運命とか偶然 信じてないけど' WHERE "id" = 60;
UPDATE "public"."lyrics_dev" SET "lyric" = '今日はなんだか 特別になる予感がする' WHERE "id" = 61;
UPDATE "public"."lyrics_dev" SET "lyric" = '巡り合って 語り合って
素敵な夢がはじまる' WHERE "id" = 66;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰にだって 言えなかった
愛と情熱の LIBERTY FORCE' WHERE "id" = 68;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなで行こう 地図にない場所へ' WHERE "id" = 69;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わかりあえなくて すれ違うときも' WHERE "id" = 71;
UPDATE "public"."lyrics_dev" SET "lyric" = '見つめあって ただ黙って
流れる時間も好きだ' WHERE "id" = 81;
UPDATE "public"."lyrics_dev" SET "lyric" = '認めあって 伝えあった
愛と友情のLIBERTY FORCE' WHERE "id" = 83;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰にだって 隠したって
隠しきれない愛がある' WHERE "id" = 89;
UPDATE "public"."lyrics_dev" SET "lyric" = '言葉でさ ちゃんと伝えていくよ' WHERE "id" = 90;
UPDATE "public"."lyrics_dev" SET "lyric" = '君にだって 僕にだって
それぞれひとつのLIBERTY FORCE' WHERE "id" = 91;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこでも行ける 自由を信じて' WHERE "id" = 92;
UPDATE "public"."lyrics_dev" SET "lyric" = '巡り合って 混ざり合って
素敵な夢をはじめよう' WHERE "id" = 93;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなで行こう もっと遠くまで' WHERE "id" = 96;
UPDATE "public"."lyrics_dev" SET "lyric" = '世界が始まる予感 時が止まるような ドキドキ 感情波打った' WHERE "id" = 1524;
UPDATE "public"."lyrics_dev" SET "lyric" = '今から 今から 今から 届けるよ You are my treasure' WHERE "id" = 1525;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝えたい気持ちが 溢れた心を泳いで' WHERE "id" = 1526;
UPDATE "public"."lyrics_dev" SET "lyric" = '声にならない 吐き出せない 不器用すぎて嫌になる' WHERE "id" = 1527;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どうにもこうにも ならない日々に
向き合うこと教えてくれた' WHERE "id" = 1528;
UPDATE "public"."lyrics_dev" SET "lyric" = '見上げた 空は青く光る' WHERE "id" = 1529;
UPDATE "public"."lyrics_dev" SET "lyric" = '世界が始まる予感 トキメキを運んだ
きっと後には戻れないような' WHERE "id" = 1531;
UPDATE "public"."lyrics_dev" SET "lyric" = 'それでも それでも それでも 届けるよ You are my treasure' WHERE "id" = 1532;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah この両手に 抱えきれないくらいの想いを' WHERE "id" = 1533;
UPDATE "public"."lyrics_dev" SET "lyric" = 'モノクロ物語だった 色をつけてくれたのはキミさ' WHERE "id" = 1534;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとずっと 描き続けるよ' WHERE "id" = 1535;
UPDATE "public"."lyrics_dev" SET "lyric" = '嘘じゃない
瞬間 輝いた' WHERE "id" = 1536;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝えようとしても グルグル回り続けては' WHERE "id" = 1537;
UPDATE "public"."lyrics_dev" SET "lyric" = '言い訳を考えてる きっかけの音を鳴らして' WHERE "id" = 1538;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どうせこのままじゃ 何も変わらない
口癖 挫けそうになっても' WHERE "id" = 1539;
UPDATE "public"."lyrics_dev" SET "lyric" = '光を辿れば キミだった' WHERE "id" = 1540;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつだって 側にいてくれた' WHERE "id" = 1541;
UPDATE "public"."lyrics_dev" SET "lyric" = '世界が始まる予感 トキメキを運んだ きっと後には戻れないような' WHERE "id" = 1542;
UPDATE "public"."lyrics_dev" SET "lyric" = 'それでも それでも それでも 届けるよ You are my treasure' WHERE "id" = 1543;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah この両手に 抱えきれないくらいの想いを' WHERE "id" = 1544;
UPDATE "public"."lyrics_dev" SET "lyric" = 'モノクロ 物語だった 色をつけてくれたのはキミさ' WHERE "id" = 1545;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとずっと 描き続けるよ' WHERE "id" = 1546;
UPDATE "public"."lyrics_dev" SET "lyric" = '嘘じゃない 瞬間 輝いた' WHERE "id" = 1547;
UPDATE "public"."lyrics_dev" SET "lyric" = '今ここにいる意味を ここから見える景色も全部' WHERE "id" = 1548;
UPDATE "public"."lyrics_dev" SET "lyric" = '重ねたらキミが映った ありがとうと愛してるを 伝えたくて' WHERE "id" = 1549;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ここから これから先も
ずっと一緒だって 忘れられないよう刻むんだ' WHERE "id" = 1550;
UPDATE "public"."lyrics_dev" SET "lyric" = '何度も 何度も 何度も 何度も' WHERE "id" = 1551;
UPDATE "public"."lyrics_dev" SET "lyric" = '世界はこんなにも美しかったんだ 巡り巡る季節感じて' WHERE "id" = 1553;
UPDATE "public"."lyrics_dev" SET "lyric" = 'このまま このまま このまま 夢を見よう You are my treasure' WHERE "id" = 1554;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah この両手に' WHERE "id" = 1555;
UPDATE "public"."lyrics_dev" SET "lyric" = 'モノクロ 物語だった 色をつけてくれたのはキミさ' WHERE "id" = 1557;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとずっと 描き続けるよ' WHERE "id" = 1558;
UPDATE "public"."lyrics_dev" SET "lyric" = '嘘じゃない 瞬間 輝いた' WHERE "id" = 1559;
UPDATE "public"."lyrics_dev" SET "lyric" = '大事な 大事な 大事な 大事な
大事なきみに出会えたんです' WHERE "id" = 4584;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほしいモノはただ一つ でも、
ひ み つ' WHERE "id" = 4593;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まだまだだ バタバタタ
頑張るるのだだ' WHERE "id" = 4595;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まだまだだ バタバタタ
頑張るるのだだ' WHERE "id" = 4624;
UPDATE "public"."lyrics_dev" SET "lyric" = '（oh めでたい）' WHERE "id" = 3154;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はい せーの！）' WHERE "id" = 3440;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぎゅってしたら大丈夫だよ ほら ね' WHERE "id" = 3444;
UPDATE "public"."lyrics_dev" SET "lyric" = 'YO シャッター越しじゃわかんない心裏' WHERE "id" = 3455;
UPDATE "public"."lyrics_dev" SET "lyric" = '（はい せーの！）' WHERE "id" = 3466;
UPDATE "public"."lyrics_dev" SET "lyric" = '自分の道切り開く 後悔はしないよ' WHERE "id" = 4745;
UPDATE "public"."lyrics_dev" SET "lyric" = '無駄にはしない 間違ってない' WHERE "id" = 4748;
UPDATE "public"."lyrics_dev" SET "lyric" = '運命 きみと
邂逅のダンシング' WHERE "id" = 5972;
UPDATE "public"."lyrics_dev" SET "lyric" = '隣で笑っていたいな 遠回りも
キャンディーになったね食べちゃうぞ' WHERE "id" = 5975;
UPDATE "public"."lyrics_dev" SET "lyric" = 'それでも孤独感はない 手が触れたの確かな存在に
アイラビュー！' WHERE "id" = 5984;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ベロシティMAX CHANCE! 響かす JUMP' WHERE "id" = 6338;
UPDATE "public"."lyrics_dev" SET "lyric" = '巡り会えた波長 溶かして' WHERE "id" = 6339;
UPDATE "public"."lyrics_dev" SET "lyric" = '遥か 宙に舞え' WHERE "id" = 6340;
UPDATE "public"."lyrics_dev" SET "lyric" = '笑って泣いて 進んでいくんだ 自分らしく' WHERE "id" = 6342;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あがいて はって もがいてだって 自分らしく' WHERE "id" = 6345;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま 解き放つんだムーヴ' WHERE "id" = 6346;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6348;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6350;
UPDATE "public"."lyrics_dev" SET "lyric" = 'CHOICE! 引き出す AMP
決意見えた波長 揺らいで' WHERE "id" = 6363;
UPDATE "public"."lyrics_dev" SET "lyric" = '遥か 宙に舞え' WHERE "id" = 6364;
UPDATE "public"."lyrics_dev" SET "lyric" = '迷ってたって 進んでいくんだ 時間だけは' WHERE "id" = 6366;
UPDATE "public"."lyrics_dev" SET "lyric" = '悩んで 待って 彷徨ってないで 自分らしく' WHERE "id" = 6369;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま 解き放つんだムーヴ' WHERE "id" = 6370;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6372;
UPDATE "public"."lyrics_dev" SET "lyric" = 'フルドライブ歪ませ 半端は嫌さ' WHERE "id" = 6373;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6374;
UPDATE "public"."lyrics_dev" SET "lyric" = '分かってるんだ 答えはいつも自分らしく' WHERE "id" = 6391;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あがいて はって
もがいて だって 自分らしく' WHERE "id" = 6394;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ありのまま 解き放つんだムーヴ' WHERE "id" = 6395;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6397;
UPDATE "public"."lyrics_dev" SET "lyric" = 'フルボリューム鳴らして 半端は嫌さ' WHERE "id" = 6398;
UPDATE "public"."lyrics_dev" SET "lyric" = 'TUNE MY WAY TUNE MY WAY' WHERE "id" = 6399;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah 与え' WHERE "id" = 5926;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたししかできない できない' WHERE "id" = 5940;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Ah 誰も' WHERE "id" = 5943;
UPDATE "public"."lyrics_dev" SET "lyric" = '今はまだ足りない 足りない' WHERE "id" = 5957;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたししかできない できない' WHERE "id" = 5966;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コイしちゃって♡ アイしちゃってます♡' WHERE "id" = 5830;
UPDATE "public"."lyrics_dev" SET "lyric" = 'コイしちゃって♡ アイしちゃってます♡' WHERE "id" = 5869;
UPDATE "public"."lyrics_dev" SET "lyric" = '大事な 時間だった' WHERE "id" = 6210;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう一度はじめよう プロローグ' WHERE "id" = 6211;
UPDATE "public"."lyrics_dev" SET "lyric" = '届け 運命の交差点 プロローグ' WHERE "id" = 6240;
UPDATE "public"."lyrics_dev" SET "lyric" = '素敵な景色 見よう (一緒に)' WHERE "id" = 6266;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ここのみんなで (ここのみんなで)' WHERE "id" = 6272;
UPDATE "public"."lyrics_dev" SET "lyric" = '終わらない 旅路へ' WHERE "id" = 6273;
UPDATE "public"."lyrics_dev" SET "lyric" = 'すばらしい ゆるゆるしい' WHERE "id" = 6813;
UPDATE "public"."lyrics_dev" SET "lyric" = '考えても わからないことも' WHERE "id" = 6815;
UPDATE "public"."lyrics_dev" SET "lyric" = 'えーっと なにか忘れものないかなぁ？' WHERE "id" = 6817;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ねぇ 心やわらかリュブリカント' WHERE "id" = 6820;
UPDATE "public"."lyrics_dev" SET "lyric" = 'シェラカップに足す夢を ひとつ' WHERE "id" = 6821;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほらLucky Lucky Lucky 小さな一歩
Lucky Lucky なに持ってこう？' WHERE "id" = 6827;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとLucky Lucky Lucky 風のさきっぽ
Lucky Lucky まだまだ旅は続く' WHERE "id" = 6828;
UPDATE "public"."lyrics_dev" SET "lyric" = '時間を忘れて
あたたかい火 ながめてみる' WHERE "id" = 6835;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほらJourney Journey Journey 小さなヒント
Journey Journey 探してる' WHERE "id" = 6840;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとJourney Journey Journey 笑顔のピント
Journey Journey 楽しい旅は続く' WHERE "id" = 6841;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほらLucky Lucky Lucky 小さな一歩
Lucky Lucky なに持ってこう？' WHERE "id" = 6846;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もっとLucky Lucky Lucky 風のさきっぽ
Lucky Lucky まだまだ旅は続く' WHERE "id" = 6847;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ラララ ラララ ラララララララ
ラララ ラララ ララ' WHERE "id" = 6067;
UPDATE "public"."lyrics_dev" SET "lyric" = '胸の中の想いが
歌うメロディ 揺れるハーモニー' WHERE "id" = 6069;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ラララ ラララ ラララララララ
ラララ ラララ ララ' WHERE "id" = 6103;
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか ゾンビですね' WHERE "id" = 1401;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もげちゃったり 千切れちゃったりたりらり' WHERE "id" = 1402;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1405;
UPDATE "public"."lyrics_dev" SET "lyric" = '死して彷徨い 来るぞ さぁ Run！' WHERE "id" = 1420;
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか ゾンビですね
もげちゃったり 千切れちゃったりたりらり' WHERE "id" = 1421;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけ見つめて Deadly
冥界に 冥界に 冥界に 冥界' WHERE "id" = 1422;
UPDATE "public"."lyrics_dev" SET "lyric" = '私ゾンビですか ゾンビですよ
歌ったり 囓っちゃったりたりらり' WHERE "id" = 1423;
UPDATE "public"."lyrics_dev" SET "lyric" = '眠れない夜 月夜月夜に' WHERE "id" = 1425;
UPDATE "public"."lyrics_dev" SET "lyric" = '腐乱腐乱腐乱 のが可愛い' WHERE "id" = 1426;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんな時代に 朽ち果てそうでも' WHERE "id" = 1428;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1431;
UPDATE "public"."lyrics_dev" SET "lyric" = '死して彷徨い 来るぞ さぁ Run！' WHERE "id" = 1451;
UPDATE "public"."lyrics_dev" SET "lyric" = '君もゾンビですか ゾンビですね
もげちゃったり 千切れちゃったりたりらり' WHERE "id" = 1452;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけ見つめて Deadly
冥界に 冥界に 冥界に 冥界' WHERE "id" = 1453;
UPDATE "public"."lyrics_dev" SET "lyric" = '私ゾンビですか ゾンビですよ
歌ったり 囓っちゃったりたりらり' WHERE "id" = 1454;
UPDATE "public"."lyrics_dev" SET "lyric" = '眠れない夜 月夜月夜に' WHERE "id" = 1456;
UPDATE "public"."lyrics_dev" SET "lyric" = '腐乱腐乱腐乱 のが可愛い' WHERE "id" = 1457;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんな時代に 朽ち果てそうでも' WHERE "id" = 1459;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ゾンビですか ゾンビですね
ゾンビですか ゾンビですね' WHERE "id" = 1462;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！
推し 好き しんどい！' WHERE "id" = 1929;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！
推しが好きすぎて しんどい！' WHERE "id" = 1930;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あ゛～ もう無理！
好きの許容量がオーバー
なーんもする気になんない' WHERE "id" = 1931;
UPDATE "public"."lyrics_dev" SET "lyric" = '推しって 世界を救ってない？' WHERE "id" = 1933;
UPDATE "public"."lyrics_dev" SET "lyric" = '好き過ぎて 食べちゃいたい' WHERE "id" = 1934;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ポケットに入れて 持ち帰りたい' WHERE "id" = 1935;
UPDATE "public"."lyrics_dev" SET "lyric" = '剥製にして お部屋に飾りたい' WHERE "id" = 1936;
UPDATE "public"."lyrics_dev" SET "lyric" = 'え それはちょっと引くわ' WHERE "id" = 1937;
UPDATE "public"."lyrics_dev" SET "lyric" = 'SNS 更新だけで' WHERE "id" = 1938;
UPDATE "public"."lyrics_dev" SET "lyric" = '酸素が 濃くなる感覚' WHERE "id" = 1939;
UPDATE "public"."lyrics_dev" SET "lyric" = '日々日々 輝き増してく' WHERE "id" = 1941;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もはや 太陽' WHERE "id" = 1942;
UPDATE "public"."lyrics_dev" SET "lyric" = '「あ゛～ 好き」' WHERE "id" = 1943;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝説レベルで 尊いって！
好きが過ぎて わけがわかんない' WHERE "id" = 1944;
UPDATE "public"."lyrics_dev" SET "lyric" = '日常 支障きたしてます
はい！推し 好き (はぁ)しんどい！' WHERE "id" = 1945;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって てててて てぇてぇって！' WHERE "id" = 1946;
UPDATE "public"."lyrics_dev" SET "lyric" = '語彙力 終わってるよ' WHERE "id" = 1947;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！' WHERE "id" = 1964;
UPDATE "public"."lyrics_dev" SET "lyric" = '説明するね！ キュートアグレッションとは
かわいいものを見ることによって引き起こされる衝動的行動である。
かわいいと思った対象を噛んだりつまんだり
きつく抱きしめたい衝動を感じることがあるとされる。つまりは' WHERE "id" = 1965;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！
推し 好き しんどい！' WHERE "id" = 1966;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！
推しが好きすぎて しんどい！' WHERE "id" = 1967;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かと シェアしたいけど' WHERE "id" = 1968;
UPDATE "public"."lyrics_dev" SET "lyric" = '解釈 揉めたくないしなあ' WHERE "id" = 1969;
UPDATE "public"."lyrics_dev" SET "lyric" = '君という 存在が私の' WHERE "id" = 1971;
UPDATE "public"."lyrics_dev" SET "lyric" = '生きてる 理由' WHERE "id" = 1972;
UPDATE "public"."lyrics_dev" SET "lyric" = '「あ゛～ 優勝」' WHERE "id" = 1973;
UPDATE "public"."lyrics_dev" SET "lyric" = '宇宙クラスで 尊いって！
同じ時代 生きてる最高' WHERE "id" = 1974;
UPDATE "public"."lyrics_dev" SET "lyric" = '君次第の人生だ
もお！推し 好き (はぁ)しんどい！' WHERE "id" = 1975;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって てててて てぇてぇって!' WHERE "id" = 1976;
UPDATE "public"."lyrics_dev" SET "lyric" = '偏差値3 くらいだよ' WHERE "id" = 1977;
UPDATE "public"."lyrics_dev" SET "lyric" = '全部 すっ飛ばし 最優先
君のこと 推してます' WHERE "id" = 1978;
UPDATE "public"."lyrics_dev" SET "lyric" = '痛いくらいに好き、て ほんとにあるんだね' WHERE "id" = 1979;
UPDATE "public"."lyrics_dev" SET "lyric" = '初恋の100万倍 胸が痛いよ' WHERE "id" = 1980;
UPDATE "public"."lyrics_dev" SET "lyric" = '甘い底なし沼に もっと溺れさせてね' WHERE "id" = 1981;
UPDATE "public"."lyrics_dev" SET "lyric" = '君で いっぱいだから' WHERE "id" = 1982;
UPDATE "public"."lyrics_dev" SET "lyric" = '「てぇてぇ てててて てぇてぇてぇ」' WHERE "id" = 1983;
UPDATE "public"."lyrics_dev" SET "lyric" = '「てぇてぇ てててて てぇてぇてぇ」' WHERE "id" = 1985;
UPDATE "public"."lyrics_dev" SET "lyric" = '（※産まれてきてくれて ありがとう）' WHERE "id" = 1986;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝説レベルで 尊いって！
好きが過ぎて わけがわかんない' WHERE "id" = 1987;
UPDATE "public"."lyrics_dev" SET "lyric" = '日常 支障きたしてます
はい！推し 好き (はぁ)しんどい！' WHERE "id" = 1988;
UPDATE "public"."lyrics_dev" SET "lyric" = 'てぇてぇって てててて てぇてぇって！' WHERE "id" = 1989;
UPDATE "public"."lyrics_dev" SET "lyric" = '語彙力 終わってるよ' WHERE "id" = 1990;
UPDATE "public"."lyrics_dev" SET "lyric" = '推し 好き しんどい！
推し 好き しんどい！' WHERE "id" = 2007;
UPDATE "public"."lyrics_dev" SET "lyric" = '推しが好きすぎて しんどい！' WHERE "id" = 2008;
UPDATE "public"."lyrics_dev" SET "lyric" = '犬すき！(Fu～) 赤子すき！(Fu～)
平成ギャルリスペクト！ (Pon！Pon！)' WHERE "id" = 6127;
UPDATE "public"."lyrics_dev" SET "lyric" = '母性のかたまり！ (うりゃおい！)
カメラもめちゃうま！ (うりゃおい！)' WHERE "id" = 6132;
UPDATE "public"."lyrics_dev" SET "lyric" = 'お肌がマシュマロ！ (ふわふわ！)
癒し系食いしん坊！ (ふわふわ！)' WHERE "id" = 6141;
UPDATE "public"."lyrics_dev" SET "lyric" = '性格おっとり おバレリーナ！ (いいじゃん！)
実は おつよい破壊神！ (いいじゃん！)' WHERE "id" = 6146;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Yeah,真面目な黒猫ちゃん！ (Hey！Yo！)
ウィンク完璧じゃん！ (Hey！Yo！)' WHERE "id" = 6155;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さみしがり屋な王子様！ (イケメン！)
ポエマー＆エンジェルフェイス！ (イケメン！)' WHERE "id" = 6160;
UPDATE "public"."lyrics_dev" SET "lyric" = '圧倒的にポジティブ！ (Hi！Hi！)
存在がミラーボール！ (Hi！Hi！)' WHERE "id" = 6165;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE' WHERE "id" = 569;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE）' WHERE "id" = 570;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE' WHERE "id" = 571;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE）' WHERE "id" = 572;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なりたい 在りたい けど だけど...' WHERE "id" = 574;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なりたい 在りたい けど だけど...' WHERE "id" = 576;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かを救うということは 過去の自分も救うことです' WHERE "id" = 577;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かを愛すということは 本当の自分を大好きになることです' WHERE "id" = 578;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
何回転んでも 立ち上がれ' WHERE "id" = 579;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
厄介な問題も飛び越えろ' WHERE "id" = 580;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の バイのバイでもっと行こうよ' WHERE "id" = 585;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT' WHERE "id" = 586;
UPDATE "public"."lyrics_dev" SET "lyric" = '飽き性 根性ない状況' WHERE "id" = 587;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やめたい やめたい けどだけど...' WHERE "id" = 588;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やめたい やめたい けどだけど...' WHERE "id" = 590;
UPDATE "public"."lyrics_dev" SET "lyric" = '何かを犠牲にすることは 何かを目指すということです' WHERE "id" = 591;
UPDATE "public"."lyrics_dev" SET "lyric" = '何かを目指すということは 何かを本気で信じるということです' WHERE "id" = 592;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
なんてまあ素敵なこの人生' WHERE "id" = 593;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
だって私はそう私だもん' WHERE "id" = 594;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の バイのバイでもっと行こうよ' WHERE "id" = 599;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT' WHERE "id" = 600;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE' WHERE "id" = 601;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE）' WHERE "id" = 602;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE' WHERE "id" = 603;
UPDATE "public"."lyrics_dev" SET "lyric" = '（倍の倍のFIGHT 倍倍FIGHT by CANDY TUNE）' WHERE "id" = 604;
UPDATE "public"."lyrics_dev" SET "lyric" = '自分を大事に 本音を大事に つまずいたって' WHERE "id" = 605;
UPDATE "public"."lyrics_dev" SET "lyric" = '有言実行 言葉に宿った魂信じて' WHERE "id" = 609;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰かと比べて落ち込んだって 自分は自分さ' WHERE "id" = 611;
UPDATE "public"."lyrics_dev" SET "lyric" = '半径100km 幸せで満たしたいな' WHERE "id" = 613;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍倍アクティブ byebyeパッシブ' WHERE "id" = 620;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
なんと言われても諦めぬ' WHERE "id" = 632;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
人生これっきり 一度っきり' WHERE "id" = 633;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
何回転んでも 立ち上がれ' WHERE "id" = 634;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT
厄介な問題も飛び越えろ' WHERE "id" = 635;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ほら倍の倍の バイのバイでもっと行こうよ' WHERE "id" = 640;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍倍FIGHT 倍倍倍FIGHT' WHERE "id" = 641;
UPDATE "public"."lyrics_dev" SET "lyric" = '倍FIGHT 倍FIGHT 倍FIGHT' WHERE "id" = 651;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうタイムない
タイムライン ギュウギュウグルグル
オウマイ' WHERE "id" = 6289;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうタイムない
タイムライン ギュウギュウグルグル
オウマイ' WHERE "id" = 6312;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow ドキドキ隠して' WHERE "id" = 2010;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 君とデート' WHERE "id" = 2011;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 魔法をかけてよ' WHERE "id" = 2012;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow あいらびゅー らびゅー' WHERE "id" = 2013;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きらり メイクして' WHERE "id" = 2014;
UPDATE "public"."lyrics_dev" SET "lyric" = '私自信ないけど 初めてばかりだけど
きっときっと この気持ちだけは' WHERE "id" = 2022;
UPDATE "public"."lyrics_dev" SET "lyric" = '誰にも負けないくらい 君と一緒に居たい' WHERE "id" = 2023;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう一歩 さぁもう一歩' WHERE "id" = 2024;
UPDATE "public"."lyrics_dev" SET "lyric" = '触れていたい左手 ぎゅっと' WHERE "id" = 2028;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow ドキドキ隠して' WHERE "id" = 2035;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 君とデート' WHERE "id" = 2036;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 魔法をかけてよ' WHERE "id" = 2037;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow あいらびゅー らびゅー' WHERE "id" = 2038;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ひらり 揺らすスカート' WHERE "id" = 2039;
UPDATE "public"."lyrics_dev" SET "lyric" = '胸のリボン 完璧' WHERE "id" = 2040;
UPDATE "public"."lyrics_dev" SET "lyric" = '香水は甘め 君の好み' WHERE "id" = 2041;
UPDATE "public"."lyrics_dev" SET "lyric" = '君も緊張してる？ 初めて見たその服
きっときっと今日私のため' WHERE "id" = 2047;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そんな意外なとこも 独り占めしたくなる' WHERE "id" = 2048;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もうちょっと ねぇもうちょっと' WHERE "id" = 2049;
UPDATE "public"."lyrics_dev" SET "lyric" = '今日は君の横 予約しちゃった' WHERE "id" = 2052;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow ドキドキ隠して' WHERE "id" = 2061;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 君とデート' WHERE "id" = 2062;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 魔法をかけてよ' WHERE "id" = 2063;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow あいらびゅー らびゅー' WHERE "id" = 2064;
UPDATE "public"."lyrics_dev" SET "lyric" = '上目遣い 困り顔
好きなタイプ「私」にしちゃうぞ' WHERE "id" = 2065;
UPDATE "public"."lyrics_dev" SET "lyric" = '触れていたい左手 ぎゅっと' WHERE "id" = 2071;
UPDATE "public"."lyrics_dev" SET "lyric" = '気付かない？ ひらがなでも2文字ね' WHERE "id" = 2075;
UPDATE "public"."lyrics_dev" SET "lyric" = '離したくないの だから' WHERE "id" = 2077;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow ドキドキ隠して' WHERE "id" = 2079;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 君とデート' WHERE "id" = 2080;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow 魔法をかけてよ' WHERE "id" = 2081;
UPDATE "public"."lyrics_dev" SET "lyric" = 'wow あいらびゅー らびゅー' WHERE "id" = 2082;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこにもない ありふれた日々さ' WHERE "id" = 5712;
UPDATE "public"."lyrics_dev" SET "lyric" = '夢から醒めた夕暮れに
思い出すよ あの笑顔' WHERE "id" = 5714;
UPDATE "public"."lyrics_dev" SET "lyric" = 'つながってくよ 大きなチカラ' WHERE "id" = 5716;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まるで宝箱の中 輝いてる' WHERE "id" = 5718;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと宝箱の中 色褪せない' WHERE "id" = 5729;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キラキラなKISS ふりそそぐ' WHERE "id" = 5734;
UPDATE "public"."lyrics_dev" SET "lyric" = '“逢いたくなる” それだけで愛だよ' WHERE "id" = 5737;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっと宝箱の中 輝いてる
僕ら 出逢えたことが確かな宝石だね' WHERE "id" = 5743;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you 喜びのキャンドルを灯して' WHERE "id" = 4636;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you 心を込めて歌おう' WHERE "id" = 4639;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アドレーション マザー ファザー
So Happy Bounce！(Bounce！)Bounce！(Bounce！)Bounce！
(Bounce！)Birthday！' WHERE "id" = 4651;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you 祝福をメロディーに託して' WHERE "id" = 4657;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Happy birthday to you 祈りを込めて歌おう' WHERE "id" = 4660;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アドレーション マザー ファザー
So Happy Bounce！(Bounce！)Bounce！(Bounce！)Bounce！
(Bounce！)Birthday！' WHERE "id" = 4676;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこまでも いつまでも 育んでく大切な命
私たちの 一つだけの かけがえのない大切な命' WHERE "id" = 4680;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どこまでも いつまでも 育んでく大切な命
私たちの 一つだけの かけがえのない大切な命' WHERE "id" = 4681;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ あたしラメラメ
リアルが1番キャワ♡' WHERE "id" = 6529;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ あたしラメラメ
リアルが1番沼♡' WHERE "id" = 6545;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっとラメラメ 君とラメラメ' WHERE "id" = 6548;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつもラメラメ あたしラメラメ
リアルが1番キャワ♡' WHERE "id" = 6552;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ずっとラメラメ 君とラメラメ
直接確かめて♡' WHERE "id" = 6555;
UPDATE "public"."lyrics_dev" SET "lyric" = 'リンリンリンリン テレフォンタイム' WHERE "id" = 833;
UPDATE "public"."lyrics_dev" SET "lyric" = '聞こえますか？ ワタシの声が' WHERE "id" = 840;
UPDATE "public"."lyrics_dev" SET "lyric" = 'カシャカシャカシャカシャ さぁフォトタイム' WHERE "id" = 849;
UPDATE "public"."lyrics_dev" SET "lyric" = 'カシャカシャカシャカシャ さぁフォトタイム' WHERE "id" = 851;
UPDATE "public"."lyrics_dev" SET "lyric" = '宜しければ ワタシたちみんな' WHERE "id" = 860;
UPDATE "public"."lyrics_dev" SET "lyric" = '朝昼夜 深夜もオーライ
この想いよ飛んでけ！！' WHERE "id" = 872;
UPDATE "public"."lyrics_dev" SET "lyric" = 'リンリンリンリン テレフォンタイム' WHERE "id" = 887;
UPDATE "public"."lyrics_dev" SET "lyric" = 'トゥルトゥルキミの ダイヤルタップ' WHERE "id" = 888;
UPDATE "public"."lyrics_dev" SET "lyric" = 'リンリンリンリン テレフォンタイム' WHERE "id" = 889;
UPDATE "public"."lyrics_dev" SET "lyric" = '響かせたいの もっと、もっと
誰も代われない わたしたちの愛' WHERE "id" = 2890;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キミの街まで どこまでも
咲き誇るよ' WHERE "id" = 2891;
UPDATE "public"."lyrics_dev" SET "lyric" = 'La la li la la la la
La la li la la la, La li la li la
ふわり ひらり かわいい' WHERE "id" = 2892;
UPDATE "public"."lyrics_dev" SET "lyric" = 'トキメキ 運ぶ風' WHERE "id" = 2894;
UPDATE "public"."lyrics_dev" SET "lyric" = '響かせたいの もっと、もっと
誰も歩けない 夢の続きを' WHERE "id" = 2902;
UPDATE "public"."lyrics_dev" SET "lyric" = 'かわいいで満たす このHarmony' WHERE "id" = 2903;
UPDATE "public"."lyrics_dev" SET "lyric" = '枯れないように ずっと、ずっと' WHERE "id" = 2904;
UPDATE "public"."lyrics_dev" SET "lyric" = '伝わっていますか？
答えなら こんどね' WHERE "id" = 2906;
UPDATE "public"."lyrics_dev" SET "lyric" = 'La la li la la la la
La la li la la la, La li la li la
ふわり ひらり かわいい' WHERE "id" = 2908;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぎゅっと 閉じたココロ' WHERE "id" = 2910;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ひゅるりらっ 倒れちゃっても' WHERE "id" = 2914;
UPDATE "public"."lyrics_dev" SET "lyric" = '繋がってる ちゃんと、一歩' WHERE "id" = 2917;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あの日聞こえた 始まりの合図' WHERE "id" = 2918;
UPDATE "public"."lyrics_dev" SET "lyric" = '永遠に続くの この物語' WHERE "id" = 2919;
UPDATE "public"."lyrics_dev" SET "lyric" = '響かせたいよ もっと、もっと
誰も代われない わたしたちの愛' WHERE "id" = 2920;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キミの街まで どこまでも' WHERE "id" = 2921;
UPDATE "public"."lyrics_dev" SET "lyric" = '咲き誇るんだ ずっと、ずっと
奇跡のような未来' WHERE "id" = 2922;
UPDATE "public"."lyrics_dev" SET "lyric" = '結び合えた 花束' WHERE "id" = 2929;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんだか、ナミダじゃん！
でも キミが笑った' WHERE "id" = 2930;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そんな気持ち 胸の中に広がる' WHERE "id" = 950;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけの大切な このひととき' WHERE "id" = 951;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっといつか 叶うと信じてる' WHERE "id" = 964;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そんな気持ち 胸の中に広がる' WHERE "id" = 973;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけの大切な このひととき' WHERE "id" = 974;
UPDATE "public"."lyrics_dev" SET "lyric" = '愛と勇気 希望の花' WHERE "id" = 2597;
UPDATE "public"."lyrics_dev" SET "lyric" = 'タイミングが全て
似たもの同士 照れ笑い' WHERE "id" = 2613;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と見た景色 色彩無限大' WHERE "id" = 2623;
UPDATE "public"."lyrics_dev" SET "lyric" = '待ち侘びた その言葉' WHERE "id" = 2625;
UPDATE "public"."lyrics_dev" SET "lyric" = '愛と勇気 希望の花
信じたら叶う願い届く' WHERE "id" = 2640;
UPDATE "public"."lyrics_dev" SET "lyric" = '揺れる世界 身を任せて
恋に落ちてく' WHERE "id" = 2642;
UPDATE "public"."lyrics_dev" SET "lyric" = '（ぱぱぱぱぱん ぱぱぱぱぱん ぱぱぱぱぱん）' WHERE "id" = 1198;
UPDATE "public"."lyrics_dev" SET "lyric" = '（ぱぱぱぱぱん ぱぱぱぱぱん ぱぱぱぱぱん）' WHERE "id" = 1200;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あつめて あつめて キミと
ダイヤモンドデイズ' WHERE "id" = 1216;
UPDATE "public"."lyrics_dev" SET "lyric" = '散りばめた 笑顔と涙で飾る
きらり 恋のタペストリー' WHERE "id" = 1217;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと キミとなら' WHERE "id" = 1219;
UPDATE "public"."lyrics_dev" SET "lyric" = 'You are my jewelry light
Like a finally shine
照らすよ day and night' WHERE "id" = 1220;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きらり 二人なら' WHERE "id" = 1221;
UPDATE "public"."lyrics_dev" SET "lyric" = 'You are my jewelry light
Like a finally shine
照らすよ day and night' WHERE "id" = 1222;
UPDATE "public"."lyrics_dev" SET "lyric" = '一瞬一瞬が sparkling lights' WHERE "id" = 1226;
UPDATE "public"."lyrics_dev" SET "lyric" = '運命のリングが ほら
煌めいたら そっと かざそう' WHERE "id" = 1227;
UPDATE "public"."lyrics_dev" SET "lyric" = 'その輝き 分け合う Are you ready？' WHERE "id" = 1228;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そうAll I wanna do キミとなら maybe' WHERE "id" = 1229;
UPDATE "public"."lyrics_dev" SET "lyric" = '探して 見つけた光
ダイヤモンドデイズ' WHERE "id" = 1231;
UPDATE "public"."lyrics_dev" SET "lyric" = '通り雨 すれ違いさえも' WHERE "id" = 1232;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ふたり盛り上げるための クレッシェンド' WHERE "id" = 1233;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あつめて あつめて キミと
ダイヤモンドデイズ' WHERE "id" = 1234;
UPDATE "public"."lyrics_dev" SET "lyric" = '散りばめた 笑顔と涙で飾る
きらり 恋のタペストリー' WHERE "id" = 1235;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと キミとなら' WHERE "id" = 1237;
UPDATE "public"."lyrics_dev" SET "lyric" = '小さい頃に 憧れてた
プリンセス ドレス きらきらストーリー' WHERE "id" = 1238;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キミといるとね いつもの景色に
魔法がかかるの' WHERE "id" = 1239;
UPDATE "public"."lyrics_dev" SET "lyric" = '運命の鍵を回して
未来のドア キミと開けよう' WHERE "id" = 1241;
UPDATE "public"."lyrics_dev" SET "lyric" = 'その輝き 分け合う Are you ready？' WHERE "id" = 1242;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そうAll I wanna do キミとなら lady' WHERE "id" = 1243;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いつだって 今日だって 光る
ダイヤモンドデイズ' WHERE "id" = 1245;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キミと見る どんな毎日も' WHERE "id" = 1246;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きっと神様がくれた プレゼント' WHERE "id" = 1247;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あつめて あつめて キミと
ダイヤモンドデイズ' WHERE "id" = 1249;
UPDATE "public"."lyrics_dev" SET "lyric" = '散りばめた 笑顔と涙で綴る
最高ラブストーリー' WHERE "id" = 1250;
UPDATE "public"."lyrics_dev" SET "lyric" = 'You’re my shiny girl
きっと キミとなら' WHERE "id" = 1251;
UPDATE "public"."lyrics_dev" SET "lyric" = 'You are my jewelry light
Like a finally shine
照らすよ day and night' WHERE "id" = 1252;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きらり 二人なら' WHERE "id" = 1253;
UPDATE "public"."lyrics_dev" SET "lyric" = 'You are my jewelry light
Like a finally shine
照らすよ day and night' WHERE "id" = 1254;
UPDATE "public"."lyrics_dev" SET "lyric" = 'キミと 二人なら' WHERE "id" = 1255;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ああ あなたの態度ひとつでもっと' WHERE "id" = 702;
UPDATE "public"."lyrics_dev" SET "lyric" = 'あなたはどうすれば 振り向いてくれますか' WHERE "id" = 706;
UPDATE "public"."lyrics_dev" SET "lyric" = '答えならいつでも 私の中にあるけど' WHERE "id" = 707;
UPDATE "public"."lyrics_dev" SET "lyric" = 'この気持ち晴れるまで ああ' WHERE "id" = 711;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ああ あなた今何してるかなーとか' WHERE "id" = 722;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ああ 素敵な旅でした' WHERE "id" = 734;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ああ 僕らは飛び出した' WHERE "id" = 740;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけじゃダメなんだ なんてねっ' WHERE "id" = 744;
UPDATE "public"."lyrics_dev" SET "lyric" = '私だけじゃない みんながいいの' WHERE "id" = 279;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷり機よ ぷり機 ぷり機さま
世界でいちばん かわいいのは
だぁれ～～～？？？' WHERE "id" = 2130;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2133;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2134;
UPDATE "public"."lyrics_dev" SET "lyric" = '「かわいくなりたい」て 永遠の課題です' WHERE "id" = 2137;
UPDATE "public"."lyrics_dev" SET "lyric" = '今日も研究に よよよ 余念がない♡です' WHERE "id" = 2138;
UPDATE "public"."lyrics_dev" SET "lyric" = '恋とか愛とか ままま だいじだけど' WHERE "id" = 2140;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いまは研究の成果出しますぞ ぷり撮りいこ～' WHERE "id" = 2141;
UPDATE "public"."lyrics_dev" SET "lyric" = '---☆彡突然ですが あなたはまえがみを信じますか？^_^☆彡---' WHERE "id" = 2142;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まえがみ それはいのち' WHERE "id" = 2143;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まえがみ それは勇気' WHERE "id" = 2144;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まえがみ それは青春' WHERE "id" = 2145;
UPDATE "public"."lyrics_dev" SET "lyric" = 'いまこの瞬間 持てるすべての力をあつめて！！！' WHERE "id" = 2146;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2150;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2151;
UPDATE "public"."lyrics_dev" SET "lyric" = 'リップはプルプル まつげはバチバチ' WHERE "id" = 2152;
UPDATE "public"."lyrics_dev" SET "lyric" = '前髪はガチガチ これが基本です！' WHERE "id" = 2153;
UPDATE "public"."lyrics_dev" SET "lyric" = '盛れないぷりにも 想い出は焼き付いてます' WHERE "id" = 2161;
UPDATE "public"."lyrics_dev" SET "lyric" = '顔が伸びちゃってても 半目でバグってむにゃってても' WHERE "id" = 2162;
UPDATE "public"."lyrics_dev" SET "lyric" = '私じゃないけど これも私で愛おしいのです' WHERE "id" = 2164;
UPDATE "public"."lyrics_dev" SET "lyric" = '盛り足りないってときは 迷わずに' WHERE "id" = 2165;
UPDATE "public"."lyrics_dev" SET "lyric" = '盛りとは それは情熱' WHERE "id" = 2168;
UPDATE "public"."lyrics_dev" SET "lyric" = '盛れたら それは希望' WHERE "id" = 2169;
UPDATE "public"."lyrics_dev" SET "lyric" = '盛れて？ それは祈り…' WHERE "id" = 2170;
UPDATE "public"."lyrics_dev" SET "lyric" = '持てるすべての 努力すべての' WHERE "id" = 2172;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2177;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2178;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2179;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2180;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2186;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2187;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅきゅー
きゅきゅぷ・ぷ・ぷり ぷりきゅきゅー' WHERE "id" = 2188;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ぷりきゅ・きゅ・きゅ いぇー ぷりきゅ ぷりきゅ
ぷりで CUTIE♡ぷりんせきゅ！' WHERE "id" = 2189;
UPDATE "public"."lyrics_dev" SET "lyric" = 'まじで CUTIE♡ぷりんせきゅ！！！' WHERE "id" = 2190;
UPDATE "public"."lyrics_dev" SET "lyric" = '負けないじゃなくて 負けっこないじゃん' WHERE "id" = 6656;
UPDATE "public"."lyrics_dev" SET "lyric" = 'がんばるって なんかさー 楽しいじゃん' WHERE "id" = 6657;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ごはん美味しいし アガるQOL' WHERE "id" = 6658;
UPDATE "public"."lyrics_dev" SET "lyric" = '止まんにゃい成長期 びがっぷ！マイメン' WHERE "id" = 6659;
UPDATE "public"."lyrics_dev" SET "lyric" = '競える仲間がいるのって 最高！' WHERE "id" = 6661;
UPDATE "public"."lyrics_dev" SET "lyric" = '超えれる自分がいるのって 最強！' WHERE "id" = 6662;
UPDATE "public"."lyrics_dev" SET "lyric" = '悪魔てきにキャワいいんだ バーロー！' WHERE "id" = 6663;
UPDATE "public"."lyrics_dev" SET "lyric" = '主役ですもの いっとーしょー！' WHERE "id" = 6667;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生 一生 超どセンター' WHERE "id" = 6668;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どったんばったん ぴったんぺったん' WHERE "id" = 6671;
UPDATE "public"."lyrics_dev" SET "lyric" = 'るんるんらんらん わーきゃー' WHERE "id" = 6672;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゅんきゅんどっきん うーきゃー' WHERE "id" = 6676;
UPDATE "public"."lyrics_dev" SET "lyric" = '実際 天才！ わっかるー！' WHERE "id" = 6683;
UPDATE "public"."lyrics_dev" SET "lyric" = 'なんて言ってるそばから カンガルー！？' WHERE "id" = 6684;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やれそうじゃなくて やるっきゃないじゃん' WHERE "id" = 6687;
UPDATE "public"."lyrics_dev" SET "lyric" = '挑戦ってさ なんかさー 嬉しいじゃん' WHERE "id" = 6688;
UPDATE "public"."lyrics_dev" SET "lyric" = 'めちゃんこ元気に 今日もQ.E.D' WHERE "id" = 6689;
UPDATE "public"."lyrics_dev" SET "lyric" = '輝いてこーぜ わっつぁっぷ？マイメン' WHERE "id" = 6690;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どんなときでも いっとーしょー！' WHERE "id" = 6699;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生 一生 超どセンター' WHERE "id" = 6700;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わんわんにゃーにゃー ぴょんぴょん' WHERE "id" = 6704;
UPDATE "public"."lyrics_dev" SET "lyric" = 'りんりんぽんぽん ぷんぷんぐんぐん' WHERE "id" = 6707;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ばんばんずっきん どっひゃー' WHERE "id" = 6708;
UPDATE "public"."lyrics_dev" SET "lyric" = '失敗しても愛嬌で 優勝っ！' WHERE "id" = 6715;
UPDATE "public"."lyrics_dev" SET "lyric" = 'やり方なんてどーだって 優勝っ！' WHERE "id" = 6717;
UPDATE "public"."lyrics_dev" SET "lyric" = '叶えたい夢があるから 優勝っ！' WHERE "id" = 6719;
UPDATE "public"."lyrics_dev" SET "lyric" = '結局のとこ うちらが優勝っ！' WHERE "id" = 6721;
UPDATE "public"."lyrics_dev" SET "lyric" = '笑い合って一緒になって 前進
なんて素敵な 大前提' WHERE "id" = 6722;
UPDATE "public"."lyrics_dev" SET "lyric" = '励まし合ったり ねっ
めちゃくちゃにどこまでもいこーっ！' WHERE "id" = 6723;
UPDATE "public"."lyrics_dev" SET "lyric" = '今も これからも 優勝です！' WHERE "id" = 6724;
UPDATE "public"."lyrics_dev" SET "lyric" = 'みんなと みんなで 優勝でーーす！' WHERE "id" = 6725;
UPDATE "public"."lyrics_dev" SET "lyric" = '主役ですもの いっとーしょー！' WHERE "id" = 6729;
UPDATE "public"."lyrics_dev" SET "lyric" = '人生 一生 超どセンター' WHERE "id" = 6730;
UPDATE "public"."lyrics_dev" SET "lyric" = 'どったんばったん ぴったんぺったん' WHERE "id" = 6733;
UPDATE "public"."lyrics_dev" SET "lyric" = 'るんるんらんらん わーきゃー' WHERE "id" = 6734;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゅんきゅんどっきん うーきゃー' WHERE "id" = 6738;
UPDATE "public"."lyrics_dev" SET "lyric" = 'はぁ、こんがらがって
混沌 混濁の世界じゃ' WHERE "id" = 7154;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう、やってられないし
見えない 聞こえない' WHERE "id" = 7155;
UPDATE "public"."lyrics_dev" SET "lyric" = '気持ちでは負けないし 切り取るの' WHERE "id" = 7157;
UPDATE "public"."lyrics_dev" SET "lyric" = 'こう見えたって 心の中
ガラス製なの' WHERE "id" = 7158;
UPDATE "public"."lyrics_dev" SET "lyric" = '見えない？ 見えない？' WHERE "id" = 7159;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ワレモノ注意 切り込み中尉' WHERE "id" = 7160;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アイヘイチュー ヘイチュー' WHERE "id" = 7162;
UPDATE "public"."lyrics_dev" SET "lyric" = '凄惨な街の現状 計算外 むしろ平常？
ノイズだらけこの世界' WHERE "id" = 7163;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱 狂騒 センセーション' WHERE "id" = 7164;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたし なんでもかんでもお見通しなの
そう有能' WHERE "id" = 7165;
UPDATE "public"."lyrics_dev" SET "lyric" = 'カッティン カッティン 切り裂いて' WHERE "id" = 7166;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もう、やってられないし
癒えない 癒えない' WHERE "id" = 7169;
UPDATE "public"."lyrics_dev" SET "lyric" = 'そうは言っても 本当のとこ
誰も彼も' WHERE "id" = 7172;
UPDATE "public"."lyrics_dev" SET "lyric" = '知らない 知らない' WHERE "id" = 7173;
UPDATE "public"."lyrics_dev" SET "lyric" = 'ハレモノだって バケモノだって' WHERE "id" = 7174;
UPDATE "public"."lyrics_dev" SET "lyric" = 'アイヘイチュー ヘイチュー' WHERE "id" = 7176;
UPDATE "public"."lyrics_dev" SET "lyric" = '一寸先闇の世界 アイ アイ' WHERE "id" = 7178;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もしもにっちもさっちも行かない時はね
ありゃま、絶唱 残響 センセーション' WHERE "id" = 7179;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたし なんでもかんでもお見通しなの
So, you know？' WHERE "id" = 7180;
UPDATE "public"."lyrics_dev" SET "lyric" = '凄惨な街の現状 計算外 むしろ平常？
ノイズだらけこの世界' WHERE "id" = 7183;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱 狂騒 センセーション' WHERE "id" = 7184;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたし なんでもかんでもお見通しなの
そう有能' WHERE "id" = 7185;
UPDATE "public"."lyrics_dev" SET "lyric" = 'カッティン カッティン
アソびましょ' WHERE "id" = 7186;
UPDATE "public"."lyrics_dev" SET "lyric" = 'もしもあっちもこっちも巻き起こせるなら
まるで絶唱 狂騒 センセーション' WHERE "id" = 7187;
UPDATE "public"."lyrics_dev" SET "lyric" = 'わたし なんでもかんでもお見通しなの
そう言うの' WHERE "id" = 7188;
UPDATE "public"."lyrics_dev" SET "lyric" = 'カッティン カッティン 切り裂いて' WHERE "id" = 7189;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6559;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6560;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6561;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と今を生きてる！感謝！＆スペシャル プレシャス' WHERE "id" = 6562;
UPDATE "public"."lyrics_dev" SET "lyric" = '全力疾走で駆け抜けてった あの人は今どこにいるかな' WHERE "id" = 6563;
UPDATE "public"."lyrics_dev" SET "lyric" = '追い風だって向かい風だって 自由に乗りこなしてみたいな' WHERE "id" = 6564;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゃんちゅー in my head どんな時も大切な人を想えば' WHERE "id" = 6580;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さんきゅー いっぱいで 言葉になんない気持ちが溢れそうだよ' WHERE "id" = 6581;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6582;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6584;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6586;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と 過去や' WHERE "id" = 6588;
UPDATE "public"."lyrics_dev" SET "lyric" = '今を生きてる！感謝！＆スペシャル プレシャス' WHERE "id" = 6590;
UPDATE "public"."lyrics_dev" SET "lyric" = '失敗 後悔 意味付け次第でポジティブな経験' WHERE "id" = 6611;
UPDATE "public"."lyrics_dev" SET "lyric" = 'スペシャル 感謝' WHERE "id" = 6618;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6619;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6620;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6621;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6622;
UPDATE "public"."lyrics_dev" SET "lyric" = 'きゃんちゅー in my head どんな時も大切な人を想えば' WHERE "id" = 6623;
UPDATE "public"."lyrics_dev" SET "lyric" = 'さんきゅー いっぱいで 言葉になんない気持ちが' WHERE "id" = 6624;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6626;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6628;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！感謝！＆スペシャル プレシャス' WHERE "id" = 6630;
UPDATE "public"."lyrics_dev" SET "lyric" = '君と 過去や' WHERE "id" = 6632;
UPDATE "public"."lyrics_dev" SET "lyric" = '感謝！＆スペシャル プレシャス' WHERE "id" = 6634;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere, 心の中に わたしたちがいるでしょ？' WHERE "id" = 6635;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere, 思い出してね Over and Over' WHERE "id" = 6636;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere, 心の中に わたしたちがいるでしょ？' WHERE "id" = 6637;
UPDATE "public"."lyrics_dev" SET "lyric" = 'Every time, Everywhere, 思い出してね Over and Over' WHERE "id" = 6638;
