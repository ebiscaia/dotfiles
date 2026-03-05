require("gruvbox").setup({
    overrides = {
        ["@string"] = { fg = "#ebdbb2", italic = true },
        Pmenu = { link = "Normal" },
        NormalFloat = { link = "Normal" },
        NormalNC = { bg = "#32302f" },
        GitSignsAdd = { fg = "#83a598" },
        GitSignsChange = { fg = "#fabd2f" },
    },
    dim_inactive = true,
    transparent_mode = true,
})

vim.cmd("colorscheme gruvbox")
