# 🚀 AstroNvim Minimal Configuration

경량화된 AstroNvim 설정 - 텍스트 편집에 집중

## ✨ 특징

- **경량 모드 기본**: LSP/DAP 제거로 가벼운 실행
- **Tree-sitter 구문 강조**: 필수 언어만 포함
- **Claude Code 통합**: AI 어시스턴트 지원
- **AstroNvim 키바인딩**: 익숙한 단축키 유지
- **Termux 지원**: 모바일 환경 대응

## 📦 설치

### 사전 요구사항
- Neovim >= 0.9.0
- Git
- Ripgrep (`rg`)
- Node.js (선택)

### 빠른 설치

```bash
# 기존 설정 백업
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/yourusername/nvim-config ~/.config/nvim

# 설치 스크립트 실행
cd ~/.config/nvim && ./install.sh
```

### 수동 설치

```bash
# 1. Clone
git clone https://github.com/yourusername/nvim-config ~/.config/nvim

# 2. 첫 실행 (플러그인 자동 설치)
nvim

# 3. Shell 설정
echo 'export NVIM_MINIMAL=true' >> ~/.bashrc
echo 'export PRACTICALLI_ASTRO=false' >> ~/.bashrc
echo 'alias nv="nvim"' >> ~/.bashrc
source ~/.bashrc
```

## 🎯 사용법

### 실행 모드

| 명령어 | 모드 | 설명 |
|--------|------|------|
| `nv`, `nvim` | Minimal (기본) | 경량 모드 |
| `nvf` | Full | 모든 기능 활성화 |
| `nvt` | Termux | 모바일 최적화 |

### 주요 키맵

- **Leader**: `Space`
- **ESC 대체**: `,.`
- **파일 탐색**: `<Space>e`
- **파일 검색**: `<Space>ff`
- **Claude Code**: `<C-,>`

## 📁 주요 파일

```
~/.config/nvim/
├── lua/plugins/
│   ├── minimal-mode.lua    # 경량화 설정
│   ├── user.lua            # 사용자 설정
│   └── termux.lua          # Termux 전용
├── install.sh              # 설치 스크립트
└── README-MINIMAL.md       # 이 문서
```

## ⚙️ 환경변수

| 변수 | 기본값 | 설명 |
|------|--------|------|
| `NVIM_MINIMAL` | `true` | 경량 모드 |
| `PRACTICALLI_ASTRO` | `false` | Practicalli 비활성화 |
| `OS_TERMUX` | - | Termux 모드 |

## 📱 Termux 설치

```bash
# 기본 패키지 업데이트
pkg update && pkg upgrade

# 필수 패키지 (install.sh가 자동으로 설치)
# - neovim
# - libtreesitter (tree-sitter 지원)
# - ripgrep
# - git

# Clone 및 자동 설치
git clone https://github.com/yourusername/nvim-config ~/.config/nvim
cd ~/.config/nvim && ./install.sh
```

## 🔧 커스터마이징

### Tree-sitter 언어 추가

`lua/plugins/minimal-mode.lua` 수정:

```lua
ensure_installed = {
  "lua", "vim", "vimdoc",
  "json", "yaml", "toml",
  "markdown", "markdown_inline",
  "bash",
  -- 추가
  "python", "javascript",
}
```

---

**기반**: [AstroNvim](https://astronvim.com/)  
**원본**: [Practicalli/astro-config](https://github.com/practicalli/astro-config)