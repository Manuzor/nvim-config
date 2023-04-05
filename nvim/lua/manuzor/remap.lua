
-- Set leader
vim.g.mapleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<nop>")
vim.keymap.set({ "n", "v" }, "<S-Space>", "<nop>")

-- Undo.
vim.keymap.set("n", "U", vim.cmd.redo)

-- Move selection down/up.
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Don't replace the current register with what we delete.
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- System clipboard copy/cut/paste.
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y")
vim.keymap.set({ "n", "v" }, "<leader>Y", "\"+Y")
vim.keymap.set({ "n", "v" }, "<leader>d", "\"+d")
vim.keymap.set({ "n", "v" }, "<leader>D", "\"+D")
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P")
vim.keymap.set("n", "<C-c>", "\"+Y")
vim.keymap.set("x", "<C-c>", "\"+y")
vim.keymap.set("n", "<C-x>", "\"+dd")
vim.keymap.set("x", "<C-x>", "\"+d")
vim.keymap.set("n", "<C-v>", "\"+gP")
vim.keymap.set("x", "<C-v>", "\"_d\"+p")

-- Visual block mode.
vim.keymap.set("n", "vv", "<C-v>")

-- Window navigation.
vim.keymap.set("n", "gh", function() vim.cmd.wincmd("h") end)
vim.keymap.set("n", "gj", function() vim.cmd.wincmd("j") end)
vim.keymap.set("n", "gk", function() vim.cmd.wincmd("k") end)
vim.keymap.set("n", "gl", function() vim.cmd.wincmd("l") end)

-- Window management.
vim.keymap.set("n", "gH", function() vim.cmd.wincmd("H") end)
vim.keymap.set("n", "gJ", function() vim.cmd.wincmd("J") end)
vim.keymap.set("n", "gK", function() vim.cmd.wincmd("K") end)
vim.keymap.set("n", "gL", function() vim.cmd.wincmd("L") end)

-- "Focus"
--[[ NOTE: Using zen-mode instead of this for now.
vim.keymap.set("n", "<Tab>", function()
    -- TODO: Save the currently expanded bufnr or window instead.
    if vim.b.manuzor_window_is_expanded then
        vim.cmd.wincmd("=")
    else
        vim.cmd.wincmd("|")
    end
    vim.b.manuzor_window_is_expanded = not vim.b.manuzor_window_is_expanded
end)
]]

-- Nudge the view down/up a bit.
vim.keymap.set("n", "zj", "20jzz20k")
vim.keymap.set("n", "zk", "20kzz20j")

-- Up/down by full or half page will center the cursor.
-- NOTE: This caused graphical glitches in neovide 0.10.3
if not vim.g.neovide then
    vim.keymap.set("n", "<C-u>", "<C-u>zz")
    vim.keymap.set("n", "<C-d>", "<C-d>zz")
    vim.keymap.set("n", "<PageUp>", "<PageUp>zz")
    vim.keymap.set("n", "<PageDown>", "<PageDown>zz")
end

-- Open companion file
vim.keymap.set("n", "<A-o>", function()
    -- TODO: Support */include/* and */src/*
    -- TODO: Support Unreal Public and Private directories.
    local path_without_extension = vim.fn.expand('%:p:r')
    local cur_ext = vim.fn.expand('%:e')
    print("ext is '" .. cur_ext .. "'")
    local others = nil
    if cur_ext == "h" then others = { "inl", "c", "cpp", "cc", } end
    if cur_ext == "hpp" then others = { "inl", "cpp", "cc", } end
    if cur_ext == "inl" then others = { "c", "cpp", "cc", "h", "hpp", } end
    if cur_ext == "c" then others = { "h", "inl", } end
    if cur_ext == "cpp" then others = { "h", "hpp", "hh", "inl" } end
    if cur_ext == "cc" then others = { "h", "hpp", "hh", "inl" } end

    if not others then
        print("No companion known for extension '" .. cur_ext .. "'")
        return
    end

    local path = nil
    for i, ext in pairs(others) do
        local candidate = path_without_extension .. "." .. ext
        if vim.fn.filereadable(candidate) ~= 0 then
            path = candidate
            break
        end
    end

    if path then
        print("Open companion file '" .. path .. "'")

        local cur_win = vim.api.nvim_get_current_win()
        local cur_pos = vim.api.nvim_win_get_position(cur_win)

        for _, win in ipairs(vim.fn.win_findbuf(vim.api.nvim_get_current_buf())) do
            if win ~= cur_win then
                local pos = vim.api.nvim_win_get_position(win)
                if pos[1] == cur_pos[1] then
                    if pos[2] > cur_pos[2] then
                        vim.cmd("rightbelow vsplit '" .. path .. "'")
                        return
                    end
                    if pos[2] < cur_pos[2] then
                        vim.cmd("leftbelow vsplit '" .. path .. "'")
                        return
                    end
                end
            end
        end

        -- No vertical splits exist, so create one.
        vim.cmd.vsplit(path)
    end
end)

-- Toggle alternate file
vim.keymap.set("n", "<leader><Tab>", "<C-^>")

-- Useless.
vim.keymap.set("n", "Q", "<nop>")

