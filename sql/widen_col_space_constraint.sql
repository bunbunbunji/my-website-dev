-- 本番lyrics.col_spaceのCHECK制約に'break'を追加する
-- 背景: dev側(lyrics_dev)は'half'/'full'に加えて'break'という値を既に使用しているが、
-- 本番の制約は CHECK (col_space IN ('half', 'full')) のままで'break'を許可していない。
-- この変更はスキーマの許可値を広げるだけで、既存データには一切影響しない(安全・後方互換)。
ALTER TABLE lyrics
  DROP CONSTRAINT IF EXISTS lyrics_col_space_check,
  ADD CONSTRAINT lyrics_col_space_check CHECK (col_space IN ('half', 'full', 'break'));
