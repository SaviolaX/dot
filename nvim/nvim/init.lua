local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- vim.fn.sign_define("DiagnosticSignError", { text = "🔥", texthl = "DiagnosticError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "❗️", texthl = "DiagnosticWarn" })
-- vim.fn.sign_define("DiagnosticSignInfo", { text = "✨ ", texthl = "DiagnosticInfo" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "💡", texthl = "DiagnosticHint" })

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
