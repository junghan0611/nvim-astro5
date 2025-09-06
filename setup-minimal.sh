#!/bin/bash
# NeoVim Minimal Mode 설치 스크립트
# Termux와 Linux 모두 지원

set -e

echo "🚀 NeoVim Minimal Mode Setup"
echo "============================"
echo ""

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 환경 감지
if [ -n "$TERMUX_VERSION" ]; then
    PLATFORM="Termux"
    SHELL_RC="$HOME/.bashrc"
else
    PLATFORM="Linux"
    # Shell 감지
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
    fi
fi

echo -e "${YELLOW}Platform:${NC} $PLATFORM"
echo -e "${YELLOW}Shell RC:${NC} $SHELL_RC"
echo ""

# 1. NeoVim 설정 파일 확인
echo -e "${YELLOW}1. Checking NeoVim config...${NC}"
NVIM_CONFIG="$HOME/.config/nvim"

if [ ! -d "$NVIM_CONFIG" ]; then
    echo "  ⚠️  NeoVim config not found at $NVIM_CONFIG"
    echo "  Please install AstroNvim first"
    exit 1
fi

# 2. minimal-mode.lua 파일 확인
MINIMAL_FILE="$NVIM_CONFIG/lua/plugins/minimal-mode.lua"
if [ ! -f "$MINIMAL_FILE" ]; then
    echo "  ⚠️  minimal-mode.lua not found"
    echo "  Creating from template..."
    
    # 간단한 템플릿 생성 (실제 파일이 없을 경우)
    mkdir -p "$NVIM_CONFIG/lua/plugins"
    cat > "$MINIMAL_FILE" << 'EOF'
-- Minimal Mode Configuration
local is_minimal = vim.env.NVIM_MINIMAL == "true"
if not is_minimal then return {} end

vim.notify("🚀 NeoVim Minimal Mode Active", vim.log.levels.INFO)

return {
  -- LSP 비활성화
  { "williamboman/mason.nvim", enabled = false },
  { "neovim/nvim-lspconfig", enabled = false },
  -- DAP 비활성화
  { "mfussenegger/nvim-dap", enabled = false },
  -- 개발 도구 비활성화
  { "nvimtools/none-ls.nvim", enabled = false },
  { "stevearc/conform.nvim", enabled = false },
}
EOF
    echo -e "  ${GREEN}✓ Created minimal-mode.lua${NC}"
else
    echo -e "  ${GREEN}✓ minimal-mode.lua exists${NC}"
fi

# 3. Shell RC 파일 업데이트
echo ""
echo -e "${YELLOW}2. Updating shell configuration...${NC}"

# 백업 생성
cp "$SHELL_RC" "$SHELL_RC.bak"
echo -e "  ${GREEN}✓ Backup created: $SHELL_RC.bak${NC}"

# 기존 nvim 별칭 제거 (중복 방지)
sed -i '/^alias nv=/d' "$SHELL_RC"
sed -i '/^alias vi=/d' "$SHELL_RC"
sed -i '/^alias nvf=/d' "$SHELL_RC"
sed -i '/^alias nvt=/d' "$SHELL_RC"
sed -i '/^export NVIM_MINIMAL=/d' "$SHELL_RC"
sed -i '/^export PRACTICALLI_ASTRO=/d' "$SHELL_RC"

# 새 설정 추가
cat >> "$SHELL_RC" << 'EOF'

# NeoVim Minimal Mode Configuration
# Added by setup-minimal.sh
export NVIM_MINIMAL=true
export PRACTICALLI_ASTRO=false

# NeoVim aliases
alias nv='nvim'                                           # Minimal mode (default)
alias vi='nvim'                                           # Minimal mode (default)
alias nvf='NVIM_MINIMAL=false PRACTICALLI_ASTRO=true nvim'  # Full mode
EOF

# Termux 전용 설정
if [ "$PLATFORM" = "Termux" ]; then
    echo 'export OS_TERMUX=true' >> "$SHELL_RC"
    echo 'alias nvt="nvim"  # Termux mode (already set via OS_TERMUX)' >> "$SHELL_RC"
else
    echo 'alias nvt="OS_TERMUX=true nvim"  # Termux mode simulation' >> "$SHELL_RC"
fi

echo -e "  ${GREEN}✓ Shell configuration updated${NC}"

# 4. 캐시 정리
echo ""
echo -e "${YELLOW}3. Clearing caches...${NC}"
rm -rf "$HOME/.cache/nvim" 2>/dev/null || true
rm -rf "$HOME/.local/state/nvim" 2>/dev/null || true
echo -e "  ${GREEN}✓ Caches cleared${NC}"

# 5. 완료 메시지
echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "Available commands:"
echo "  nv, vi  - Minimal mode (default, fast)"
echo "  nvf     - Full mode (all features)"
echo "  nvt     - Termux mode"
echo ""
echo "To apply changes:"
echo "  source $SHELL_RC"
echo ""
echo "Or restart your terminal."
echo ""

# Termux 전용 메시지
if [ "$PLATFORM" = "Termux" ]; then
    echo -e "${YELLOW}Termux Notes:${NC}"
    echo "- Minimal mode is optimized for mobile"
    echo "- Claude-code.nvim is enabled for AI assistance"
    echo "- Tree-sitter provides syntax highlighting"
fi