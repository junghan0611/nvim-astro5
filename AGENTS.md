# nvim-astro5 — 에이전트 지침서

## 프로젝트 개요

**범용 Neovim 텍스트 에디터 설정**. LSP/개발도구 없이 Treesitter 하이라이팅 + Emacs 스타일 키바인딩.
AstroNvim v5 기반, NixOS 의존성 없이 어디서든 사용 가능.

| 항목 | 값 |
|------|-----|
| 기반 | AstroNvim v5.3.15 (`version = "^5"`) |
| 패키지 관리 | lazy.nvim |
| 대상 Neovim | 0.11+ |
| 리더키 | `SPC`, 로컬리더 `,` |
| 테마 | astrodark |
| which-key | modern 프리셋 (하단 중앙, 둥근 테두리) |
| 원본 | [practicalli/nvim-astro5](https://github.com/practicalli/nvim-astro5) |

## 디렉토리 구조

```
nvim-astro5/
├── run.sh              # 설정 복사 + 플러그인 설치 + ~/bin/nv 래퍼 생성
├── init.lua            # lazy.nvim 부트스트랩
├── lua/
│   ├── lazy_setup.lua  # lazy.nvim 설정
│   ├── community.lua   # AstroCommunity 플러그인
│   └── plugins/
│       ├── minimal-mode.lua  # NVIM_MINIMAL=true 경량 모드
│       └── user.lua          # 메인 설정 (LSP OFF, Emacs 키맵, UI)
├── snippets/           # markdown, lua 스니펫
├── AGENTS.md
└── README.md
```

## 설계 원칙

1. **LSP/Mason/DAP 전부 OFF** — 코드는 에이전트가 쓴다
2. **Treesitter만** — 하이라이팅 + 구조 파악용 (60개 파서)
3. **Emacs 키바인딩** — insert/cmdline 모드에서 C-f/C-b/M-f/M-b/M-d/C-k 등
4. **NixOS 비의존** — apt/brew/pkg로 설치 가능
5. **run.sh 하나로** — 복사 + 설치 + ~/bin/nv 래퍼, symlink 없음
6. **noice 없음** — 기본 하단 커맨드라인 사용

## 플러그인 구성 (44개)

### community.lua (AstroCommunity)
- rainbow-delimiters, vim-visual-multi, nvim-surround
- grug-far (검색/치환), diffview + neogit (Git)

### user.lua
- LSP/Mason/DAP/none-ls 비활성화
- which-key (modern), astrodark 테마, showkeys
- better-escape (`,.` → ESC), trim.nvim, LuaSnip
- nvim-osc52 (SSH 클립보드)
- orgmode + telescope-orgmode
- Treesitter (30개 언어, org 제외 — orgmode 자체 제공)
- Emacs 키바인딩 (insert/cmdline)
- Doom Emacs 스타일 SPC 키맵

## 주의사항

- `org` 파서는 ensure_installed에 넣지 말 것 (nvim-treesitter 레지스트리에 없음, orgmode 플러그인이 자체 제공)
- home-manager가 ~/.config/nvim을 관리하므로 NVIM_APPNAME=nvim-astro5 방식 사용
- ~/.bashrc가 nix store symlink라 alias 직접 등록 불가 → ~/bin/nv 래퍼 방식
