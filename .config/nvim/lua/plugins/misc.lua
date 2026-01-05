return {
  'tpope/vim-commentary',    -- comments
  'tpope/vim-fugitive',      -- Git commands
  'tpope/vim-projectionist', -- jump to test file
  'tpope/vim-repeat',        -- repeat package commands with .
  'tpope/vim-surround',      -- add/change wrapping pair chars
  'tpope/vim-vinegar',       -- file tree
  {                          -- auto add of closing pair char
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  { 'vim-test/vim-test' },
  { 'lewis6991/gitsigns.nvim' }, -- show git changes in gutter, manage hunks

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
  },
  -- install markdown-preview.nvim without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = ":call mkdp#util#install()",
  }

}
-- vim-test
-- vim.g['test#strategy'] = {
--   nearest = 'neovim',
--   file = 'neovim',
--   suite = 'basic',
-- }
