local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>t", mark.add_file)
vim.keymap.set("n", "<c-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<c-p>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<c-y>", function() ui.nav_file(2) end)
