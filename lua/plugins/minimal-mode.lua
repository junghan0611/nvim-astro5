-- ------------------------------------------
-- Minimal Mode Configuration
-- 경량화 테스트를 위한 설정
-- 환경변수: NVIM_MINIMAL=true
-- 필수 기능 유지, 무거운 기능만 비활성화
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
  -- 무거운 개발 도구 비활성화

  -- DAP (디버거) 비활성화 - 일반 편집에 불필요
  { "mfussenegger/nvim-dap", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "rcarriga/cmp-dap", enabled = false },

  -- 언어별 특수 도구 비활성화
  { "Olical/conjure", enabled = false },
  { "gpanders/nvim-parinfer", enabled = false },
  { "julienvincent/nvim-paredit", enabled = false },
  { "rgroli/other.nvim", enabled = false },

  -- 무거운 Git UI 도구 비활성화 (gitsigns는 유지)
  { "sindrets/diffview.nvim", enabled = false },
  { "NeogitOrg/neogit", enabled = false },
  { "pwntester/octo.nvim", enabled = false },

  -- 고급 UI 기능 비활성화
  { "stevearc/aerial.nvim", enabled = false },
  { "folke/noice.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },

  -- MCP 관련 (선택적)
  { "ravitemer/mcphub.nvim", enabled = false },

  -- ------------------------------------------
  -- Tree-sitter 최적화 (주요 언어만)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- 필수
        "lua",
        "vim",
        "vimdoc",
        -- 설정 파일
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        -- 프로그래밍 기본
        "javascript",
        "typescript",
        "python",
        "bash",
        -- Git
        "gitignore",
        "gitcommit",
      },
      -- 자동 설치 비활성화
      auto_install = false,
      -- 대용량 파일 처리
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 200 * 1024 -- 200 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
    },
  },

  -- ------------------------------------------
  -- Snacks 최적화 (핵심 기능 유지)
  {
    "folke/snacks.nvim",
    opts = {
      -- 대시보드는 유지 (user.lua 커스텀 사용)
      -- 들여쓰기 가이드 비활성화
      indent = { enabled = false },
      -- 알림 레벨 상향 (에러/경고만)
      notifier = {
        enabled = true,
        level = vim.log.levels.WARN,
      },
      -- 애니메이션 비활성화
      animate = { enabled = false },
      -- 스크롤 비활성화
      scroll = { enabled = false },
    },
  },

  -- ------------------------------------------
  -- 성능 옵션
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          -- 스왑/백업 비활성화
          swapfile = false,
          backup = false,
          writebackup = false,
          -- 업데이트 시간 최적화
          updatetime = 200,
          timeoutlen = 300,
          -- 폴딩 비활성화
          foldenable = false,
        },
        g = {
          -- 자동 포맷 비활성화
          autoformat_enabled = false,
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
  -- Lazy.nvim 성능 최적화
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
            "spellfile",
          },
        },
      },
    },
  },
}