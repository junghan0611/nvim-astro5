#!/bin/bash
# NeoVim Minimal Mode 테스트 스크립트

echo "🚀 NeoVim Minimal Mode Test"
echo "=========================="
echo ""

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. 기존 플러그인 백업
echo -e "${YELLOW}1. 플러그인 캐시 정리...${NC}"
rm -rf ~/.local/share/nvim/lazy/lazy.nvim.cache
echo -e "${GREEN}✓ 캐시 정리 완료${NC}"
echo ""

# 2. 일반 모드 테스트
echo -e "${YELLOW}2. 일반 모드 시작 시간 측정...${NC}"
NORMAL_START=$(date +%s%N)
nvim --headless +qa 2>/dev/null
NORMAL_END=$(date +%s%N)
NORMAL_TIME=$(( ($NORMAL_END - $NORMAL_START) / 1000000 ))
echo -e "${GREEN}✓ 일반 모드: ${NORMAL_TIME}ms${NC}"
echo ""

# 3. Minimal 모드 테스트
echo -e "${YELLOW}3. Minimal 모드 시작 시간 측정...${NC}"
MINIMAL_START=$(date +%s%N)
NVIM_MINIMAL=true nvim --headless +qa 2>/dev/null
MINIMAL_END=$(date +%s%N)
MINIMAL_TIME=$(( ($MINIMAL_END - $MINIMAL_START) / 1000000 ))
echo -e "${GREEN}✓ Minimal 모드: ${MINIMAL_TIME}ms${NC}"
echo ""

# 4. 개선율 계산
if [ $NORMAL_TIME -gt 0 ]; then
    IMPROVEMENT=$(( (($NORMAL_TIME - $MINIMAL_TIME) * 100) / $NORMAL_TIME ))
    echo -e "${YELLOW}4. 성능 개선:${NC}"
    echo -e "   ${GREEN}${IMPROVEMENT}% 빠름${NC}"
    echo ""
fi

# 5. 플러그인 수 비교
echo -e "${YELLOW}5. 로드된 플러그인 수 비교...${NC}"
echo -n "   일반 모드: "
nvim --headless -c 'echo len(filter(copy(v:oldfiles), "v:val =~ \"lazy\""))' -c 'qa' 2>/dev/null | tail -1
echo -n "   Minimal 모드: "
NVIM_MINIMAL=true nvim --headless -c 'echo len(filter(copy(v:oldfiles), "v:val =~ \"lazy\""))' -c 'qa' 2>/dev/null | tail -1
echo ""

# 6. 대화형 테스트
echo -e "${YELLOW}6. 대화형 테스트${NC}"
echo "   다음 명령어로 직접 테스트할 수 있습니다:"
echo ""
echo -e "   ${GREEN}# 일반 모드${NC}"
echo "   nvim"
echo ""
echo -e "   ${GREEN}# Minimal 모드${NC}"
echo "   NVIM_MINIMAL=true nvim"
echo ""
echo -e "   ${GREEN}# Minimal + Practicalli 비활성화${NC}"
echo "   NVIM_MINIMAL=true PRACTICALLI_ASTRO=false nvim"
echo ""
echo -e "   ${GREEN}# Minimal 모드 (별칭 설정)${NC}"
echo "   alias nvim-min='NVIM_MINIMAL=true PRACTICALLI_ASTRO=false nvim'"
echo ""

# 7. 용량 확인
echo -e "${YELLOW}7. 플러그인 디렉토리 용량${NC}"
if [ -d ~/.local/share/nvim/lazy ]; then
    echo -n "   전체 용량: "
    du -sh ~/.local/share/nvim/lazy 2>/dev/null | cut -f1
    echo ""
    echo "   상위 5개 플러그인:"
    du -sh ~/.local/share/nvim/lazy/* 2>/dev/null | sort -rh | head -5 | sed 's/^/   /'
fi
echo ""

echo -e "${GREEN}테스트 완료!${NC}"
echo ""
echo "💡 Tip: ~/.bashrc 또는 ~/.zshrc에 다음을 추가하세요:"
echo "   alias nv='nvim'"
echo "   alias nvm='NVIM_MINIMAL=true PRACTICALLI_ASTRO=false nvim'"
echo "   alias nvt='NVIM_MINIMAL=true PRACTICALLI_ASTRO=false OS_TERMUX=true nvim'"