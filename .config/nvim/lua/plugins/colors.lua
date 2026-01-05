vim.opt.colorcolumn = '80'

local function set_main_colors()
  local fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).fg
  vim.api.nvim_set_hl(0, "Normal", { bg = "#141212", fg = fg })
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
      set_main_colors()
    end
  },

  -- status line
  {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = {
        colorscheme = 'catppuccin',
        active = {
          left = { { 'mode', 'paste' }, { 'relativepath', 'readonly', 'modified' } },
          right = { { 'lineinfo' } }
        },
        component_function = {
          gitbranch = 'FugitiveHead'
        }
      }
    end
  },

}
