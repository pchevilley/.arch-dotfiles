require("config.lazy")
require('chevpa.set')
require('chevpa.remap')

vim.lsp.enable('ts_ls')
vim.o.signcolumn = "no"

function _G.toggle_signcolumn()
    if vim.o.signcolumn == "no" then
        vim.o.signcolumn = "yes"
    else
        vim.o.signcolumn = "no"
    end
end

vim.api.nvim_set_keymap('n', '<leader>gh', ':lua toggle_signcolumn()<CR>', { noremap = true, silent = true })

require("lazy").setup({
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}
})
require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
