-- dev: exclude_from_quiz関連マイグレーション(add_exclude_from_quiz.sql / fix_exclude_from_quiz_view.sql)が
-- 実行済みかどうかを確認する。SupabaseのSQL Editorで実行してください。

-- 1. lyrics_devにexclude_from_quiz列が存在するか（存在すればadd_exclude_from_quiz.sql実行済み）
SELECT column_name, data_type, column_default, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'lyrics_dev' AND column_name = 'exclude_from_quiz';
-- → 1行返ってくればOK（boolean, default false）。0行なら未実行。

-- 2. quiz_full_devがexclude_from_quiz列を公開しているか（存在すればfix_exclude_from_quiz_view.sql実行済み）
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'quiz_full_dev' AND column_name = 'exclude_from_quiz';
-- → 1行返ってくればOK。0行なら、add_exclude_from_quiz.sqlのみ実行されfix_exclude_from_quiz_view.sqlが未実行の状態。

-- 3. 現在exclude_from_quiz=trueになっているレコード件数（参考。0件でも異常ではない）
SELECT count(*) AS excluded_count FROM lyrics_dev WHERE exclude_from_quiz = true;
