vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("TEMP") .. "/neovim_undodir"
vim.opt.undofile = true

vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 3
vim.opt.signcolumn = "yes"

-- Open new vsplits to the right by default.
vim.opt.splitright = true

if vim.g.neovide then
    vim.o.guifont = "Comic Code:h10,IBM Plex Mono:h10"
end

require("manuzor.remap")
require("manuzor.packer")

-- Set formatoptions. Needs to be done in an augroup.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = vim.api.nvim_create_augroup("manuzor_fixup_formatoptions", {}),
    callback = function()
        -- See: :help fo-table
        -- Note: "q" may conflict with LSP, see: https://vi.stackexchange.com/questions/39200/wrapping-comment-in-visual-mode-not-working-with-gq
        vim.opt.formatoptions = "jcqlpr/"
    end
})

-- See: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
    vim.opt.foldenable     = false
  end
})
---ENDWORKAROUND

