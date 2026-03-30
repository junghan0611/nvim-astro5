# nvim-astro5 — 에이전트 지침서

## 프로젝트 개요

**범용 Neovim 닷파일(Dotfiles)**. Doom Emacs 사용자가 Neovim에 입문하기 위한 설정.
[Practicalli Astro5](https://practical.li/neovim/) 템플릿을 포크(Fork)하여 개인화한 구성이다.

| 항목 | 값 |
|------|-----|
| 기반(Base) | AstroNvim v5 (`version = "^5"`) |
| 패키지 관리(Package_Manager) | lazy.nvim |
| 대상 Neovim 버전 | 0.11.x |
| 리더키(Leader) | `SPC` (Space) |
| 로컬리더키(LocalLeader) | `,` (Comma) |
| 최초 커밋 | 2025-04-01 |
| 마지막 커밋 | 2026-02-04 |
| 원본(Upstream) | [practicalli/nvim-astro5](https://github.com/practicalli/nvim-astro5) |

## 디렉토리 구조(Directory_Structure)

```
nvim-astro5/
├── init.lua                  # 진입점 — lazy.nvim 부트스트랩
├── lua/
│   ├── lazy_setup.lua        # lazy.nvim 설정 — AstroNvim + community + plugins 로드
│   ├── community.lua         # AstroCommunity 플러그인 임포트
│   └── plugins/
│       ├── minimal-mode.lua  # NVIM_MINIMAL=true 시 경량 모드
│       ├── practicalli.lua   # Practicalli 원본 설정 (Clojure 중심)
│       ├── termux.lua        # Termux(Android) 환경 조건부 설정 (현재 비활성)
│       └── user.lua          # ★ 개인 커스텀 — 테마, 키맵, 플러그인 오버라이드
├── after/ftplugin/
│   └── clojure.lua           # Clojure 파일타입 전용 which-key 그룹
├── ftdetect/
│   └── bb.vim                # Babashka (.bb) → Clojure 파일타입 매핑
├── snippets/                 # VSCode 형식 커스텀 스니펫 (clojure, lua, markdown, global)
├── lazy-lock.json            # 플러그인 버전 잠금 (.gitignore에 포함됨)
├── alacritty/                # Alacritty 터미널 설정
├── ghostty/                  # Ghostty 터미널 설정 + terminfo
├── kitty/                    # Kitty 터미널 설정 (테마, 세션, 탭바)
├── tmux/                     # tmux 설정 (현재 비어 있음)
├── Code/User/                # VSCode/VSpaceCode 설정 참고용
├── install.sh                # 미니멀 모드 설치 스크립트
├── setup-minimal.sh          # 미니멀 환경 셋업
├── test-minimal.sh           # 미니멀 모드 테스트
└── .claude/                  # Claude Code 연동 권한 설정
```

### 플러그인 로드 순서

`lua/plugins/*.lua` 파일은 **알파벳 순서**로 로드된다:
1. `minimal-mode.lua` — 조건부(NVIM_MINIMAL) 비활성화
2. `practicalli.lua` — 원본 Practicalli 설정 (PRACTICALLI_ASTRO=false로 비활성화 가능)
3. `termux.lua` — Termux 조건부 (OS_TERMUX)
4. `user.lua` — **최종 오버라이드** (가장 마지막 로드, 우선순위 최고)

## 주요 플러그인(Plugins) 목록

### AstroCommunity 임포트 (`community.lua`)

| 카테고리 | 플러그인 | 역할 |
|----------|----------|------|
| 색상(Color) | ccc-nvim | 색상 피커(Color_Picker) 및 하이라이터 |
| 자동완성(Completion) | blink-cmp-emoji | 이모지 자동완성 |
| 편집지원(Editing) | rainbow-delimiters-nvim | 무지개 괄호(Rainbow_Parens) |
| 편집지원(Editing) | vim-visual-multi | 다중 커서(Multiple_Cursors), 리더: `gm` |
| 모션(Motion) | nvim-surround | 감싸기(Surround) 편집 |
| 언어팩(Pack) | json, lua | JSON/Lua LSP+Treesitter 통합 |
| 검색(Search) | grug-far-nvim | 프로젝트 전체 검색/치환 |
| 레시피(Recipe) | neovide | Neovide GUI 설정 |
| Git | diffview-nvim | 디프 뷰어(Diff_Viewer) |
| Git | gist-nvim | GitHub Gist 관리 |
| Git | neogit | 대화형 Git 클라이언트 (Magit 대응) |
| Git | octo-nvim | GitHub PR/이슈 관리 |
| UI | noice-nvim | 리치 커맨드 프롬프트 |

### 개인 추가 플러그인 (`user.lua`)

| 플러그인 | 역할 |
|----------|------|
| better-escape.nvim | `,.` 로 ESC 대체 (Practicalli는 `fd`) |
| trim.nvim | 후행 공백(Trailing_Whitespace) 자동 제거 |
| showkeys | 키 입력 시각화 (`SPC u k`) |
| nvim-osc52 | SSH/Docker 환경 OSC 52 클립보드 지원 |
| claude-code.nvim (greggh) | Claude Code 터미널 통합 (`C-,` 토글) |
| mcphub.nvim | MCP 서버 허브 관리 (`SPC a m`) |
| orgmode | Org-mode 지원 (~/org/ 연동) |
| telescope-orgmode.nvim | Telescope에서 orgmode 검색 |
| resession.nvim | 세션 자동저장 비활성화 (불필요한 수정 방지) |
| LuaSnip | 커스텀 스니펫 로더 (snippets/ 디렉토리) |

### 비활성화된 플러그인

- `nvim-parinfer`, `nvim-paredit` — 구조적 편집 비활성화
- `catppuccin` 테마 — 미니멀 모드 최적화로 제거
- `coder/claudecode.nvim` — 주석 처리됨 (greggh 버전 사용 중)
- `simple-denote.nvim` — TODO 상태 (아직 미구현)

## 키바인딩(Keybindings) 커스텀 요약

### Doom Emacs 스타일 파일/버퍼 조작

| 키 | 동작 | 비고 |
|----|------|------|
| `SPC f s` | 파일 저장 | `:write` |
| `SPC f r` | 최근 파일 | Snacks picker |
| `SPC b d` | 버퍼 종료 | kill buffer |
| `SPC b D` | 강제 버퍼 종료 | force kill |
| `SPC <tab>` | 이전 버퍼 전환 | `b#` |
| `Tab` | 매칭 브래킷 점프 | `%` 대체 |

### Claude Code / AI 통합

| 키 | 동작 |
|----|------|
| `C-,` | Claude Code 토글 (일반/터미널 모드) |
| `SPC a c` | Claude Code 토글 |
| `SPC a C` | Claude 대화 계속 (--continue) |
| `SPC a V` | Claude 상세 모드 (--verbose) |
| `SPC a n` | Claude 새 대화 |
| `SPC a p` | Claude 프로젝트 설정 편집 |
| `SPC a m` | MCP Hub |

### Git 관련

| 키 | 동작 |
|----|------|
| `SPC g f` | Neogit 플로팅 상태 |
| `SPC g j` | Gist 생성 (파일) |
| `SPC g J` | Gist 목록 |

### 기타

| 키 | 동작 |
|----|------|
| `,.` | ESC 대체 (모든 모드) |
| `SPC E` | Snacks 파일 탐색기 |
| `SPC W` | 다른 이름으로 저장 |
| `SPC u k` | Showkeys 토글 |
| `gm` | 다중 커서 서브메뉴 |

## Treesitter 언어 파서(Parser)

`user.lua`에서 `ensure_installed`로 명시한 언어 (자동설치 비활성화, `auto_install = false`):

- **설정/데이터**: dockerfile, yaml, toml, json, json5, xml, html, css, scss, nix
- **프로그래밍**: javascript, typescript, tsx, go, rust, java, kotlin, python, ruby, php
- **쉘/도구**: bash, fish, powershell, regex, sql, graphql
- **마크업**: markdown, markdown_inline, rst, latex, bibtex
- **설정파일**: ini, gitignore, gitcommit, git_rebase

## LSP / 포매터(Formatter) / 린터(Linter) 설정 현황

- **LSP 서버 관리**: Mason 자동 설치 방식 (AstroNvim 기본)
- **활성화된 언어팩**: JSON (`astrocommunity.pack.json`), Lua (`astrocommunity.pack.lua`)
- **Clojure 팩**: 주석 처리됨 (`-- { import = "astrocommunity.pack.clojure" }`)
- **자동포맷**: 비활성화 (`autoformat_enabled = false`)
- **Lua 포맷**: StyLua 설정 파일 존재 (`.stylua.toml`), LSP 내장 포맷 비활성화 (`.neoconf.json`)
- **Lint**: Selene 설정 파일 존재 (`selene.toml`)
- **Termux**: Mason 대신 로컬 LSP 서버 사용 옵션 준비됨 (현재 비활성)

## 환경변수(Environment_Variables)

| 변수 | 기본값 | 역할 |
|------|--------|------|
| `NVIM_MINIMAL` | 미설정 | `true` 설정 시 경량 모드 활성화 |
| `PRACTICALLI_ASTRO` | 미설정 | `false` 설정 시 Practicalli 설정 비활성화 |
| `OS_TERMUX` | 미설정 | Termux 환경 감지 시 터뮤크 설정 로드 |

### 미니멀 모드(Minimal_Mode)

`NVIM_MINIMAL=true`로 실행하면:
- DAP(디버거), Conjure, parinfer/paredit 비활성화
- Diffview, Neogit, Octo, aerial, noice, ufo 비활성화
- MCPHub 비활성화
- Treesitter 파서 최소화 (16개)
- 애니메이션/스크롤 비활성화
- 세션 관리 비활성화
- 대용량 파일(200KB+) 하이라이팅 자동 비활성화

## 터미널 에뮬레이터(Terminal_Emulator) 설정

리포에 다중 터미널 설정이 포함되어 있다:

| 터미널 | 경로 | 비고 |
|--------|------|------|
| Ghostty | `ghostty/config` | xterm-ghostty terminfo 포함 |
| Kitty | `kitty/` | 다크/라이트 테마, 세션, 탭바 커스텀 |
| Alacritty | `alacritty/alacritty.toml` | Claude Code 기본 터미널 |
| WezTerm | `wezterm.lua` | 스크롤바 추가 |

## NixOS 환경 설치 방법

```bash
# 1. 클론
git clone git@github.com:junghan0611/nvim-astro5 ~/.config/nvim-astro5

# 2. NVIM_APPNAME으로 멀티 설정 사용
export NVIM_APPNAME=nvim-astro5
nvim

# 3. 또는 alias 설정
alias astro5="NVIM_APPNAME=nvim-astro5 nvim"

# 미니멀 모드 (경량)
alias nv="NVIM_APPNAME=nvim-astro5 NVIM_MINIMAL=true PRACTICALLI_ASTRO=false nvim"
```

NixOS에서는 Neovim, ripgrep, fd, gcc(Treesitter 컴파일), nodejs(Mason) 등이 시스템 패키지로 설치되어 있어야 한다.

## 한국어 입력(Korean_Input) 관련

- **직접적인 한국어 입력기(IME) 설정은 없음**
- 폰트: `Sarasa Term K Nerd Font:13.5` 설정 — 한글 지원 Sarasa 폰트 (Neovide GUI용)
- `,.` ESC 매핑이 한글 입력 모드에서의 ESC 문제를 부분적으로 완화

## 문서(Documentation) 파일

| 파일 | 내용 |
|------|------|
| `README.md` | Practicalli 원본 소개 및 설치 가이드 |
| `README-MINIMAL.md` | 미니멀 모드 설명 |
| `DOOM_EMACS_KEYBINDINGS.md` | Doom Emacs 사용자를 위한 키바인딩 가이드 |
| `ESSENTIAL_KEYS.md` | 윈도우 이동/스크롤 문제 해결 핵심 키 |
| `TOOLS.md` | lazygit 설치, xterm-ghostty terminfo |
| `CHANGELOG.md` | 변경 이력 |

## 개선 가능 항목(TODO)

- [ ] **Clojure 팩 재활성화**: `astrocommunity.pack.clojure` 주석 해제 및 Conjure 설정 정리
- [ ] **simple-denote.nvim 구현**: Emacs Denote와 호환되는 Neovim 플러그인 개발 또는 대안 발굴
- [ ] **한국어 입력기 통합**: `im-select` 또는 `fcitx.nvim` 같은 IME 자동 전환 플러그인 추가
- [ ] **tmux 설정 정리**: `tmux/` 디렉토리가 비어 있음 — 기존 tmux 설정 이전 또는 제거
- [ ] **Termux 설정 활성화**: `termux.lua` 내부 코드가 모두 주석 처리됨
- [ ] **claudecode.nvim (coder) 평가**: greggh 버전과 coder/claudecode.nvim WebSocket 버전 비교 후 선택
- [ ] **lazy-lock.json 관리**: `.gitignore`에 포함되어 재현성(Reproducibility) 약화 — 버전 고정 전략 재검토
- [ ] **Practicalli 업스트림 동기화**: 원본과의 차이 추적 및 선별적 머지
