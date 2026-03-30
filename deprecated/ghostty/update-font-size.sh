#!/bin/bash

# ghostty 폰트 크기 업데이트 스크립트
CONFIG_FILE="$HOME/.config/nvim/ghostty/config"

# 폰트 크기 가져오기
FONT_SIZE=$(~/.local/bin/set-font-size.sh 2>/dev/null | grep '터미널 폰트:' | sed 's/.*터미널 폰트: //' | grep -o '[0-9.]*')

# 기본값 설정 (스크립트 실패시)
if [ -z "$FONT_SIZE" ]; then
    FONT_SIZE="17"
fi

# 현재 설정된 폰트 크기 확인
CURRENT_FONT_SIZE=$(grep "^font-size" "$CONFIG_FILE" | sed 's/font-size = //')

# 폰트 크기가 다르면 업데이트
if [ "$CURRENT_FONT_SIZE" != "$FONT_SIZE" ]; then
    sed -i "s/^font-size = .*/font-size = $FONT_SIZE/" "$CONFIG_FILE"
    echo "ghostty 폰트 크기를 $FONT_SIZE 로 업데이트했습니다."
fi