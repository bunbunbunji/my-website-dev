-- 本番lyrics.col_spaceのCHECK制約に'insert'を追加する
-- 背景: 行数不一致5曲の同期対象(sql/sync_5songs.sql)にskyfeelanの合いの手挿入構文
-- (col_space='insert', ##マーカーで後続レコードに置き換わる表示仕様)が1件含まれているが、
-- 本番の制約は CHECK (col_space IN ('half', 'full', 'break')) のままで'insert'を許可していない。
-- dev側(lyrics_dev)で現在使われている値は half/full/break/insert の4種類のみ(2026-10-16確認)。
-- この変更はスキーマの許可値を広げるだけで、既存データには一切影響しない(安全・後方互換)。
ALTER TABLE lyrics
  DROP CONSTRAINT IF EXISTS lyrics_col_space_check,
  ADD CONSTRAINT lyrics_col_space_check CHECK (col_space IN ('half', 'full', 'break', 'insert'));
