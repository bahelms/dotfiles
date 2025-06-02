vim.opt.background = dark
vim.g.lightline = {
  colorscheme = 'catppuccin',
  active = {
    left = { { 'mode', 'paste' }, { 'relativepath', 'readonly', 'modified' } },
    right = { { 'gitbranch', 'percent', 'fileencoding', 'filetype', 'lineinfo' } }
  },
  component_function = {
    gitbranch = 'FugitiveHead'
  }
}
vim.cmd.colorscheme('catppuccin')
vim.opt.colorcolumn = '80'
-- vim.cmd.highlight('Search', 'guibg=#d665cf')
vim.cmd.highlight('ColorColumn', 'ctermbg=235 guibg=#33334d')
