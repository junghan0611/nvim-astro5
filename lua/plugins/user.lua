-- ------------------------------------------
-- Junghanacs preferences
--
-- which-key menu vertical orientation
-- catppuccin-mocha colorscheme
-- Show key presses in popup (SPC u k)
-- Snacks customisation
-- -- Startup dashboard banner
-- -- indent guides disabled
-- -- notifier log level INFO
-- `,.` as alternate `ESC` key mapping (better-escape.nvim)
-- Trim blank space automatically
-- Custom snippets
-- Gist public
-- Neovim global options & key mappings
-- ------------------------------------------

-- INFO: Create your own preferences in `lua/plugins/your-name.lua`
-- INFO: Files under `lua/plugins/*.lua` load in alphabetical order,
-- so plugin overrides should be the last file to load

-- INFO: Config in this file skipped if `PRACTICALLI_ASTRO` environment variable set to false
local user_practicalli = vim.env.PRACTICALLI_ASTRO
if user_practicalli == "false" then return {} end

---@type LazySpec
return {

  -- ------------------------------------------
  -- UI Customisation

  -- Vertical which-key menu
  {
    "folke/which-key.nvim",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "modern",
      sort = { "local", "order", "group", "alphanum", "mod" },
    },
  },
  -- Colorscheme (Theme)
  ---@type LazySpec
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  -- show key presses in normal mode
  {
    "nvzone/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      excluded_modes = { "i", "t" }, -- skip insert and terminal
      position = "bottom-center",
      show_count = true,
      maxkeys = 4,
      timeout = 4,
    },
  },
  -- Snacks Customisation
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          -- customize the dashboard header
          header = table.concat({
            " ██████╗ ██████╗  █████╗  ██████╗████████╗██╗ ██████╗ █████╗ ",
            " ██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██║██╔════╝██╔══██╗",
            " ██████╔╝██████╔╝███████║██║        ██║   ██║██║     ███████║",
            " ██╔═══╝ ██╔══██╗██╔══██║██║        ██║   ██║██║     ██╔══██║",
            " ██║     ██║  ██║██║  ██║╚██████╗   ██║   ██║╚██████╗██║  ██║",
            " ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝╚═╝  ╚═╝",
          }, "\n"),
        },
      },

      -- indent guides - disable by default
      indent = { enabled = false },

      notifier = {
        -- Keep AstroNvim default style for proper code change notifications
        -- log level: TRACE DEBUG ERROR WARN INFO  OFF
        level = vim.log.levels.WARN,
        -- wrap words in picker right panel
        win = { preview = { wo = { wrap = true } } },
      },
    },
  },

  -- ------------------------------------------

  -- disable paredit
  { "gpanders/nvim-parinfer", enabled = false },
  { "julienvincent/nvim-paredit", enabled = false },

  -- OSC 52 clipboard support for remote environments
  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function()
      require("osc52").setup {
        max_length = 0, -- 무제한
        silent = false, -- 복사 알림 표시
        trim = false, -- 공백 유지
        tmux_passthrough = true, -- tmux 지원
      }

      -- SSH/Docker 환경에서 yank 시 자동 OSC 52 복사
      if vim.env.SSH_CLIENT or vim.env.SSH_TTY or os.getenv "container" then
        vim.api.nvim_create_autocmd("TextYankPost", {
          callback = function()
            if vim.v.event.operator == "y" and vim.v.event.regname == "" then require("osc52").copy_register "" end
          end,
        })
      end
    end,
  },

  -- ------------------------------------------
  -- Editor tools

  -- Alternative to Esc key using `,.` key mapping
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
  -- Trim trailing blank space and blank lines
  {
    "cappyzawa/trim.nvim",
    event = "User AstroFile",
    opts = {},
  },
  -- Custom snippets (vscode format)
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      -- include default astronvim config that calls the setup call
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      -- load snippets paths
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { vim.fn.stdpath "config" .. "/snippets" },
      }
    end,
  },
  -- Switch between src and test file
  -- TODO: PR #67 raised on rgroli/other.nvim
  -- {
  --   "rgroli/other.nvim",
  --   ft = { "clojure" },
  --   main = "other-nvim",
  --   opts = {
  --     mappings = { "clojure" },
  --   },
  -- },
  -- ------------------------------------------

  -- ------------------------------------------
  -- Neovim Options and Key Mappings
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      options = {
        -- configure general options: vim.opt.<key>
        opt = {
          spell = false, -- disable spell checker
          wrap = true, -- sets vim.opt.wrap
          guifont = "Sarasa Term K Nerd Font:13.5",
          -- Monoplex Nerd:h14", -- neovide font family & size
          undofile = false, -- disable persistent undo to avoid unnecessary session modifications
          formatoptions = "jql", -- disable automatic comment continuation (remove 'r' and 'o')
          -- OSC 52 clipboard support for remote/Docker environments
          clipboard = "unnamedplus", -- use system clipboard
          -- Emacs evil-mode cursor behavior equivalents
          ve = "", -- virtualedit: don't allow cursor beyond end of line (default "")
          whichwrap = "", -- don't wrap cursor at line boundaries (default "b,s")
        },
        -- configure global vim variables: vim.g
        g = {
          -- Neovim language provides - disable language integration not required
          loaded_perl_provider = 0,
          loaded_ruby_provider = 0,

          -- Disable autoformatting on save to preserve diff visibility
          autoformat_enabled = false,

          -- Leader key for Visual-Multi Cursors (Multiple Cursors)
          VM_leader = "gm", -- Visual Multi Leader (multiple cursors - user plugin)

          -- Conjure plugin overrides
          -- comment pattern for eval to comment command
          -- ["conjure#eval#comment_prefix"] = ";; ",
          -- -- Hightlight evaluated forms
          -- ["conjure#highlight#enabled"] = false,
          --
          -- -- show HUD REPL log at startup
          -- ["conjure#log#hud#enabled"] = false,
          --
          -- -- auto repl (babashka)
          -- ["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false,
          -- ["conjure#client#clojure#nrepl#connection#auto_repl#hidden"] = false,
          -- ["conjure#client#clojure#nrepl#connection#auto_repl#cmd"] = nil,
          -- ["conjure#client#clojure#nrepl#eval#auto_require"] = false,
          --
          -- -- Test runner: "clojure", "clojuresCRipt", "kaocha"
          -- ["conjure#client#clojure#nrepl#test#runner"] = "kaocha",

          -- Troubleshoot: Minimise very long lines slow down:
          -- ["conjure#log#treesitter"] = false
          -- ["conjure#log##treesitter"] = false,
          -- ["conjure#log#disable_diagnostics"] = true
        },
      },
      mappings = {
        n = {
          -- normal mode key bindings
          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,

          -- whick-key sub-menu for Visual-Multi Cursors (Multiple Cursors)
          ["gm"] = { name = "Multiple Cursors" },

          -- Toggle last open buffer
          ["<Leader><tab>"] = { "<cmd>b#<cr>", desc = "Previous tab" },

          -- navigate buffer tabs
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- snacks file explorer
          ["<Leader>E"] = { "<cmd>lua Snacks.picker.explorer()<cr>", desc = "Snacks Explorer" },

          -- Save prompting for file name
          ["<Leader>W"] = { ":write ", desc = "Save as file" },

          -- Doom Emacs style file operations
          ["<Leader>fs"] = { "<cmd>write<cr>", desc = "Save file" },
          ["<Leader>fr"] = { function() require("snacks").picker.recent() end, desc = "Recent files" },

          -- Doom Emacs style buffer operations
          ["<Leader>bd"] = { function() require("astrocore.buffer").close() end, desc = "Kill buffer" },
          ["<Leader>bD"] = { function() require("astrocore.buffer").close(0, true) end, desc = "Force kill buffer" },

          -- Tab key for matching bracket jump (like %)
          ["<Tab>"] = { "%", desc = "Jump to matching bracket" },

          -- Claude Code project management
          ["<Leader>ap"] = { function() vim.cmd "edit ~/.claude.json" end, desc = "Claude projects" },
          ["<Leader>an"] = { function() vim.cmd "terminal claude chat new" end, desc = "Claude chat new" },

          -- MCP Management
          ["<Leader>am"] = { "<cmd>MCPHub<cr>", desc = "MCP Hub" },

          -- Gist Creation
          ["<Leader>gj"] = { ":GistCreateFromFile ", desc = "Create Gist (file)" },
          ["<Leader>gJ"] = { "<cmd>GistsList<cr>", desc = "List Gist" },

          -- Neogit Status float
          ["<Leader>gf"] = { "<cmd>Neogit kind=floating<cr>", desc = "Git Status (floating)" },

          -- Toggle between src and test (Clojure pack | other-nvim)
          ["<localLeader>ts"] = { "<cmd>Other<cr>", desc = "Switch src & test" },
          ["<localLeader>tS"] = { "<cmd>OtherVSplit<cr>", desc = "Switch src & test (Split)" },

          -- Showkeys plugin (visualise key presses in Neovim window)
          ["<Leader>uk"] = { "<cmd>ShowkeysToggle<cr>", desc = "Toggle Showkeys" },

          -- consult-line equivalent (current buffer line search)
          -- ["."] = { function() require("snacks").picker.lines() end, desc = "Search lines in buffer" }, -- 동작안함
        },
        i = {
          -- insert mode key bindings
          -- ["<M-BS>"] = { "<C-w>", desc = "Delete word backward" }, -- Claude Code에서 문제 발생
        },
        t = {
          -- terminal mode key bindings
          -- ["<M-m>"] = "<C-\\><C-n>:lua require('which-key').show('SPC')<CR>",
        },
        v = {
          -- visual mode key bindings
          -- Gist Creation
          ["<Leader>gj"] = { ":GistCreate ", desc = "Create Gist (region)" },
        },
      },
    },
  },

  -- Disable session auto-saving to prevent unnecessary modifications
  {
    "stevearc/resession.nvim",
    opts = {
      autosave = {
        last = false, -- disable auto-save last session
        cwd = false, -- disable auto-save current directory session
      },
    },
  },

  -- Enhanced Tree-sitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Configuration & Data formats
        "dockerfile",
        "yaml",
        "toml",
        "json",
        "json5",
        "xml",
        "html",
        "css",
        "scss",
        "nix",
        -- Programming languages
        "javascript",
        "typescript",
        "tsx", -- jsx는 tsx에 포함됨
        "go",
        "rust",
        "java",
        "kotlin",
        "python",
        "ruby",
        "php",
        -- Shell & Tools
        "bash",
        "fish",
        "powershell",
        "regex",
        "sql",
        "graphql",
        -- Markup & Documentation
        "markdown",
        "markdown_inline",
        "rst",
        "latex",
        "bibtex",
        -- Config files
        "ini",
        "gitignore",
        "gitcommit",
        "git_rebase",
      },
      -- Disable auto-install to avoid CLI error
      auto_install = false,
    },
  },

  -- Claude Code integrations - testing both plugins

  -- Original claude-code plugin (terminal-based)
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("claude-code").setup {
        -- Terminal window settings
        window = {
          split_ratio = 0.50, -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "botright", -- Position of the window: "botright", "topleft", "vertical", "float", etc.
          enter_insert = true, -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true, -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window

          -- Floating window configuration (only applies when position = "float")
          float = {
            width = "80%", -- Width: number of columns or percentage string
            height = "80%", -- Height: number of rows or percentage string
            row = "center", -- Row position: number, "center", or percentage string
            col = "center", -- Column position: number, "center", or percentage string
            relative = "editor", -- Relative to: "editor" or "cursor"
            border = "rounded", -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
        -- File refresh settings
        refresh = {
          enable = true, -- Enable file change detection
          updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000, -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        -- Git project settings
        git = {
          use_git_root = true, -- Set CWD to git root when opening Claude Code (if in git project)
        },
        -- Shell-specific settings
        shell = {
          separator = "&&", -- Command separator used in shell commands
          pushd_cmd = "pushd", -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
          popd_cmd = "popd", -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
        },
        -- Command settings
        command = "claude", -- Command used to launch Claude Code
        -- Command variants
        command_variants = {
          -- Conversation management
          continue = "--continue", -- Resume the most recent conversation
          resume = "--resume", -- Display an interactive conversation picker

          -- Output options
          verbose = "--verbose", -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = "<C-,>", -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = "<C-,>", -- Terminal mode keymap for toggling Claude Code, false to disable
            variants = {
              continue = "<leader>aC", -- Normal mode keymap for Claude Code with continue flag
              verbose = "<leader>aV", -- Normal mode keymap for Claude Code with verbose flag
            },
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true, -- Enable scrolling keymaps (<C-f/b>) for page up/down
        },
        keys = {
          { "<leader>a", nil, desc = "AI/Claude Code" },
          { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude(greggh)" },
        },
      }
    end,
  },

  -- Advanced claude-code plugin (WebSocket-based, protocol compatible)
  -- {
  --   "coder/claudecode.nvim",
  --   dependencies = { "folke/snacks.nvim" },
  --   config = true,
  --   -- Terminal Configuration
  --   terminal = {
  --     split_side = "right", -- "left" or "right"
  --     split_width_percentage = 0.45,
  --     provider = "auto", -- "auto", "snacks", "native", "external", or custom provider table
  --     auto_close = true,
  --     snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
  --
  --     -- Provider-specific options
  --     provider_opts = {
  --       external_terminal_cmd = nil, -- Command template for external terminal provider (e.g., "alacritty -e %s")
  --     },
  --   },
  --   keys = {
  --     { "<leader>a", nil, desc = "AI/Claude Code" },
  --     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
  --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
  --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
  --     { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
  --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
  --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
  --     {
  --       "<leader>as",
  --       "<cmd>ClaudeCodeTreeAdd<cr>",
  --       desc = "Add file",
  --       ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
  --     },
  --     -- Diff management
  --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
  --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
  --   },
  -- },

  -- MCP Hub for managing MCP servers
  {
    "ravitemer/mcphub.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup {
        -- Safe mode - no auto approval
        auto_approve = false,
        -- Claude configuration path
        claude_config_path = "~/.claude.json",
        -- Global environment variables for all MCP servers
        global_env = {
          -- 환경 변수에서 가져오기 (배열 스타일)
          "DEFAULT_MINIMUM_TOKENS",
          "GITHUB_TOKEN",
          "ANTHROPIC_API_KEY",
          -- 직접 값 설정 (해시 스타일)
          PROJECT_ROOT = vim.fn.getcwd(),
          NEOVIM_CONFIG = vim.fn.stdpath "config",
        },
      }
    end,
  },
}
