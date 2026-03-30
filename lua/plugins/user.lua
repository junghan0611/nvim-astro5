-- ------------------------------------------
-- User preferences — Text Editor + Reading Environment
--
-- No LSP, no development tools. Treesitter for highlighting.
-- Emacs-inspired keybindings via which-key (SPC leader).
-- `,.` as ESC, trim whitespace, org-mode, git (neogit).
-- ------------------------------------------

---@type LazySpec
return {

  -- ==========================================
  -- LSP / Mason / Development tools — DISABLE
  -- ==========================================

  -- Disable LSP entirely
  { "neovim/nvim-lspconfig", enabled = false },
  { "AstroNvim/astrolsp", enabled = false },

  -- Disable Mason (LSP/formatter/linter installer)
  { "williamboman/mason.nvim", enabled = false },
  { "williamboman/mason-lspconfig.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },

  -- Disable DAP (debugger)
  { "mfussenegger/nvim-dap", enabled = false },
  { "jay-babu/mason-nvim-dap.nvim", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },

  -- Disable none-ls (formatter/linter)
  { "nvimtools/none-ls.nvim", enabled = false },

  -- Disable structural editing
  { "gpanders/nvim-parinfer", enabled = false },
  { "julienvincent/nvim-paredit", enabled = false },

  -- ==========================================
  -- UI
  -- ==========================================

  -- Which-key — vertical classic menu (Emacs style)
  {
    "folke/which-key.nvim",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      sort = { "local", "order", "group", "alphanum", "mod" },
    },
  },

  -- Colorscheme
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "astrodark",
    },
  },

  -- Show key presses
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      excluded_modes = { "i", "t" },
      position = "bottom-center",
      show_count = true,
      maxkeys = 4,
      timeout = 4,
    },
  },

  -- Snacks — dashboard, picker, explorer, notifier
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            "                                        ",
            "   ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ",
            "   ████╗  ██║██║   ██║██║████╗ ████║    ",
            "   ██╔██╗ ██║██║   ██║██║██╔████╔██║    ",
            "   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ",
            "   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ",
            "   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ",
            "          text editor, simple.           ",
          }, "\n"),
        },
      },
      indent = { enabled = false },
      notifier = {
        level = vim.log.levels.WARN,
        win = { preview = { wo = { wrap = true } } },
      },
    },
  },

  -- ==========================================
  -- Editor tools
  -- ==========================================

  -- `,.` as ESC (all modes)
  {
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    opts = {
      timeout = vim.o.timeoutlen,
      default_mappings = false,
      mappings = {
        i = { [","] = { ["."] = "<Esc>" } },
        c = { [","] = { ["."] = "<Esc>" } },
        t = { [","] = { ["."] = "<Esc>" } },
        v = { [","] = { ["."] = "<Esc>" } },
        s = { [","] = { ["."] = "<Esc>" } },
      },
    },
  },

  -- Trim trailing whitespace
  {
    "cappyzawa/trim.nvim",
    event = "User AstroFile",
    opts = {},
  },

  -- Custom snippets (markdown)
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },

  -- OSC 52 clipboard (SSH/Docker/remote)
  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function()
      require("osc52").setup {
        max_length = 0,
        silent = false,
        trim = false,
        tmux_passthrough = true,
      }
      if vim.env.SSH_CLIENT or vim.env.SSH_TTY or os.getenv "container" then
        vim.api.nvim_create_autocmd("TextYankPost", {
          callback = function()
            if vim.v.event.operator == "y" and vim.v.event.regname == "" then require("osc52").copy_register "" end
          end,
        })
      end
    end,
  },

  -- ==========================================
  -- Org-mode
  -- ==========================================

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup {
        org_agenda_files = "~/org/**/*",
        org_default_notes_file = "~/org/notes.org",
        org_todo_keywords = { "TODO", "PROGRESS", "|", "DONE", "CANCELLED" },
        org_startup_indented = false,
        org_adapt_indentation = false,
        org_hide_leading_stars = false,
        org_hide_emphasis_markers = false,
        org_ellipsis = "...",
        org_log_done = "time",
      }
    end,
  },

  {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-orgmode/orgmode",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "orgmode"
    end,
  },

  -- ==========================================
  -- Treesitter — highlighting only, no LSP
  -- ==========================================

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Markup & Documentation (primary use)
        -- NOTE: "org" 파서는 nvim-orgmode 플러그인이 자체 제공 (nvim-treesitter에 없음)
        "markdown",
        "markdown_inline",
        "rst",
        "latex",
        "bibtex",
        -- Configuration & Data
        "json",
        "json5",
        "yaml",
        "toml",
        "xml",
        "html",
        "css",
        "nix",
        "dockerfile",
        -- Programming (read-only highlighting)
        "lua",
        "python",
        "javascript",
        "typescript",
        "go",
        "rust",
        "bash",
        -- Git
        "gitignore",
        "gitcommit",
        "git_rebase",
        -- Misc
        "regex",
        "sql",
        "ini",
        "vim",
        "vimdoc",
      },
      auto_install = false,
    },
  },

  -- ==========================================
  -- Session — disable auto-save
  -- ==========================================

  {
    "stevearc/resession.nvim",
    opts = {
      autosave = {
        last = false,
        cwd = false,
      },
    },
  },

  -- ==========================================
  -- Neovim Options & Key Mappings
  -- ==========================================

  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        opt = {
          spell = false,
          wrap = true,
          guifont = "Sarasa Term K Nerd Font:13.5",
          undofile = false,
          formatoptions = "jql",
          clipboard = "unnamedplus",
          ve = "",
          whichwrap = "",
        },
        g = {
          loaded_perl_provider = 0,
          loaded_ruby_provider = 0,
          loaded_node_provider = 0,
          autoformat_enabled = false,
          VM_leader = "gm",
        },
      },
      mappings = {
        -- ==========================================
        -- Emacs keybindings (insert + command mode)
        -- ==========================================
        i = {
          -- 커서 이동
          ["<C-f>"] = { "<Right>", desc = "Forward char" },
          ["<C-b>"] = { "<Left>", desc = "Backward char" },
          ["<C-a>"] = { "<Home>", desc = "Beginning of line" },
          ["<C-e>"] = { "<End>", desc = "End of line" },
          ["<M-f>"] = { "<C-Right>", desc = "Forward word" },
          ["<M-b>"] = { "<C-Left>", desc = "Backward word" },
          -- 삭제
          ["<C-d>"] = { "<Del>", desc = "Delete char forward" },
          ["<M-d>"] = { "<C-o>dw", desc = "Delete word forward" },
          ["<C-k>"] = { "<C-o>D", desc = "Kill to end of line" },
          ["<M-BS>"] = { "<C-w>", desc = "Delete word backward" },
          -- 기타
          ["<C-y>"] = { "<C-r>+", desc = "Yank (paste)" },
          ["<C-o>"] = { "<C-o>o", desc = "Open line below" },
        },
        c = {
          -- 커맨드라인에서도 Emacs 이동
          ["<C-f>"] = { "<Right>", desc = "Forward char" },
          ["<C-b>"] = { "<Left>", desc = "Backward char" },
          ["<C-a>"] = { "<Home>", desc = "Beginning of line" },
          ["<C-e>"] = { "<End>", desc = "End of line" },
          ["<M-f>"] = { "<C-Right>", desc = "Forward word" },
          ["<M-b>"] = { "<C-Left>", desc = "Backward word" },
          ["<C-d>"] = { "<Del>", desc = "Delete char forward" },
          ["<M-d>"] = { "<S-Right><C-w>", desc = "Delete word forward" },
          ["<M-BS>"] = { "<C-w>", desc = "Delete word backward" },
        },

        n = {
          -- Multiple Cursors sub-menu
          ["gm"] = { name = "Multiple Cursors" },

          -- Buffer navigation
          ["<Leader><tab>"] = { "<cmd>b#<cr>", desc = "Previous buffer" },
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- Doom Emacs style — file
          ["<Leader>fs"] = { "<cmd>write<cr>", desc = "Save file" },
          ["<Leader>fr"] = { function() require("snacks").picker.recent() end, desc = "Recent files" },
          ["<Leader>W"] = { ":write ", desc = "Save as file" },

          -- Doom Emacs style — buffer
          ["<Leader>bd"] = { function() require("astrocore.buffer").close() end, desc = "Kill buffer" },
          ["<Leader>bD"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force kill buffer" },

          -- File explorer
          ["<Leader>E"] = { "<cmd>lua Snacks.picker.explorer()<cr>", desc = "Snacks Explorer" },

          -- Tab key for matching bracket jump (like %)
          ["<Tab>"] = { "%", desc = "Jump to matching bracket" },

          -- Git
          ["<Leader>gf"] = { "<cmd>Neogit kind=floating<cr>", desc = "Git Status (floating)" },

          -- Showkeys
          ["<Leader>uk"] = { "<cmd>ShowkeysToggle<cr>", desc = "Toggle Showkeys" },
        },
        v = {},
      },
    },
  },
}
