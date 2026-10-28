import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { execSync } from 'child_process'

// 画面表示用のバージョン値：コミットハッシュ単位で固定し、コミットが変わったときだけ更新される
// ようにする（ビルド時刻だと、同じコードでもビルドするたびに値が変わってしまい、
// ローカルとデプロイ先の内容が一致しているかの判断材料にならないため）。
function getAppVersion() {
  try {
    const hash = execSync('git rev-parse --short HEAD').toString().trim()
    const dirty = execSync('git status --porcelain').toString().trim().length > 0
    return `${hash}${dirty ? '-dirty' : ''}`
  } catch {
    return 'unknown'
  }
}

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: '/my-website-dev/',
  define: {
    __APP_VERSION__: JSON.stringify(getAppVersion()),
  },
})