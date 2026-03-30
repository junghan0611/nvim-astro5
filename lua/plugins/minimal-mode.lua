-- ------------------------------------------
-- Minimal Mode — ultra-lightweight text viewing
-- NVIM_MINIMAL=true 환경변수로 활성화
-- 기본 모드에서 이미 LSP/Mason이 꺼져 있으므로,
-- 여기서는 무거운 UI와 Git 도구만 추가 비활성화.
-- ------------------------------------------

local is_minimal = vim.env.NVIM_MINIMAL == "true"
if not is_minimal then return {} end

vim.notify("🚀 Minimal Mode", vim.log.levels.INFO)

---@type LazySpec
return {
  -- Git UI 비활성화 (gitsigns는 유지)
  { "sindrets/diffview.nvim", enabled = false },
  { "NeogitOrg/neogit", enabled = false },

  -- 고급 UI 비활성화
  { "folke/noice.nvim", enabled = false },
  { "kevinhwang91/nvim-ufo", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },

  -- Orgmode 비활성화 (뷰잉만)
  { "nvim-orgmode/orgmode", enabled = false },
  { "nvim-orgmode/telescope-orgmode.nvim", enabled = false },

  -- Treesitter 최소화
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "bash", "gitcommit",
      },
      auto_install = false,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 200 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
    },
  },

  -- Snacks 경량화
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      animate = { enabled = false },
      scroll = { enabled = false },
      notifier = { level = vim.log.levels.ERROR },
    },
  },

  -- 성능 옵션
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          swapfile = false,
          backup = false,
          writebackup = false,
          updatetime = 200,
          timeoutlen = 300,
          foldenable = false,
        },
      },
    },
  },

  -- 세션 비활성화
  { "stevearc/resession.nvim", enabled = false },
}
