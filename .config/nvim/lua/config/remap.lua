
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Remaps

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Undotree
vim.keymap.set("n", "<leader>pu", vim.cmd.UndotreeToggle)

-- LspSaga

vim.keymap.set("n", "<leader>ga", "<cmd>Lspsaga peek_definition<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { noremap = true, silent = true })


-- Harpoon

local harpoon = require("harpoon")

harpoon:setup()


vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
