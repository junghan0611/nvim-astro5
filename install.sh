#!/bin/bash
# AstroNvim Minimal Mode 설치 스크립트

set -e

echo "🚀 AstroNvim Minimal Mode Setup"
echo "================================"
echo ""

# 색상
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 플랫폼 감지
if [ -n "$TERMUX_VERSION" ]; then
    PLATFORM="Termux"
    SHELL_RC="$HOME/.bashrc"
else
    PLATFORM="Linux"
    if [ -n "$ZSH_VERSION" ] || [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
    fi
fi

echo -e "${YELLOW}Platform:${NC} $PLATFORM"
echo -e "${YELLOW}Shell RC:${NC} $SHELL_RC"
echo ""

# 0. Termux 패키지 확인
if [ "$PLATFORM" = "Termux" ]; then
    echo -e "${YELLOW}0. Checking Termux packages...${NC}"
    
    # Neovim 확인
    if ! command -v nvim &> /dev/null; then
        echo "  Installing neovim..."
        pkg install neovim -y
    fi
    
    # Tree-sitter 확인 (Termux에서는 libtreesitter)
    if ! pkg list-installed 2>/dev/null | grep -q tree-sitter; then
        echo "  Installing libtreesitter..."
        pkg install tree-sitter\* -y
    fi
    
    # Ripgrep 확인
    if ! command -v rg &> /dev/null; then
        echo "  Installing ripgrep..."
        pkg install ripgrep -y
    fi
    
    echo -e "  ${GREEN}✓ Termux packages ready${NC}"
    echo ""
fi

# 1. 환경변수 설정
echo -e "${YELLOW}1. Setting environment variables...${NC}"

# 백업
if [ -f "$SHELL_RC" ]; then
    cp "$SHELL_RC" "$SHELL_RC.bak-$(date +%Y%m%d)"
    echo -e "  Backup: $SHELL_RC.bak-$(date +%Y%m%d)"
fi

# 기존 설정 제거
sed -i '/# AstroNvim Minimal Mode/,/# End AstroNvim/d' "$SHELL_RC" 2>/dev/null || true

# 새 설정 추가
cat >> "$SHELL_RC" << 'EOF'

# AstroNvim Minimal Mode
export NVIM_MINIMAL=true
export PRACTICALLI_ASTRO=false

# Aliases
alias nv='nvim'
alias vi='nvim'
alias nvf='NVIM_MINIMAL=false PRACTICALLI_ASTRO=true nvim'
EOF

# Termux 전용
if [ "$PLATFORM" = "Termux" ]; then
    echo 'export OS_TERMUX=true' >> "$SHELL_RC"
else
    echo 'alias nvt="OS_TERMUX=true nvim"' >> "$SHELL_RC"
fi

echo '# End AstroNvim' >> "$SHELL_RC"

echo -e "  ${GREEN}✓ Environment variables set${NC}"

# 2. 플러그인 설치
echo ""
echo -e "${YELLOW}2. Installing plugins...${NC}"
echo "  Starting Neovim (this may take a moment)..."

nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

echo -e "  ${GREEN}✓ Plugins installed${NC}"

# 3. 캐시 정리
echo ""
echo -e "${YELLOW}3. Clearing caches...${NC}"
rm -rf "$HOME/.cache/nvim" 2>/dev/null || true
rm -rf "$HOME/.local/state/nvim" 2>/dev/null || true
echo -e "  ${GREEN}✓ Caches cleared${NC}"

# 완료
echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo "Commands:"
echo "  nv, vi  - Minimal mode (default)"
echo "  nvf     - Full mode"
if [ "$PLATFORM" != "Termux" ]; then
    echo "  nvt     - Termux mode"
fi
echo ""
echo "Apply changes:"
echo "  source $SHELL_RC"
echo ""
