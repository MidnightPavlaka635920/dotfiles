return {
{
    "Mofiqul/vscode.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        vim.cmd.colorscheme("vscode")
    end,
},
   { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "nvim-tree/nvim-tree.lua",
      dependencies = { "nvim-tree/nvim-web-devicons" } },

--    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" ,highlight = {enable = true,additional_vim_regex_highlighting = false,},},
      {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local ok, ts = pcall(require, "nvim-treesitter.configs")
    if not ok then return end

    ts.setup({
      highlight = {
        enable = true,
      },
      ensure_installed = { "c", "cpp", "lua" },
      auto_install = true,
    })
  end,
},
{
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
    })

    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" },
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
    local caps = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config("clangd", {
      capabilities = caps,
    })
    vim.lsp.enable("clangd")
    vim.lsp.enable("lua_ls")
  end,
},
    { "lewis6991/gitsigns.nvim" },
    {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    }
},{
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
},
{
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = {
        { name = "nvim_lsp" },
      },
    })
  end,
},{"jamessan/vim-gnupg"},{{
  "HiPhish/rainbow-delimiters.nvim",
  config = function()
    require("rainbow-delimiters.setup")
  end,
}}
}
