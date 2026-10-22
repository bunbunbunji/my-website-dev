-- DASH!!!(sounds_id=526)のlyrics_dev行(id=7001-7037)への誤反映を復元
-- 原因: センセーション(sounds_id=508)の歌詞成型SQL生成時、本番lyrics.idを
-- そのままlyrics_dev.idとして使ってしまい、センセーションの+153オフセットを
-- 適用しなかったため、本番id範囲(7001-7037)がdevでは別の曲(DASH!!!)の
-- 行だったことに気づかず上書きしてしまった。
-- 本番lyrics(オフセット-72適用前のDASH!!!本来のid)から正しい本文を復元し、
-- lyric_col/col_spaceも元の状態(NULL)に戻す。

UPDATE lyrics_dev SET lyric = '今日がもう最高潮！', lyric_col = NULL, col_space = NULL WHERE id = 7001;
UPDATE lyrics_dev SET lyric = '理由なんてないのさ 君がいるだけでいい！', lyric_col = NULL, col_space = NULL WHERE id = 7002;
UPDATE lyrics_dev SET lyric = 'ノートの最後に書き残してた', lyric_col = NULL, col_space = NULL WHERE id = 7003;
UPDATE lyrics_dev SET lyric = 'あの日', lyric_col = NULL, col_space = NULL WHERE id = 7004;
UPDATE lyrics_dev SET lyric = '描いた', lyric_col = NULL, col_space = NULL WHERE id = 7005;
UPDATE lyrics_dev SET lyric = 'ワタシになれてるかな？', lyric_col = NULL, col_space = NULL WHERE id = 7006;
UPDATE lyrics_dev SET lyric = 'ダダダダダッシュで NaNaNaNa～', lyric_col = NULL, col_space = NULL WHERE id = 7007;
UPDATE lyrics_dev SET lyric = '＼はい／', lyric_col = NULL, col_space = NULL WHERE id = 7008;
UPDATE lyrics_dev SET lyric = '未来まで', lyric_col = NULL, col_space = NULL WHERE id = 7009;
UPDATE lyrics_dev SET lyric = 'Hop! Step! Jump! Bang!', lyric_col = NULL, col_space = NULL WHERE id = 7010;
UPDATE lyrics_dev SET lyric = 'いけるよ絶対 NaNaNaNa～', lyric_col = NULL, col_space = NULL WHERE id = 7011;
UPDATE lyrics_dev SET lyric = '＼はい／', lyric_col = NULL, col_space = NULL WHERE id = 7012;
UPDATE lyrics_dev SET lyric = '駆け抜けるのだ', lyric_col = NULL, col_space = NULL WHERE id = 7013;
UPDATE lyrics_dev SET lyric = 'Hop! Step! Jump! Bang!', lyric_col = NULL, col_space = NULL WHERE id = 7014;
UPDATE lyrics_dev SET lyric = 'ルートはまだまだわからない？', lyric_col = NULL, col_space = NULL WHERE id = 7015;
UPDATE lyrics_dev SET lyric = 'じゃあ自分でかいちゃえ 未来へ', lyric_col = NULL, col_space = NULL WHERE id = 7016;
UPDATE lyrics_dev SET lyric = '＼はい／', lyric_col = NULL, col_space = NULL WHERE id = 7017;
UPDATE lyrics_dev SET lyric = 'ゴールもまだまだわからない？', lyric_col = NULL, col_space = NULL WHERE id = 7018;
UPDATE lyrics_dev SET lyric = 'じゃあ自分で決めて It''s My Way!', lyric_col = NULL, col_space = NULL WHERE id = 7019;
UPDATE lyrics_dev SET lyric = '＼はい／', lyric_col = NULL, col_space = NULL WHERE id = 7020;
UPDATE lyrics_dev SET lyric = '全速前進すいすて ＼全速前進すいすて／', lyric_col = NULL, col_space = NULL WHERE id = 7021;
UPDATE lyrics_dev SET lyric = 'HEY! ＼HEY! ／ HEY! ＼HEY!／
HEY! ＼HEY! ／ HEY! ＼HEY!／', lyric_col = NULL, col_space = NULL WHERE id = 7022;
UPDATE lyrics_dev SET lyric = 'ついてきて！', lyric_col = NULL, col_space = NULL WHERE id = 7023;
UPDATE lyrics_dev SET lyric = '帰り道イヤホンの中で', lyric_col = NULL, col_space = NULL WHERE id = 7024;
UPDATE lyrics_dev SET lyric = '何度も', lyric_col = NULL, col_space = NULL WHERE id = 7025;
UPDATE lyrics_dev SET lyric = '何度も', lyric_col = NULL, col_space = NULL WHERE id = 7026;
UPDATE lyrics_dev SET lyric = 'なぞった夢', lyric_col = NULL, col_space = NULL WHERE id = 7027;
UPDATE lyrics_dev SET lyric = '尊い指数あがってる？', lyric_col = NULL, col_space = NULL WHERE id = 7028;
UPDATE lyrics_dev SET lyric = '最高を更新してる？', lyric_col = NULL, col_space = NULL WHERE id = 7029;
UPDATE lyrics_dev SET lyric = '理想越えていかなきゃね！
やる気振り切り気味', lyric_col = NULL, col_space = NULL WHERE id = 7030;
UPDATE lyrics_dev SET lyric = '盛り上がる許可は出てるみたいです！', lyric_col = NULL, col_space = NULL WHERE id = 7031;
UPDATE lyrics_dev SET lyric = 'ズバっと', lyric_col = NULL, col_space = NULL WHERE id = 7032;
UPDATE lyrics_dev SET lyric = '行こうぜ', lyric_col = NULL, col_space = NULL WHERE id = 7033;
UPDATE lyrics_dev SET lyric = 'ピリオドの先へ', lyric_col = NULL, col_space = NULL WHERE id = 7034;
UPDATE lyrics_dev SET lyric = 'ススススキップで NaNaNaNa～', lyric_col = NULL, col_space = NULL WHERE id = 7035;
UPDATE lyrics_dev SET lyric = '＼はい／', lyric_col = NULL, col_space = NULL WHERE id = 7036;
UPDATE lyrics_dev SET lyric = '愛と勇気', lyric_col = NULL, col_space = NULL WHERE id = 7037;
