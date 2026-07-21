-- ============================================================
-- lyrics_dev 更新: sounds_id=1（id:1892〜1924）の歌詞本文を
-- truelyric.txt（完成形）に一致させる。
--
-- 対象: lyrics_dev のみ。lyrics（本番）は一切変更しない。
-- レコード数は増減しない（既存33行はそのまま、17行のUPDATEのみ）。
--
-- 変更内容のまとめ:
--   ・1行内の空白を改行に置き換え、完成形と同じ行分割にする
--   ・半角/全角スペースの統一、Its→It's、？→?などの表記統一
--   ・行を分割した箇所は occurrence 配列も行数に合わせて複製
--     （見た目には影響しないが、データ整合性のため）
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

-- 1番 イントロ: Its → It's
UPDATE lyrics_dev SET lyric = 'It''s time to live my life 雨音' WHERE id = 1892;
UPDATE lyrics_dev SET lyric = 'It''s time to live my life ため息' WHERE id = 1893;

-- 1番 Aメロ: 全角スペース→半角スペース
UPDATE lyrics_dev SET lyric = '水たまりの街 反射するメモリー' WHERE id = 1896;

-- 1番 Aメロ: 語の区切り位置を修正 + 全角→半角スペース
UPDATE lyrics_dev SET lyric = '解釈違いの ロマンス手を振って' WHERE id = 1900;

-- 1番 サビ: 「乗り込んだら」「もうどこへだって行けそう」を別行に分割
UPDATE lyrics_dev SET
  lyric = '湾岸ルーレット ハイウェイ
乗り込んだら
もうどこへだって行けそう',
  occurrence = '{1,1,1}'
WHERE id = 1902;

-- 1番 サビ: スペース追加
UPDATE lyrics_dev SET lyric = '夜が明ける頃は 違う私で' WHERE id = 1903;

-- 1番 サビ: 「そうよ悲しまないで」「顔を上げて」を別行に分割 + ？→?
UPDATE lyrics_dev SET
  lyric = 'そうよ悲しまないで
顔を上げて
そんなに惨めじゃないでしょ?',
  occurrence = '{1,1,1}'
WHERE id = 1904;

-- 1番 サビ: 「すこし」「すこしずつ変われるチャンス」を別行に分割
UPDATE lyrics_dev SET
  lyric = 'すこし
すこしずつ変われるチャンス',
  occurrence = '{1,1}'
WHERE id = 1905;

-- 2番 間奏: Its → It's（完成形通りピリオド付き）
UPDATE lyrics_dev SET lyric = 'It''s time to live my life. 雨音' WHERE id = 1906;
UPDATE lyrics_dev SET lyric = 'It''s time to live my life ため息' WHERE id = 1907;

-- 2番 Aメロ: 「今更 泣きついたって」「無駄よ 許してあげない」を別行に分割
UPDATE lyrics_dev SET lyric = '今更 泣きついたって
無駄よ 許してあげない' WHERE id = 1910;

-- 2番 サビ: 1番と同様の分割
UPDATE lyrics_dev SET
  lyric = '湾岸ルーレット ハイウェイ
乗り込んだら
もうどこへだって行けそう',
  occurrence = '{2,2,2}'
WHERE id = 1912;

UPDATE lyrics_dev SET lyric = '夜が明ける頃は 違う私で' WHERE id = 1913;

UPDATE lyrics_dev SET
  lyric = 'そうよ悲しまないで
顔を上げて
そんなに惨めじゃないでしょ?',
  occurrence = '{2,2,2}'
WHERE id = 1914;

UPDATE lyrics_dev SET
  lyric = 'すこし
すこしずつ変われるチャンス',
  occurrence = '{2,2}'
WHERE id = 1915;

-- 3番 サビ: 「そうよ」「悲しまないで感じるでしょ 予感」を別行に分割
UPDATE lyrics_dev SET lyric = 'そうよ
悲しまないで感じるでしょ 予感' WHERE id = 1918;

-- 3番 サビ: 「すこし」「すこしずつ変われるチャンス」を別行に分割
UPDATE lyrics_dev SET
  lyric = 'すこし
すこしずつ変われるチャンス',
  occurrence = '{3,3}'
WHERE id = 1924;


-- ============================================================
-- 確認用: 更新後の該当行を一覧表示
-- ============================================================
SELECT id, seq, lyric, occurrence, lyric_col, col_space
FROM lyrics_dev
WHERE id IN (1892,1893,1896,1900,1902,1903,1904,1905,1906,1907,1910,1912,1913,1914,1915,1918,1924)
ORDER BY seq;
