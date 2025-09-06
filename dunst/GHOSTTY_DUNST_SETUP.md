# Ghostty + Dunst 알림 설정 가이드

## 개요
Ghostty 터미널에서 dunst 알림 시스템을 통해 시각적/음향적 알림을 받는 설정 방법입니다.

## Ghostty 설정

### 1. 기본 설정 파일 위치
`~/.config/ghostty/config`

### 2. 터미널 벨 및 알림 설정
```ini
# 터미널 벨을 시각적 + 음향적으로 처리
bell-style = visual-and-sound

# 터미널 벨 발생시 dunst 알림 실행
bell-command = notify-send "Ghostty" "Terminal bell activated"

# 클립보드 지원 (Claude Code와의 원활한 연동)
clipboard-read = allow
clipboard-write = allow

# 쉘 통합 기능 활성화
shell-integration-features = cursor,sudo,title

# 백그라운드에서 실행 중인 명령 완료시 알림
# (선택사항) 긴 명령 실행 후 알림받고 싶을 때
# command-timeout = 5
# command-timeout-command = notify-send "Ghostty" "Long running command completed"
```

## Dunst 설정

### 1. 설정 파일 위치
`~/.config/dunst/dunstrc`

### 2. 전역 알림 설정
```ini
[global]
# 기본 알림 위치
origin = top-right
offset = 10x50

# 알림 크기
width = (0, 400)
height = 300
scale = 0

# 알림 표시 시간 (밀리초)
idle_threshold = 120

# 폰트 설정
font = "Noto Sans KR" 10

# 알림 사운드 전역 설정
play_sound = true
sound_command = /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga

# 알림 스타일
frame_width = 2
frame_color = "#8CAAEE"
separator_color = frame

# 텍스트 설정
alignment = left
vertical_alignment = center
show_age_threshold = 60
word_wrap = yes
ellipsize = middle
ignore_newline = no
stack_duplicates = true
hide_duplicate_count = false
show_indicators = yes
```

### 3. Ghostty 전용 알림 규칙
```ini
[ghostty_bell]
appname = "Ghostty"
summary = "*bell*"
urgency = normal
timeout = 3000
background = "#303446"
foreground = "#C6D0F5"
frame_color = "#F2D5CF"
sound_command = /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/bell.oga

[ghostty_notification]
appname = "Ghostty"
urgency = normal
timeout = 5000
background = "#232634"
foreground = "#C6D0F5"
frame_color = "#A6D189"
sound_command = /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/complete.oga

[ghostty_error]
appname = "Ghostty"
summary = "*error*"
urgency = critical
timeout = 10000
background = "#232634"
foreground = "#E78284"
frame_color = "#E78284"
sound_command = /usr/bin/paplay /usr/share/sounds/freedesktop/stereo/dialog-error.oga
```

## 추가 스크립트

### 1. 커스텀 알림 스크립트
`~/.local/bin/ghostty-notify`
```bash
#!/bin/bash
# Ghostty 전용 알림 스크립트

# 사용법: ghostty-notify "제목" "내용" [urgency_level]
TITLE=${1:-"Ghostty"}
MESSAGE=${2:-"Notification"}
URGENCY=${3:-"normal"}

notify-send \
  -a "Ghostty" \
  -u "$URGENCY" \
  -t 3000 \
  -i terminal \
  "$TITLE" \
  "$MESSAGE"
```

실행 권한 부여:
```bash
chmod +x ~/.local/bin/ghostty-notify
```

### 2. 명령 완료 알림 스크립트
`~/.local/bin/ghostty-command-done`
```bash
#!/bin/bash
# 긴 명령어 실행 완료 알림

COMMAND="$1"
EXIT_CODE="$2"
DURATION="$3"

if [ "$EXIT_CODE" = "0" ]; then
    ghostty-notify "Command Completed" "✅ '$COMMAND' completed in ${DURATION}s" "normal"
else
    ghostty-notify "Command Failed" "❌ '$COMMAND' failed with code $EXIT_CODE" "critical"
fi
```

## 시스템 사운드 파일

### 기본 시스템 사운드 위치
```bash
# 시스템 기본 사운드 확인
ls /usr/share/sounds/freedesktop/stereo/

# 자주 사용되는 사운드들:
# - bell.oga              (터미널 벨)  
# - complete.oga          (작업 완료)
# - message-new-instant.oga (새 메시지)
# - dialog-error.oga      (에러)
# - dialog-warning.oga    (경고)
```

### 커스텀 사운드 사용
원하는 사운드 파일을 `~/.config/sounds/` 디렉토리에 저장하고 dunst 설정에서 경로를 지정:

```ini
sound_command = /usr/bin/paplay ~/.config/sounds/custom-notification.ogg
```

## 테스트 명령어

### 1. 기본 알림 테스트
```bash
notify-send "Test" "Dunst is working!"
```

### 2. Ghostty 알림 테스트  
```bash
notify-send -a "Ghostty" "Terminal Test" "This is a Ghostty notification"
```

### 3. 터미널 벨 테스트
```bash
echo -e '\a'  # 터미널에서 벨 소리 발생
```

### 4. 사운드 재생 테스트
```bash
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
```

## 문제해결

### 1. 소리가 들리지 않을 때
```bash
# PulseAudio 상태 확인
systemctl --user status pulseaudio

# 사운드 파일 재생 테스트
paplay /usr/share/sounds/freedesktop/stereo/bell.oga
```

### 2. 알림이 표시되지 않을 때
```bash
# dunst 프로세스 확인
pgrep dunst

# dunst 재시작
killall dunst && dunst &

# dunst 설정 문법 확인
dunst -config ~/.config/dunst/dunstrc -print
```

### 3. 설정 적용
```bash
# Ghostty 설정 다시 로드 (재시작 필요)
# dunst 설정 다시 로드
killall dunst && dunst &
```

## Claude Code와의 연동

Claude Code 사용 중 다음 상황에서 알림을 받을 수 있습니다:

1. **긴 응답 생성 완료**: Claude의 응답이 완료되었을 때
2. **에러 발생**: 네트워크 오류나 API 제한 등
3. **파일 변경 감지**: Claude가 파일을 수정했을 때

Ghostty의 `bell-command`와 dunst를 연동하여 이런 상황들에 대한 알림을 받을 수 있습니다.

---

이 설정을 통해 터미널 작업 중 중요한 이벤트들을 놓치지 않고 알림을 받을 수 있습니다!