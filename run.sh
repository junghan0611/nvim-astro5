#!/usr/bin/env bash
# nvim-astro5 — 설정 복사 + 실행
#
# 사용법:
#   ./run.sh --install    # 설치 (복사 + 플러그인 + ~/bin/nv 생성)
#   ./run.sh              # 실행
#   ./run.sh --minimal    # 미니멀 모드
#   ./run.sh file.md      # 파일 열기

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET="$HOME/.config/nvim-astro5"
APPNAME="nvim-astro5"

# --- 설정 복사 ---
if [ "$SCRIPT_DIR" != "$TARGET" ]; then
  rm -rf "$TARGET"
  mkdir -p "$TARGET"
  cp -r "$SCRIPT_DIR"/init.lua "$TARGET/"
  cp -r "$SCRIPT_DIR"/lua "$TARGET/"
  cp -r "$SCRIPT_DIR"/snippets "$TARGET/"
  cp "$SCRIPT_DIR"/run.sh "$TARGET/"
  chmod +x "$TARGET/run.sh"
  echo "📂 $TARGET 복사 완료"
fi

# --- 의존성 확인 ---
ok=true
for cmd in nvim git rg; do
  command -v $cmd >/dev/null 2>&1 || { echo "⚠️  $cmd 없음"; ok=false; }
done
if ! command -v cc >/dev/null 2>&1 && ! command -v gcc >/dev/null 2>&1; then
  echo "⚠️  C 컴파일러 없음 (Treesitter 파서 빌드용)"
fi

export NVIM_APPNAME="$APPNAME"

# --- --install ---
if [ "$1" = "--install" ]; then
  echo "📦 플러그인 설치..."
  nvim --headless "+Lazy! sync" +qa 2>&1 || true

  # ~/bin/nv 래퍼 생성
  mkdir -p "$HOME/bin"
  cat > "$HOME/bin/nv" << 'WRAPPER'
#!/usr/bin/env bash
exec env NVIM_APPNAME=nvim-astro5 nvim "$@"
WRAPPER
  chmod +x "$HOME/bin/nv"

  echo ""
  echo "✅ 설치 완료!"
  echo ""
  echo "   nv            ← nvim-astro5로 실행"
  echo "   nv file.md    ← 파일 열기"
  echo ""
  echo "   PATH에 ~/bin 이 없으면:"
  echo "   export PATH=\"\$HOME/bin:\$PATH\""
  exit 0
fi

# --- --minimal ---
if [ "$1" = "--minimal" ]; then
  shift
  export NVIM_MINIMAL=true
fi

exec nvim "$@"
