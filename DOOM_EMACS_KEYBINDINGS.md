# AstroNvim5 키바인딩 가이드 (둠이맥스 사용자용)

## 기본 키 맵핑 철학
- **SPC**: 리더키 (둠이맥스와 동일)
- **C-h/j/k/l**: 윈도우 네비게이션 
- **M-**: Alt 키 조합 (메타키)
- **Tab**: 매칭 브래킷 점프 (% 대신)

## 핵심 네비게이션 키

### 버퍼 관리 (Doom Emacs 스타일)
```
SPC <tab>     -> 이전 버퍼로 전환 (b#)
SPC b d       -> 버퍼 종료 (kill buffer)  
SPC b D       -> 강제 버퍼 종료
]b / [b       -> 다음/이전 버퍼
```

### 파일 작업 (Doom Emacs 스타일) 
```
SPC f s       -> 파일 저장 (:write)
SPC f r       -> 최근 파일 목록 (Snacks.picker.recent)
SPC W         -> 다른 이름으로 저장 (:write )
```

### 검색 및 네비게이션
```
.             -> 현재 버퍼 라인 검색 (consult-line 대응)
SPC /         -> 프로젝트 검색 (live grep)
SPC s s       -> 버퍼 심볼 검색
SPC s p       -> 프로젝트 파일 검색
```

## 윈도우 관리

### 기본 윈도우 조작
```
C-h/j/k/l     -> 윈도우 간 이동
SPC w s       -> 윈도우 수평 분할
SPC w v       -> 윈도우 수직 분할
SPC w q       -> 윈도우 닫기
SPC w o       -> 다른 윈도우 모두 닫기
```

### 터미널 윈도우
```
SPC t t       -> 토글 터미널
SPC t f       -> 플로팅 터미널
C-h/j/k/l     -> 터미널에서도 윈도우 이동 가능
```

## 메타키(Alt) 조합

### 입력 모드
```
M-Backspace   -> 단어 단위 삭제 (C-w)
M-h/j/k/l     -> 윈도우 이동 (입력모드에서)
```

### 일반 모드
```
M-1/2/3...    -> 탭 선택
M-j/k         -> 라인 이동 (일부 플러그인)
```

## Claude Code 전용 키

### 기본 Claude 조작
```
SPC a c       -> Claude Code 토글
SPC a f       -> Claude Code 포커스  
SPC a r       -> Claude 대화 재개 (--resume)
SPC a C       -> Claude 대화 계속 (--continue)
```

### Claude 파일 관리
```
SPC a b       -> 현재 버퍼를 Claude에 추가
SPC a s       -> 선택 영역을 Claude에 전송
SPC a a       -> diff 승인
SPC a d       -> diff 거부
```

### 추가 Claude 기능
```
SPC c p       -> Claude 프로젝트 설정 (~/.claude.json)
SPC c c       -> Claude Code 토글 (greggh 플러그인)
C-,           -> Claude Code 빠른 토글 (터미널/일반모드)
```

## Git 작업

### 네오깃 (Neogit)
```
SPC g g       -> 깃 상태 (Neogit)
SPC g f       -> 플로팅 깃 상태
SPC g s       -> 깃 상태 (전체화면)
```

### 깃 기본 조작
```
SPC g b       -> 브랜치 관리
SPC g c       -> 커밋
SPC g l       -> 로그 보기
SPC g p       -> 푸시
SPC g P       -> 풀
```

## 특별 기능

### Multiple Cursors (Visual-Multi)
```
gm            -> Multiple Cursors 서브메뉴
gm a          -> 모든 매치 선택
gm n          -> 다음 매치 추가
gm s          -> 단일 커서로 되돌리기
```

### 기타 유용한 키
```
SPC u k       -> 키 입력 시각화 토글 (Showkeys)
SPC E         -> Snacks 파일 탐색기
SPC g j       -> Gist 생성 (파일/영역)
SPC c m       -> MCP Hub 관리
```

## Vim 모달 편집 키

### 일반 모드 네비게이션
```
h/j/k/l       -> 기본 이동
w/b/e         -> 단어 단위 이동  
gg/G          -> 파일 처음/끝
0/$           -> 줄 처음/끝
f/F + 문자    -> 문자로 점프
t/T + 문자    -> 문자 앞으로 점프
```

### 편집 명령
```
i/a           -> 입력모드 (커서 앞/뒤)
I/A           -> 줄 처음/끝에서 입력모드
o/O           -> 아래/위에 새 줄 생성
x/X           -> 문자 삭제 (오른쪽/왼쪽)
dd            -> 줄 삭제
yy            -> 줄 복사  
p/P           -> 붙여넣기 (아래/위)
```

### 비주얼 모드
```
v             -> 문자 단위 선택
V             -> 줄 단위 선택
C-v           -> 블록 단위 선택
gv            -> 이전 선택 영역 재선택
```

## 터미널에서의 특별 키

### Claude Code 터미널에서
```
C-,           -> Claude Code 토글 (터미널 모드)
C-h/j/k/l     -> 윈도우 이동 (터미널에서도 동작)
C-\\ C-n      -> 터미널 노멀 모드로 전환
```

### 이스케이프 대안
```
, .           -> ESC 키 대안 (better-escape 설정)
```

이 가이드를 통해 둠이맥스에서 AstroNvim으로의 전환이 더 수월해질 것입니다!