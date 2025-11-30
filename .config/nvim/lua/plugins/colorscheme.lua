return {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({
                transparent = true
            })
            -- Load the colorscheme
            vim.cmd("colorscheme cyberdream")
        end
}
