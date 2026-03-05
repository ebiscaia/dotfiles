require("eddie.options")
require("eddie.keybindings")
require("eddie.packages")
require("eddie.icons")
require("eddie.colorscheme")

-- indent-blankline
require("ibl").setup({
    scope = {
        enabled = true,
        highlight = { "Identifier" },
    },
    indent = { char = "│" },
})

-- lualine | status line
require("lualine").setup({
    options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
    },
    always_divide_middle = true,

    sections = {
        lualine_a = { "mode" },
        lualine_b = {
            { "branch", icon = { "" } },
            "diagnostics",
            {
                "diff",
                symbols = {
                    added = " ",
                    removed = " ",
                    modified = " ",
                },
            },
        },
        lualine_c = {
            {
                "filetype",
                colored = true, -- Displays filetype icon in color if set to true
                icon_only = true, -- Display only an icon for filetype
            },
            {
                "filename",
                symbols = {
                    modified = " ",
                    readonly = " ",
                    unnamed = " ",
                    newfile = " ",
                },
                newfile_status = true,
            },
        },
        lualine_x = {
            {
                "fileformat",
                symbols = { unix = "" },
                color = { fg = "#458488" },
            },
            {
                "lsp_status",
                symbols = { done = "" },
                icon = "󰒋",
            },
            { "encoding" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
})

-- AutoPairs
require("autoclose").setup({
    keys = {
        ["("] = { escape = false, close = true, pair = "()" },
        ["["] = { escape = false, close = true, pair = "[]" },
        ["{"] = { escape = false, close = true, pair = "{}" },

        [">"] = { escape = true, close = false, pair = "<>" },
        [")"] = { escape = true, close = false, pair = "()" },
        ["]"] = { escape = true, close = false, pair = "[]" },
        ["}"] = { escape = true, close = false, pair = "{}" },

        ['"'] = { escape = true, close = true, pair = '""' },
        ["'"] = { escape = true, close = true, pair = "''" },
        ["`"] = { escape = true, close = true, pair = "``" },
    },
    options = {
        disabled_filetypes = { "text" },
        disable_when_touch = false,
        touch_regex = "[%w(%[{]",
        pair_spaces = false,
        auto_indent = true,
        disable_command_mode = false,
    },
})

-- Project.nvim (helps FzfLua to search in the "workspace" main folder)
require("project_nvim").setup()

-- FzfLua
require("fzf-lua").setup({
    "ivy",
    grep = {
        hidden = true,
    },
    winopts = {
        preview = {
            winopts = {
                number = false,
            },
        },
        on_create = function()
            -- called once upon creation of the fzf main window
            -- can be used to add custom fzf-lua mappings, e.g:
            vim.keymap.set(
                "t",
                "<C-j>",
                "<Down>",
                { silent = true, buffer = true }
            )
            vim.keymap.set(
                "t",
                "<C-k>",
                "<Up>",
                { silent = true, buffer = true }
            )
        end,
    },
})

-- FZFLua keybindings
-- Files and buffers
vim.keymap.set(
    "n",
    "<leader>ff",
    ":FzfLua files<CR>",
    { desc = "Use fzf for file searching" }
)
vim.keymap.set(
    "n",
    "<leader>fc",
    ':FzfLua live_grep cwd=vim.fn.stdpath("config")<CR>',
    { desc = "Use fzf to search in config folder for text using ripgrep" }
)
vim.keymap.set(
    "n",
    "<leader>fg",
    ":FzfLua live_grep<CR>",
    { desc = "Use fzf to search for text using ripgrep" }
)
vim.keymap.set(
    "n",
    "<leader>fr",
    ":FzfLua oldfiles<CR>",
    { desc = "Use fzf to search recent files" }
)
vim.keymap.set(
    "n",
    "<leader>fb",
    ":FzfLua buffers<CR>",
    { desc = "Use fzf to change buffers" }
)
vim.keymap.set(
    "n",
    "<leader>fs",
    "<cmd>Telescope spell_suggest<CR>",
    { desc = "Spelling Suggestions" }
)

-- lsp
vim.keymap.set(
    "n",
    "<leader>fd",
    ":FzfLua diagnostics_document<CR>",
    { desc = "Use fzf to cicle document diagnostic" }
)
vim.keymap.set(
    "n",
    "<leader>fD",
    ":FzfLua diagnostics_workspace<CR>",
    { desc = "Use fzf to cicle workspace diagnostic" }
)

vim.keymap.set(
    "n",
    "<leader>fa",
    ":FzfLua lsp_code_action<CR>",
    { desc = "Use fzf to search for code actions" }
)
vim.keymap.set(
    "n",
    "<leader>fq",
    ":FzfLua quickfix<CR>",
    { desc = "Use fzf for quick fixes" }
)

-- git
vim.keymap.set(
    "n",
    "<leader>ft",
    ":FzfLua git_files<CR>",
    { desc = "Use fzf to search for git files" }
)

-- Toggleterm
require("toggleterm").setup({
    size = 15,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 50,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    -- shell = "/bin/zsh",
    float_opts = {
        border = "curved",
        winblend = 0,
        -- highlights = {
        --   border = "Normal",
        --   background = "Normal",
        -- },
        -- highlights = highlights,
    },
})

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "jj", [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- Git and Github
require("gitsigns")
require("git-conflict").setup({
    default_mappings = true, -- disable buffer local mapping created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    highlights = {
        -- They must have background color, otherwise the default color will be used
        incoming = "DiffText",
        current = "DiffAdd",
    },
})

-- Git-conflict keybindings
vim.keymap.set(
    "n",
    "<leader>Go",
    ":GitConflictChooseOurs<CR>",
    { desc = "Choose Ours" }
)
vim.keymap.set(
    "n",
    "<leader>Gt",
    ":GitConflictChooseTheirs<CR>",
    { desc = "Choose Theirs" }
)
vim.keymap.set(
    "n",
    "<leader>Gb",
    ":GitConflictChooseBoth<CR>",
    { desc = "Choose Both" }
)
vim.keymap.set(
    "n",
    "<leader>GB",
    ":GitConflictChooseNone<CR>",
    { desc = "Choose None" }
)
vim.keymap.set(
    "n",
    "<leader>Gn",
    ":GitConflictNextConflict<CR>",
    { desc = "Next Conflict" }
)
vim.keymap.set(
    "n",
    "<leader>GN",
    ":GitConflictPreviousConflict<CR>",
    { desc = "Previous Conflict" }
)
vim.keymap.set("n", "<leader>Gf", ":GitConflictQf<CR>", { desc = "Quick Fix" })

require("diffview").setup({
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    git_cmd = { "git" }, -- The git executable followed by default args.
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
    },
    signs = {
        fold_closed = "",
        fold_open = "",
    },
    file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
            flatten_dirs = true, -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = { -- See ':h diffview-config-win_config'
            position = "left",
            width = 35,
        },
    },
    file_history_panel = {
        log_options = { -- See ':h diffview-config-log_options'
            git = {
                single_file = {
                    diff_merges = "combined",
                },
                multi_file = {
                    diff_merges = "first-parent",
                },
            },
        },
        win_config = { -- See ':h diffview-config-win_config'
            position = "bottom",
            height = 16,
        },
    },
    commit_log_panel = {
        win_config = {}, -- See ':h diffview-config-win_config'
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
})

--require("neogit")

require("neogit").setup({
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = false,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    -- Change the default way of opening neogit
    kind = "replace",
    -- Change the default way of opening the commit popup
    commit_popup = {
        kind = "split",
    },
    -- Change the default way of opening popups
    popup = {
        kind = "split",
    },
    -- customize displayed signs
    signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
    },
    integrations = {
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
        -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
        --
        -- Requires you to have `sindrets/diffview.nvim` installed.
        --    use {
        --      'TimUntersberger/neogit',
        --      requires = {
        --        'nvim-lua/plenary.nvim',
        --        'sindrets/diffview.nvim'
        --      }
        --    },
        --
        diffview = true,
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
        untracked = {
            folded = false,
            hidden = false,
        },
        unstaged = {
            folded = false,
            hidden = false,
        },
        staged = {
            folded = false,
            hidden = false,
        },
        stashes = {
            folded = true,
            hidden = false,
        },
        unpulled = {
            folded = true,
            hidden = false,
        },
        unmerged = {
            folded = false,
            hidden = false,
        },
        recent = {
            hidden = false,
            folded = true,
        },
    },
})

-- Neogit keybindings
vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Neogit" })
vim.keymap.set(
    "n",
    "<leader>gn",
    ":Gitsigns next_hunk<CR>",
    { desc = "Go to next hunk" }
)
vim.keymap.set(
    "n",
    "<leader>gN",
    ":Gitsigns previous_hunk<CR>",
    { desc = "Go to previous hunk" }
)
vim.keymap.set(
    "n",
    "<leader>gb",
    ":Gitsigns toggle_current_line_blame<CR>",
    { desc = "Toggle line blame" }
)
vim.keymap.set(
    "n",
    "<leader>gp",
    ":Gitsigns previous_hunk<CR>",
    { desc = "Preview hunk" }
)

-- LSP, formatting and linting
-- mason, mason-lsp-config and mason-tool-installer
require("mason").setup({
    ui = {
        border = "rounded",
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pylsp" },
    automatic_enable = true,
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "black",
        "prettier",
        "stylua",
        "luacheck",
        "golangci-lint",
        "eslint",
        "htmlhint",
        "stylelint",
        "yamllint",
        "jsonlint",
    },
})

require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        go = { "gofmt" },
        javascript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        yaml = { "prettier" },
        json = { "prettier" },
    },
    -- Formatters setup
    formatters = {
        black = {
            append_args = { "--line-length", "80" },
        },
        stylua = {
            append_args = {
                "--column-width",
                "80",
                "--indent-type",
                "spaces",
                "--indent-width",
                "4",
            },
        },
        prettier = {
            append_args = {},
        },
    },
    -- Format on save (don't use lsp as fallback)
    format_on_save = {
        -- I recommend these options. See :help conform.format for details.
        lsp_format = "never",
        async = false,
        timeout_ms = 250,
    },
})

require("lint").linters_by_ft = {
    lua = { "luacheck" },
    -- python = { "" },  -- pylsp comes with linter out of the box
    go = { "golangcilint" },
    javascript = { "eslint" },
    html = { "htmlhint" },
    css = { "stylelint" },
    yaml = { "yamllint" },
    json = { "jsonlint" },

    -- Linters setup
    -- linters = {
    --     black = {
    --         append_args = { "--line-length", "80" },
    --     },
    --     stylua = {
    --         append_args = {
    --             "--column-width",
    --             "80",
    --             "--indent-type",
    --             "spaces",
    --         },
    --     },
    --     prettier = {
    --         append_args = {},
    --     },
    -- },
}

-- Snippets and completion
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
    signature = { enabled = true },
    fuzzy = { implementation = "lua" },
    appearance = {
        nerd_font_variant = "mono",
    },
    keymap = {
        preset = "enter",
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
    },
    snippets = { preset = "luasnip" },
    sources = {
        default = { "lsp", "snippets", "path", "buffer" },
    },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 100 },
        menu = {
            auto_show = true,
            draw = {
                treesitter = { "lsp" },
                columns = {
                    { "kind_icon", "label", "label_description", gap = 2 },
                    { "kind" },
                },
            },
        },
    },
})

-- lsp configs
vim.lsp.config["lua_ls"] = {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "it", "describe", "before_each", "are" },
            },
        },
    },
}

vim.lsp.config["pylsp"] = {
    settings = {
        pylsp = {
            plugins = {
                black = { enabled = true, line_lenght = 80 },
                pycodestyle = {
                    maxLineLenght = 80,
                },
            },
        },
    },
}

-- lsp keybindings
local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", vim.lsp.buf.references, opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definition"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", vim.lsp.buf.implementation, opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ga", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lp", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, opts) -- jump to previous diagnostic in buffer
        --
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>ln", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end,
})

-- lsp diagnostic symbols
local severity = vim.diagnostic.severity
vim.diagnostic.config({
    severity_sort = true,
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
    },
})

-- vim.lsp.enable({ "pylsp", "lua_ls" })

-- Treesitter
local parsers_to_install = {
    "lua",
    "python",
    "awk",
    "bash",
    "bibtex",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "csv",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "javascript",
    "jq",
    "json",
    "json5",
    "kitty",
    "latex",
    "luadoc",
    "markdown",
    "markdown_inline",
    "muttrc",
    "nginx",
    "passwd",
    "printf",
    "regex",
    "tmux",
    "toml",
    "xml",
    "yaml",
    "zathurarc",
    "zig",
    "zsh",
}

local target_parsers = {}
for _, lang in ipairs(parsers_to_install) do
    target_parsers[lang] = true
end

vim.api.nvim_create_autocmd("FileType", {
    desc = "Treesitter: Auto-install and Enable Highlighting",
    callback = function()
        local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
            or vim.bo.filetype
        local ts = require("nvim-treesitter")

        -- 1. Check if we want to auto-install this language
        if target_parsers[lang] then
            -- 2. Check if the parser is already installed
            -- We check the list of installed parsers provided by the plugin
            local installed = ts.get_installed()
            local is_installed = false
            for _, p in ipairs(installed) do
                if p == lang then
                    is_installed = true
                    break
                end
            end

            if not is_installed then
                vim.notify(
                    "Treesitter: Installing parser for " .. lang,
                    vim.log.levels.INFO
                )
                ts.install(lang)
                return -- Exit and wait for installation
            end
        end

        -- 3. Enable highlighting
        pcall(vim.treesitter.start, 0, lang)
    end,
})

-- Dap
local dap = require("dap")

vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DiagnosticSignError", numbhl = "", linehl = "" }
)
vim.fn.sign_define(
    "DapStopped",
    { text = "󰄾", texthl = "DiagnosticSignHint", numbhl = "", linehl = "" }
)

vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<F6>", ":lua require'dap'.terminate()<CR>")
vim.keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set(
    "n",
    "<leader>B",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
)
vim.keymap.set(
    "v",
    "<leader>B",
    ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
)
vim.keymap.set(
    "n",
    "<leader>lp",
    ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
)
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")

require("nvim-dap-virtual-text").setup()

local dapui = require("dapui")

dap.listeners.before.event_initialized["dapui_config"] = function()
    vim.cmd(":w")
end

dap.listeners.after.event_initialized["dapui_config"] = function()
    vim.cmd("NvimTreeClose")
    vim.cmd("ToggleTermToggleAll!")
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
                "stacks",
                "breakpoints",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                --"repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "console",
        icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "",
            terminate = "",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
})

vim.api.nvim_create_autocmd("PackChanged", {
    group = vim.api.nvim_create_augroup("TSAutoUpdate", { clear = true }),
    callback = function(ev)
        -- Check if the change was an installation or an update
        local is_sync = ev.data.kind == "update" or ev.data.kind == "install"

        -- Check if the plugin being changed is nvim-treesitter
        -- We use string.find in case the name is a full URL or a short path
        if is_sync and ev.data.spec.name:find("nvim-treesitter") then
            vim.schedule(function()
                vim.notify(
                    "Treesitter: Plugin updated, running :TSUpdate...",
                    vim.log.levels.INFO
                )
                vim.cmd("TSUpdate")
            end)
        end
    end,
})

-- Autocommands
local atcmd = vim.api.nvim_create_autocmd
local execGroup = vim.api.nvim_create_augroup("execGroup", { clear = true })
local changeFType = vim.api.nvim_create_augroup("changeFType", { clear = true })
local specialIndent =
    vim.api.nvim_create_augroup("specialIndent", { clear = true })
local specialLLength =
    vim.api.nvim_create_augroup("specialLLength", { clear = true })
local quickFix = vim.api.nvim_create_augroup("quickFix", { clear = true })
local checkFix = vim.api.nvim_create_augroup("checkFix", { clear = true })
local format = vim.api.nvim_create_augroup("format", { clear = true })

-- Keybindings related variables
local opts = { noremap = true, silent = true }
-- local keymap = vim.api.nvim_set_keymap

atcmd("FileType", {
    pattern = { "python" },
    callback = function()
        keymap(
            "n",
            "<F4>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; python3 %'<cr>",
            opts
        )
        keymap(
            "i",
            "<F4>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; python3 %'<cr>",
            opts
        )
        keymap(
            "i",
            "<F3>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; pypy3 %'<cr>",
            opts
        )
        keymap(
            "i",
            "<F3>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; pypy3 %'<cr>",
            opts
        )
    end,
    group = execGroup,
})

atcmd("FileType", {
    pattern = { "cpp" },
    callback = function()
        keymap(
            "n",
            "<F4>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; rm -r ./main.exe; g++ -std=c++20 -g ./*.cpp -o ./main.exe && ./main.exe'<CR>",
            opts
        )
        keymap(
            "n",
            "<F4>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; rm -r ./main.exe; g++ -std=c++20 -g ./*.cpp -o ./main.exe && ./main.exe'<CR>",
            opts
        )
        keymap(
            "i",
            "<F3>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; rm -r ./main.exe; g++ -std=c++20 -g ./*.cpp -o ./main.exe -lGLU -lGL -lglut && ./main.exe'<CR>",
            opts
        )
        keymap(
            "i",
            "<F3>",
            "<Esc>:w<CR>:TermExec cmd='clear; clear; rm -r ./main.exe; g++ -std=c++20 -g ./*.cpp -o ./main.exe -lGLU -lGL -lglut && ./main.exe'<CR>",
            opts
        )
    end,
    group = execGroup,
})

atcmd("FileType", {
    pattern = { "mail" },
    callback = function()
        vim.opt.filetype = "text"
    end,
    group = changeFType,
})

atcmd("FileType", {
    pattern = {
        "html",
        "css",
        "javascript",
        "yaml",
        "vue",
        "json",
        "htmldjango",
    },
    callback = function()
        vim.opt.shiftwidth = 2 -- size of an indent
        vim.opt.tabstop = 2 -- Tab to move by 4 characters
        vim.opt.softtabstop = 2 -- Backspace to remove 4 white spaces at once
    end,
    group = specialIndent,
})

atcmd("FileType", {
    pattern = { "yaml" },
    callback = function()
        vim.opt.textwidth = 150 -- line length
    end,
    group = specialLLength,
})
