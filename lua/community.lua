-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- ------------------------------------------
  -- Editing Support

  -- Rainbow parens
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- Multiple Cursors (leader: gm)
  { import = "astrocommunity.editing-support.vim-visual-multi" },

  -- ------------------------------------------
  -- Motion
  { import = "astrocommunity.motion.nvim-surround" },

  -- ------------------------------------------
  -- Search — project-wide search and replace
  { import = "astrocommunity.search.grug-far-nvim" },

  -- ------------------------------------------
  -- Git

  -- Diffview with neogit integration (magit-like)
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.git.neogit" },

  -- UI — noice 제거 (cmdline 팝업이 거슬림, 기본 하단 커맨드라인 사용)
}
