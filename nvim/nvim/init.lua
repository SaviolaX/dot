local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "🔥",
            [vim.diagnostic.severity.WARN]  = "❗️",
            [vim.diagnostic.severity.INFO]  = "✨",
            [vim.diagnostic.severity.HINT]  = "💡",
        },
    },
})

vim.o.updatetime = 250

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end
})

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvvm:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})

        vim.fn.getchar()
        os.exit(1)
    end
end


vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("vim-options")
require("lazy").setup("plugins")
