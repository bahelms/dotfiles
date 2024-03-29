local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format
local pack_path = fn.stdpath("data") .. "/site/pack"
-- ensure a given plugin from github.com/<user>/<repo> is cloned in the pack/packer/start directory
local function ensure(user, repo)
  local install_path = fmt("%s/packer/start/%s", pack_path, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end
ensure("wbthomason", "packer.nvim") -- ensure the plugin manager is installed

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'  -- Packer itself

  use 'tpope/vim-commentary'    -- comments
  use 'tpope/vim-fugitive'      -- Git commands
  use 'tpope/vim-projectionist' -- jump to test file
  use 'tpope/vim-repeat'        -- repeat package commands with .
  use 'tpope/vim-surround'      -- add/change wrapping pair chars
  use 'tpope/vim-vinegar'       -- file tree
  use 'ggandor/leap.nvim'       -- easymotion replacement
  use 'jiangmiao/auto-pairs'    -- auto add of closing pair char
  use 'wesQ3/vim-windowswap'    -- moved panes around as targets
  use 'lewis6991/gitsigns.nvim' -- show git changes in gutter, manage hunks
  use({
    'iamcco/markdown-preview.nvim',
    run = function() vim.fn['mkdp#util#install']() end,
  })
  use { -- fuzzy finder
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'
  use 'ThePrimeagen/harpoon'  -- quick jump to targeted files
  use 'itchyny/lightline.vim' -- status line

  -- colorschemes
  -- use { 'dracula/vim', as = 'dracula' }
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }

  -- LSP
  use { 'rafamadriz/friendly-snippets' } -- snippets
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
    }
  }

  use "folke/trouble.nvim"       -- show lsp errors in buffer
  use 'simrat39/rust-tools.nvim' -- rust lsp, etc.

  -- treesitter for syntax highlighting and more
  use 'nvim-treesitter/nvim-treesitter'

  use 'vim-test/vim-test'
  use 'vim-python/python-syntax'
end)

require('leap').add_default_mappings()
require('gitsigns').setup()
require('trouble').setup({
  icons = false,
  fold_open = "v",      -- icon used for open folds
  fold_closed = ">",    -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "error",
    warning = "warn",
    hint = "hint",
    information = "info"
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

require('rust-tools').setup({
  server = {
    -- on_attach = function(_, bufnr)
    --   -- Hover actions
    --   -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    --   -- Code action groups
    --   -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    -- end,
    settings = {
      ['rust-analyzer'] = {
        checkOnSave = {
          command = 'clippy'
        },
      }
    }
  },
  tools = {
    inlay_hints = {
      only_current_line = true
    }
  }
})

require('telescope').setup({
  pickers = {
    find_files = {
      hidden = true,
      find_command = rg,
      -- search at buffer's location, not CWD
      -- cwd = require('telescope.utils').buffer_dir()
    },
    live_grep = {
      hidden = true,
      find_command = rg,
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      -- hijack_netrw = true,
    },
  },
})
require('telescope').load_extension('file_browser')

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'cpp', 'rust', 'elixir', 'eex', 'go', 'html', 'lua', 'ruby', 'javascript', 'json', 'markdown',
    'python', 'typescript', 'yaml', 'toml' },
  sync_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }
}

require('catppuccin').setup({
  -- no_italic = false,
  -- transparent_background = true,
  flavour = "mocha",
  dim_inactive = {
    enabled = true,
    percentage = 0.0,
  },
  integrations = {
    leap = true,
    harpoon = true,
  },
  color_overrides = {
    mocha = {
      base = "#11111B", -- active pane
      -- mantle = "#000000", -- inactive pane
    },
  },
  highlight_overrides = {
    mocha = function(C)
      return {
        -- StatusLine = { bg = 'white' }, -- active
        -- StatusLineNC = { bg = 'white' }, -- inactive
        -- TabLineSel = { bg = C.pink },
        -- CmpBorder = { fg = C.surface2 },
        -- Pmenu = { bg = C.none },
        -- TelescopeBorder = { link = "FloatBorder" },
      }
    end,
  },
})

-- vim-test
vim.g['test#strategy'] = {
  nearest = 'neovim',
  file = 'neovim',
  suite = 'basic',
}
