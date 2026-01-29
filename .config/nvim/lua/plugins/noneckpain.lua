return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function ()
        require("no-neck-pain").setup({
            width = 130,
        })
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function ()
                vim.cmd("NoNeckPain")
            end,
        })
    end,
}
