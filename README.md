# nvim-astro5

AstroNvim v5 기반 텍스트 에디터 설정. LSP 없음, 개발도구 없음.
Treesitter 하이라이팅 + Emacs 스타일 키바인딩으로 파일 읽고 편집하는 용도.

## 빠른 시작

```bash
git clone https://github.com/junghan0611/nvim-astro5
cd nvim-astro5
./run.sh --install   # 설정 복사 + 플러그인 설치 + ~/bin/nv 생성
nv                   # 실행
```

## 필요한 것

- neovim 0.11+
- git, ripgrep
- C 컴파일러 (gcc/clang — Treesitter 파서 빌드용)

```bash
# Ubuntu/Debian
sudo apt install neovim git ripgrep build-essential

# macOS
brew install neovim git ripgrep

# Termux
pkg install neovim git ripgrep clang
```

## 사용법

```bash
nv                    # 실행 (~/bin/nv 래퍼)
nv file.md            # 파일 열기
./run.sh --minimal    # 미니멀 모드 (Git UI 등 추가 비활성화)
```

## 핵심 키바인딩

### Leader (SPC) — Doom Emacs 스타일

| 키 | 동작 |
|----|------|
| `SPC f s` | 파일 저장 |
| `SPC f r` | 최근 파일 |
| `SPC b d` | 버퍼 닫기 |
| `SPC <tab>` | 이전 버퍼 전환 |
| `SPC E` | 파일 탐색기 |
| `SPC /` | 프로젝트 검색 |
| `SPC g f` | Git 상태 (neogit) |
| `Tab` | 괄호 매칭 점프 |
| `gm` | 다중 커서 |
| `,.` | ESC 대체 (모든 모드) |

### Insert/Command — Emacs 키바인딩

| 키 | 동작 |
|----|------|
| `C-f` / `C-b` | 한 글자 앞/뒤 |
| `M-f` / `M-b` | 한 단어 앞/뒤 |
| `C-a` / `C-e` | 줄 처음/끝 |
| `C-d` | 앞 글자 삭제 |
| `M-d` | 앞 단어 삭제 |
| `M-BS` | 뒤 단어 삭제 |
| `C-k` | 줄 끝까지 삭제 |
| `C-y` | 붙여넣기 |

## 포함된 기능

- **Treesitter**: markdown, org, json, yaml, lua, python, bash 등 30개 언어 하이라이팅
- **Org-mode**: nvim-orgmode + telescope 연동
- **Git**: neogit (magit 대응) + diffview
- **검색**: grug-far (프로젝트 전체 검색/치환)
- **UI**: which-key (modern), snacks (dashboard/picker/explorer)
- **편집**: nvim-surround, vim-visual-multi, trim.nvim, better-escape
- **클립보드**: OSC 52 (SSH/Docker 환경)

## 없는 것 (의도적)

LSP, Mason, DAP, 포매터, 린터, noice — 전부 없음.
코드는 에이전트가 쓰고, 이건 읽고 편집하는 도구.
