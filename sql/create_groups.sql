-- ============================================================
-- groups テーブルを新設
--
-- 目的: これまでグループは sounds / members / lyrics_dev に
-- group_name という文字列列として分散しているだけで、グループ自体を
-- 表すマスタテーブルが存在しなかった。
-- 「工事中（イレギュラー対応中）」のようなグループ単位のフラグを
-- コード変更・デプロイなしに切り替えられるようにするため新設する。
--
-- under_construction = true のグループは、アプリ側で以下のように扱う:
--   - 楽曲リストで全曲「準備中」表示にし、歌詞を確認できないようにする
--   - 全モードのグループ選択でボタンを押せなくする（表示はそのまま残す）
--   - グループボタンをグレー表示にし、「工事中」の表記を追加する
--
-- 実行方法: Supabase ダッシュボード → SQL Editor に貼り付けて実行。
-- ============================================================

CREATE TABLE IF NOT EXISTS groups (
  name text PRIMARY KEY,
  under_construction boolean NOT NULL DEFAULT false
);

ALTER TABLE groups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON groups FOR SELECT USING (true);

INSERT INTO groups (name) VALUES
  ('FRUITS ZIPPER'),
  ('CANDY TUNE'),
  ('SWEET STEADY'),
  ('CUTIE STREET'),
  ('MORE STAR')
ON CONFLICT (name) DO NOTHING;

-- MORE STAR をイレギュラー対応中として「工事中」にする
UPDATE groups SET under_construction = true WHERE name = 'MORE STAR';
