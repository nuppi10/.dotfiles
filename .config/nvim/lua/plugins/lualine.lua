return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "tokyonight", -- NOT auto
        component_separators = { left = "│", right = "│" },
        section_separators = "",
        globalstatus = false,
      },

      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },

      inactive_sections = {
        lualine_c = { "filename" },
        lualine_x = { "location" },
      },
    })

    -- Force transparency
    local hl = vim.api.nvim_set_hl
    local groups = {
      "lualine_a_normal",
      "lualine_b_normal",
      "lualine_c_normal",
      "lualine_x_normal",
      "lualine_y_normal",
      "lualine_z_normal",
      "lualine_a_inactive",
      "lualine_b_inactive",
      "lualine_c_inactive",
      "lualine_x_inactive",
      "lualine_y_inactive",
      "lualine_z_inactive",
    }

    for _, group in ipairs(groups) do
      hl(0, group, { bg = "none" })
    end
  end,
}

