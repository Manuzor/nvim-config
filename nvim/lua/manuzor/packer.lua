-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            vim.keymap.set("n", "<A-m>", function()
                require 'telescope.builtin'.lsp_document_symbols()
            end)
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'treesitter-context'.setup {
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
                trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
            }
        end
    }


    use 'mbbill/undotree'

    -- File switcher between e.g. `.h` <-> `.c`
    use {
        'derekwyatt/vim-fswitch',
        --[[
        config = function ()
            vim.keymap.set("n", "<A-o>", function()
                print("foo")
                vim.fn.FSHere()
                if true then return end

                local cur_win = vim.api.nvim_get_current_win()
                local cur_pos = vim.api.nvim_win_get_position(cur_win)

                for _, win in ipairs(vim.fn.win_findbuf(vim.api.nvim_get_current_buf())) do
                    if win ~= cur_win then
                        local pos = vim.api.nvim_win_get_position(win)
                        if pos[1] == cur_pos[1] then
                            if pos[2] > cur_pos[2] then
                                vim.fn.FSRight()
                                return
                            end
                            if pos[2] < cur_pos[2] then
                                vim.fn.FSLeft()
                                return
                            end
                        end
                    end
                end

                vim.fn.FSSplitRight()
            end)
        end,
        ]]
    }

    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- https://github.com/folke/zen-mode.nvim#%EF%B8%8F-configuration
                window = {
                    backdrop = 0.65, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
                    -- height and width can be:
                    -- * an absolute number of cells when > 1
                    -- * a percentage of the width / height of the editor when <= 1
                    -- * a function that returns the width or the height
                    width = 1,  -- width of the Zen window
                    height = 1, -- height of the Zen window
                    -- by default, no options are changed for the Zen window
                    -- uncomment any of the options below, or add other vim.wo options you want to apply
                    options = {
                        -- signcolumn = "no", -- disable signcolumn
                        -- number = false, -- disable number column
                        -- relativenumber = false, -- disable relative numbers
                        -- cursorline = false, -- disable cursorline
                        -- cursorcolumn = false, -- disable cursor column
                        -- foldcolumn = "0", -- disable fold column
                        -- list = false, -- disable whitespace characters
                    },
                },
            }
            vim.keymap.set("n", "<Tab>", function()
                require("zen-mode").toggle()
            end)
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup {
                mappings = {
                    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                    basic = false,
                    ---Extra mapping; `gco`, `gcO`, `gcA`
                    extra = false,
                },
            }
            vim.keymap.set({ "n", "x", }, "<leader>c", "gcc")
            vim.keymap.set({ "n", "x", }, "<leader>b", "gbc")
        end
    }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },   -- Required
            {
                'williamboman/mason.nvim', -- Optional
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    --
    -- Colorschemes
    --
    use {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup {
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = false,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,    -- invert background for search, diffs, statuslines and errors
                contrast = "soft", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = true,
                transparent_mode = false,
            }
            vim.cmd.colorscheme("gruvbox")
        end
    }

    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            --vim.cmd.colorscheme("rose-pine")
        end,
    }
end)
