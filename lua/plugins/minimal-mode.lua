-- ------------------------------------------
-- Minimal Mode Configuration
-- 경량화 테스트를 위한 설정
-- 환경변수: NVIM_MINIMAL=true
-- AstroNvim 키바인딩 유지
-- ------------------------------------------

-- Minimal 모드 체크
local is_minimal = vim.env.NVIM_MINIMAL == "true"

-- Minimal 모드가 아니면 빈 테이블 반환
if not is_minimal then return {} end

-- 모드 알림
vim.notify("🚀 NeoVim Minimal Mode Active", vim.log.levels.INFO)

---@type LazySpec
return {
  -- ------------------------------------------
  -- 개발 도구 비활성화 (용량 절감)

  -- LSP 관련 완전 비활성화 (-20MB)
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },
  { "neovim/nvim-lspconfig", enabled = false },
  { "b0o/schemastore.nvim", enabled = false },
  { "folke/neoconf.nvim", enabled = false },

  -- DAP (디버거) 비활성화 (-5MB)
  { "mfussenegger/nvim-dap", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "rcarriga/cmp-dap", enabled = false },

  -- Formatter/Linter 비활성화 (-5MB)
  { "stevearc/conform.nvim", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },

  -- 언어별 개발 도구 비활성화 (-15MB)
  { "Olical/conjure", enabled = false },
  { "gpanders/nvim-parinfer", enabled = false },
  { "julienvincent/nvim-paredit", enabled = false },
  { "rgroli/other.nvim", enabled = false },

  -- 무거운 Git 도구 비활성화 (-10MB, gitsigns만 유지)
  { "sindrets/diffview.nvim", enabled = false },
  { "NeogitOrg/neogit", enabled = false },
  { "pwntester/octo.nvim", enabled = false },
  { "dinhhuy258/git.nvim", enabled = false },

  -- 불필요한 UI 비활성화 (-10MB)
  { "stevearc/aerial.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },
  { "luukvbaal/statuscol.nvim", enabled = false },

  -- 자동완성 소스 제한 (-5MB)
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },
  { "hrsh7th/cmp-calc", enabled = false },
  { "hrsh7th/cmp-emoji", enabled = false },
  { "jc-doyle/cmp-pandoc-references", enabled = false },
  { "kdheepak/cmp-latex-symbols", enabled = false },

  -- Claude/MCP 관련 (선택적)
  { "ravitemer/mcphub.nvim", enabled = false },
  { "greggh/claude-code.nvim", enabled = true },
  { "coder/claudecode.nvim", enabled = false },

  -- Workspace 관련 플러그인 비활성화
  { "ahmedkhalf/project.nvim", enabled = false },
  { "folke/neodev.nvim", enabled = false },

  -- ------------------------------------------
  -- Tree-sitter 최적화 (필수 언어만)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- 절대 필수
        "lua",
        "vim",
        "vimdoc",
        -- 설정 파일
        "json",
        "yaml",
        "toml",
        -- 문서
        "markdown",
        "markdown_inline",
        -- 스크립트
        "bash",
        -- Git
        "gitignore",
        "gitcommit",
      },
      -- 자동 설치 비활성화
      auto_install = false,
      -- 기능 최소화
      highlight = {
        enable = true,
        -- 대용량 파일 비활성화
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
      -- 불필요한 모듈 비활성화
      indent = { enable = false },
      autotag = { enable = false },
      textobjects = { enable = false },
      context_commentstring = { enable = false },
      matchup = { enable = false },
    },
  },

  -- ------------------------------------------
  -- Snacks 최적화 (핵심만)
  {
    "folke/snacks.nvim",
    opts = {
      -- 대시보드 비활성화
      dashboard = { enabled = false },
      -- 들여쓰기 가이드 비활성화
      indent = { enabled = false },
      -- 알림 레벨 상향
      notifier = {
        enabled = true,
        level = vim.log.levels.WARN,
      },
      -- 애니메이션 비활성화
      animate = { enabled = false },
      -- 스크롤 비활성화
      scroll = { enabled = false },
      -- Git browse 비활성화
      gitbrowse = { enabled = false },
      -- Lazygit 비활성화
      lazygit = { enabled = false },
    },
  },

  -- ------------------------------------------
  -- 자동완성 경량화 (Blink)
  {
    "saghen/blink.cmp",
    opts = {
      -- 키맵 유지 (AstroNvim 스타일)
      keymap = {
        ["<C-Space>"] = { "show", "hide" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      -- 소스 최소화
      sources = {
        providers = {
          -- LSP 비활성화
          lsp = { enabled = false },
          -- 기본만 활성화
          path = {
            enabled = true,
            opts = { trailing_slash = true },
          },
          buffer = {
            enabled = true,
            opts = {
              -- 현재 버퍼만
              get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
            },
          },
          -- 스니펫 비활성화
          snippets = { enabled = false },
        },
      },
      -- 자동 트리거 비활성화
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
          show_on_accept_on_trigger_character = false,
        },
      },
    },
  },

  -- ------------------------------------------
  -- AstroCore 최적화 (키바인딩 유지)
  {
    "AstroNvim/astrocore",
    opts = {
      -- 성능 옵션
      options = {
        opt = {
          -- 파일 관련 비활성화
          swapfile = false,
          backup = false,
          writebackup = false,
          undofile = false,
          -- 검색 최적화
          incsearch = true,
          hlsearch = false,
          -- 업데이트 시간 단축
          updatetime = 100,
          timeoutlen = 300,
          -- 폴딩 비활성화
          foldenable = false,
          -- 자동 읽기 비활성화
          autoread = false,
          -- 메시지 최소화
          shortmess = "filnxtToOFc",
        },
        g = {
          -- 자동 포맷 비활성화
          autoformat_enabled = false,
          -- 진단 비활성화
          diagnostics_mode = 0,
          -- 아이콘 비활성화 (선택적)
          icons_enabled = true, -- AstroNvim UI 유지
        },
      },
      -- 매핑은 user.lua에서 정의된 것 유지
      -- 추가 비활성화 매핑
      mappings = {
        n = {
          -- LSP 관련 매핑 비활성화
          ["<Leader>l"] = false,
          ["gd"] = false,
          ["gD"] = false,
          ["gI"] = false,
          ["gr"] = false,
          ["gR"] = false,
          ["gy"] = false,
          ["K"] = false,
        },
      },
    },
  },

  -- ------------------------------------------
  -- 세션 관리 비활성화
  {
    "stevearc/resession.nvim",
    enabled = false,
  },

  -- ------------------------------------------
  -- 플러그인 로딩 최적화
  {
    "folke/lazy.nvim",
    opts = {
      performance = {
        cache = {
          enabled = true,
        },
        reset_packpath = true,
        rtp = {
          reset = true,
          paths = {},
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
            "man",
            "osc52",
            "spellfile",
          },
        },
      },
    },
  },
}
