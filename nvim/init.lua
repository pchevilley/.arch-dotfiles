require("config.lazy")
require('chevpa.set')
require('chevpa.remap')

vim.lsp.enable('ts_ls')

require("lazy").setup({
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"}
})
