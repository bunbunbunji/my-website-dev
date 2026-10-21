-- !!! 実行禁止 !!! コードデプロイ（App.jsx本番反映）と同じタイミングでのみ実行すること
-- 理由1: 本番の現行コードはoccurrence[i]をlyrics.split(改行)の行番号に対応させて
-- 「○回目」バッジを表示するため、この67件（改行数が本番/devで異なる）を先に反映すると
-- 表示が崩れる。新コード(occurrenceバッジ機能を削除済み)のデプロイと同時に実行する。
-- 理由2: id=260はskyfeelanの"##"挿入構文(col_space='insert')で、新コードのみが解釈できる
-- マーカーのため、旧コードのままでは生の"##"がユーザーに見えてしまう。
--
-- 歌詞本文差異レビュー_デプロイ時反映.xlsx の採用列（67件）＋id=260（1件）を本番lyrics.lyricに反映する
-- 対象: 68件

UPDATE lyrics SET lyric = 'でもきょうはきょうの協調性も
求められるような恋とか、なんとか欲しがられたりだけど' WHERE id = 3233;
UPDATE lyrics SET lyric = 'むずがゆいような言葉だって今、言っていこ？' WHERE id = 3242;
UPDATE lyrics SET lyric = 'え、いつからだっていいじゃん、いつまでとかないじゃん' WHERE id = 3252;
UPDATE lyrics SET lyric = 'ほんとはまったく気にしてもいないけれど' WHERE id = 3256;
UPDATE lyrics SET lyric = '忘れないような言葉も何度も、言っていこ？' WHERE id = 3264;
UPDATE lyrics SET lyric = 'むずがゆいような言葉だって今、言っていこ？' WHERE id = 3272;
UPDATE lyrics SET lyric = 'もうチュードク (Hey↓) 不満幾千億 (Hey↓)' WHERE id = 3817;
UPDATE lyrics SET lyric = '超モードク(Hey↓) ぶっちゃけのモード(ふぉ～　ふぉ～う)' WHERE id = 3819;
UPDATE lyrics SET lyric = 'もうチュードク(Hey↓) やばい重症ロック (Hey↓)' WHERE id = 3821;
UPDATE lyrics SET lyric = 'はいチューモク(はーい↑) きっかけは今日も(ふぉ～　ふぉ～う)' WHERE id = 3823;
UPDATE lyrics SET lyric = 'もうチュードク(Hey↓) 不満幾千億(Hey↓)' WHERE id = 3855;
UPDATE lyrics SET lyric = '超モードク(Hey↓) ぶっちゃけのモード(ふぉ～　ふぉ～う)' WHERE id = 3857;
UPDATE lyrics SET lyric = 'もうチュードク(Hey↓) やばい重症ロック(Hey↓)' WHERE id = 3859;
UPDATE lyrics SET lyric = 'はいチューモク(はーい↑) きっかけは今日も(ふぉ～　ふぉ～う)' WHERE id = 3861;
UPDATE lyrics SET lyric = '友達同士、知らないおしゃれをしてみたり
この手を離す日も来る
それまでは' WHERE id = 3879;
UPDATE lyrics SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby' WHERE id = 3883;
UPDATE lyrics SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby' WHERE id = 3885;
UPDATE lyrics SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby' WHERE id = 3907;
UPDATE lyrics SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby' WHERE id = 3909;
UPDATE lyrics SET lyric = 'せーの
YEAH！' WHERE id = 3914;
UPDATE lyrics SET lyric = '史上最高の君のかわいさを伝えたいよ、baby baby' WHERE id = 3922;
UPDATE lyrics SET lyric = '前途洋々の君のかわいさを伝えたいよ、baby baby' WHERE id = 3924;
UPDATE lyrics SET lyric = 'GO GO GO LET''S GO
ARE YOU READY？ GALAXY' WHERE id = 156;  -- sounds_id=10
UPDATE lyrics SET lyric = 'ああ　超次元　まじまじ' WHERE id = 193;  -- sounds_id=10
UPDATE lyrics SET lyric = '瞳の真ん中　ブラックホールみたいだね' WHERE id = 210;  -- sounds_id=10
UPDATE lyrics SET lyric = 'GO GO GO LET''S GO  ARE YOU READY？' WHERE id = 222;  -- sounds_id=10
UPDATE lyrics SET lyric = 'さぁボクとキミの白地図を彩る青い生き様' WHERE id = 3300;
UPDATE lyrics SET lyric = 'さぁその眼その手 ボク達はゆめゆめ忘るるなかれ' WHERE id = 3315;
UPDATE lyrics SET lyric = 'さぁボクとキミの白地図を彩る青い生き様' WHERE id = 3326;
UPDATE lyrics SET lyric = '同じほう見つめどこまでも' WHERE id = 3330;
UPDATE lyrics SET lyric = 'みんなでステージで1番かわいく輝けるように' WHERE id = 235;
UPDATE lyrics SET lyric = '長いようで早かったここまでを詰め込んで' WHERE id = 239;
UPDATE lyrics SET lyric = '駆け抜けろskyfeelan さらに加速して' WHERE id = 241;
UPDATE lyrics SET lyric = '飛んでいけskyfeelan ここのみんな巻き込んで' WHERE id = 244;
UPDATE lyrics SET lyric = 'もっと可愛く見えるようにたくさん研究します♡' WHERE id = 246;
UPDATE lyrics SET lyric = '緊張で泣きそうだけど特別になる予感がする' WHERE id = 247;
UPDATE lyrics SET lyric = '可愛くね なるように工夫して歌ったり' WHERE id = 253;
UPDATE lyrics SET lyric = '緊急事態でも歌っちゃう！？完璧主義で♡' WHERE id = 254;
UPDATE lyrics SET lyric = 'どこまでもskyfeelan 高く飛べそうだ' WHERE id = 255;
UPDATE lyrics SET lyric = '戻って止まってた分をもっと進まなきゃね！' WHERE id = 256;
UPDATE lyrics SET lyric = 'ついてきてskyfeelan 夢の花が咲くまで' WHERE id = 257;
UPDATE lyrics SET lyric = '飛んでいけskyfeelan ここのみんな巻き込んで' WHERE id = 266;
UPDATE lyrics SET lyric = '成長してる私たちをもっと感じて欲しいの' WHERE id = 268;
UPDATE lyrics SET lyric = 'ありがとうを伝えなければ！本当に皆様ありがとう！' WHERE id = 269;
UPDATE lyrics SET lyric = 'きっと 今どこかで 最悪な事があって' WHERE id = 3527;
UPDATE lyrics SET lyric = 'きっと 世の中の せいにしても変わんない' WHERE id = 3530;
UPDATE lyrics SET lyric = '何もかも上手く行けそうな 気がする程じゃない' WHERE id = 3533;
UPDATE lyrics SET lyric = 'きっと 世の中の せいにしても変わんない' WHERE id = 3546;
UPDATE lyrics SET lyric = '何もかも 上手く行けそうな 気がする程じゃない' WHERE id = 3550;
UPDATE lyrics SET lyric = 'Let''s go さぁ出掛けよう大海原へ' WHERE id = 1562;
UPDATE lyrics SET lyric = '型にはハマらない集まった新時代のスター' WHERE id = 1563;
UPDATE lyrics SET lyric = '迫るEmbark 爆ぜろReal Anchorを解き放て' WHERE id = 1568;
UPDATE lyrics SET lyric = '誰が何を言っても媚びない逃げない揺るがない' WHERE id = 1570;
UPDATE lyrics SET lyric = '立ち上がれWe are Frontier 地図は自分で描け' WHERE id = 1572;
UPDATE lyrics SET lyric = '搭乗手続きはした？ 新天地へご招待' WHERE id = 1578;
UPDATE lyrics SET lyric = '巻き込んでいく君も船出の目撃者さ' WHERE id = 1579;
UPDATE lyrics SET lyric = 'しぶき上げ荒れ狂うWaves　手懐けてみせる' WHERE id = 1584;
UPDATE lyrics SET lyric = 'もしも先が暗くても私が光になる' WHERE id = 1586;
UPDATE lyrics SET lyric = 'ありのままWe are Frontier 限界なんて決めるな' WHERE id = 1588;
UPDATE lyrics SET lyric = 'この瞬間切り取って1ページ書き込もう' WHERE id = 1604;
UPDATE lyrics SET lyric = '闇の先にあるのはきっと希望の地平' WHERE id = 1606;
UPDATE lyrics SET lyric = '「フルーツ ジーッ... （今私はあなたのの心をガン見しています） パァ！」' WHERE id = 3594;
UPDATE lyrics SET lyric = '朝起きてまず確認 きょうもいい感じだね' WHERE id = 1078;
UPDATE lyrics SET lyric = '一年365日 わたしのこと一番みてるひと' WHERE id = 1079;
UPDATE lyrics SET lyric = '好きですと、言えるのは 当たり前とかじゃない' WHERE id = 1080;
UPDATE lyrics SET lyric = '朝起きて、そうだ休み やりたいことありすぎ' WHERE id = 1102;
UPDATE lyrics SET lyric = '帰ったらまた確認 当たり前とかじゃない' WHERE id = 1104;
UPDATE lyrics SET lyric = '私##運命のドアを開いたの' WHERE id = 260;  -- ##挿入構文(skyfeelan)、col_space='insert'
