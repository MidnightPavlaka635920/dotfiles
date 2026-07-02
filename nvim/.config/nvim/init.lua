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
  pattern = { "c", "cpp" },
  callback = function()
    vim.treesitter.start()
  end,
})
