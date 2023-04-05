function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- command mode
function cmap(shortcut, command)
  map('c', shortcut, command)
end

nmap("K", "i<cr><esc>") -- fast return
nmap("H", "^")
nmap("L", "$")

-- end of line in insert mode
imap("<c-e>", "<esc>A")

-- window nav for Dvorak
nmap("<c-h>", "<c-w><c-h>")
nmap("<c-k>", "<c-w><c-k>")
nmap("<c-j>", "<c-w><c-j>")
nmap("<c-l>", "<c-w><c-l>")

-- search stays in middle
nmap("n", "nzzzv")
nmap("N", "Nzzzv")

-- inline find commands
nmap("z", "m")
nmap("M", ",")
nmap("m", ";")
vmap("M", ",")
vmap("m", ";")

-- nmap(";", ":")
-- vmap(";", ":")

-- Leader shortcuts
nmap("<leader>a", ":wa<cr>")
nmap("<leader>x", ":xa<cr>")
nmap("<leader>q", ":q!<cr>")
nmap("<leader><bs>", ":wa<cr>")
nmap("<leader>v", "<c-w>v")
nmap("<leader>l", "<c-w>s")
nmap("<leader>h", ":noh<cr>")
nmap("<leader>b", ":Telescope file_browser<cr>")
nmap("<leader>'", ":Trouble<cr>")
vmap("<leader>p", "\"0p")

-- home and end line in command mode
cmap('<c-a>', '<home>')
cmap('<c-e>', '<end>')

-- terminal
nmap("<leader>st", ":sp term://zsh<cr>")
tmap("<esc>", "<c-\\><c-n>")
tmap("<c-v><esc>", "<esc>")

-- vim-projectionist
nmap("<leader>tt", ":A<cr>")
nmap("<leader>tv", ":AV<cr>")

-- telescope
nmap("<leader>i", ":Telescope find_files<cr>")
nmap("<leader>u", ":Telescope grep_string<cr>")
nmap("\\", ":Telescope live_grep<cr>")

-- vim-test
nmap("<leader>tn", ":TestNearest<cr>")
nmap("<leader>tf", ":TestFile<cr>")
nmap("<leader>ts", ":TestSuite<cr>")
nmap("<leader>tl", ":TestLast<cr>")
