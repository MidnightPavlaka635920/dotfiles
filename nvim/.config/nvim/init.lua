local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
vim.api.nvim_set_hl(0, "Pmenu", {
    bg = "#2D2D30",
    fg = "#D4D4D4",
})
require("nvim-tree").setup()
require("catppuccin").setup()
--vim.cmd.colorscheme("catppuccin")
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" ,"python"},
  callback = function()
    vim.treesitter.start()
  end,
})
local hl = vim.api.nvim_set_hl
-- Diagnostic text colors
hl(0, "DiagnosticError", { fg = "#E06C75" })
hl(0, "DiagnosticWarn",  { fg = "#E5C07B" })
hl(0, "DiagnosticInfo",  { fg = "#56B6C2" })
hl(0, "DiagnosticHint",  { fg = "#98C379" })

-- Floating window background (VERY important)
hl(0, "NormalFloat", { bg = "#3a3a3a" })
hl(0, "FloatBorder", { fg = "#3A3A3A", bg = "#3A3A3A" })
--hl(0, "RainbowDelimiterRed",    { fg = "#FFD700" }) -- yellow/gold
--hl(0, "RainbowDelimiterYellow", { fg = "#DA70D6" }) -- orchid/purple
--hl(0, "RainbowDelimiterBlue",   { fg = "#179FFF" }) -- blue
--hl(0, "RainbowDelimiterOrange", { fg = "#FF8C00" }) -- orange
--hl(0, "RainbowDelimiterGreen",  { fg = "#00FF00" }) -- green
--hl(0, "RainbowDelimiterViolet",       { fg = "#DA70D6" })
--hl(0, "RainbowDelimiterCyan",        { fg = "#00FFFF" })
vim.api.nvim_set_hl(0, "RainbowDelimiter1", { fg = "#FFD700" }) -- Yellow
vim.api.nvim_set_hl(0, "RainbowDelimiter2", { fg = "#DA70D6" }) -- Purple
vim.api.nvim_set_hl(0, "RainbowDelimiter3", { fg = "#179FFF" }) -- Blue

require("rainbow-delimiters.setup")({
  highlight = {
    "RainbowDelimiter1",
    "RainbowDelimiter2",
    "RainbowDelimiter3",
  },
})
vim.lsp.config("jdtls", {
    cmd = {
        "jdtls",
        "-data",
        vim.fn.stdpath("cache") .. "/jdtls-workspace",
    },
    root_markers = {
        "pom.xml",
        "build.gradle",
        ".git",
    },
})
vim.lsp.config("pyright", {})
vim.lsp.enable("pyright")
vim.lsp.enable("jdtls")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "gp", function()
    vim.lsp.buf_request(0, "textDocument/definition",
        vim.lsp.util.make_position_params(0, "utf-8"),
        function(err, result)
            if err or not result or vim.tbl_isempty(result) then
                return
            end

            vim.lsp.util.preview_location(result[1])
        end
    )
end)
--telescope
-- Telescope text
hl(0, "TelescopeResultsNormal", { fg = "#ABB2BF", bg = "#282c34" })
hl(0, "TelescopePromptNormal",  { fg = "#ABB2BF", bg = "#21252b" })
hl(0, "TelescopePreviewNormal", { fg = "#ABB2BF", bg = "#282c34" })

-- Selected item
hl(0, "TelescopeSelection", { fg = "#FFFFFF", bg = "#3E4451" })

-- Matching characters
hl(0, "TelescopeMatching", { fg = "#61AFEF", bold = true })

