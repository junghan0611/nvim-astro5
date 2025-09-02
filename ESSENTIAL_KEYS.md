# ESSENTIAL KEYS - 문제 해결용 핵심 키바인딩

## 🚨 윈도우 이동 (Ctrl-w 대체)
```
Ctrl-h    왼쪽 윈도우로
Ctrl-j    아래 윈도우로  
Ctrl-k    위 윈도우로
Ctrl-l    오른쪽 윈도우로
```

## 📜 스크롤 (마우스 휠 대체)
```
Ctrl-u    반 페이지 위로
Ctrl-d    반 페이지 아래로
Ctrl-b    한 페이지 위로 (Page Up)
Ctrl-f    한 페이지 아래로 (Page Down)
Ctrl-y    한 줄 위로 스크롤
Ctrl-e    한 줄 아래로 스크롤
```

## 🔄 tmux copy-mode 스크롤 (터미널/클로드코드)
```
C-a [     copy-mode 진입
ESC       copy-mode 종료
q         copy-mode 종료

copy-mode 내에서:
M-v       반페이지 아래 (Alt+v)
M-u       반페이지 위 (Alt+u)
M-b       이전 단어 (Alt+b)
M-f       다음 단어 (Alt+f) - 작동 안하면 패스
/         검색
n         다음 검색결과
N         이전 검색결과
```

## ⚠️ 문제 상황 대응

### Claude Code에서 스크롤 안될 때
1. tmux copy-mode 사용: `C-a [` 누르고 vi 키로 스크롤
2. 마우스 휠 사용 (copy-mode 자동 진입)
3. Neovim 내부: `Ctrl-u/d` 또는 `Ctrl-b/f`

### 윈도우 이동 안될 때 (Ctrl-w가 delete로 동작)
1. `Ctrl-h/j/k/l` 사용
2. 명령 모드: `:wincmd h/j/k/l`
3. Leader 키: `SPC w h/j/k/l` (설정된 경우)

### Alt-backspace 문제
- 터미널 창이 클리어되는 문제 (수정 예정)