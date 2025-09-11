vim.opt.completeopt = { "menuone", "noselect", "popup" }

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

-- Monorepo root so TS can see across packages
local function monorepo_root(fname)
  return util.root_pattern(
    "pnpm-workspace.yaml",
    "turbo.json",
    "nx.json",
    "lerna.json",
    "rush.json"
  )(fname) or util.find_git_ancestor(fname)
end

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Keymaps (include implementation)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- <— add this
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  vim.keymap.set("n", "<leader>vd",  vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

  -- Optional: your completion wiring; wrap in pcall to avoid errors if not available
  pcall(function()
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item) return { abbr = item.label:gsub("%b()", "") } end,
    })
    vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { buffer = bufnr, desc = "trigger autocompletion" })
  end)
end

-- ONE definitive setup (delete any other ts_ls.setup calls)
lspconfig.ts_ls.setup({
  root_dir = monorepo_root,
  single_file_support = false,
  on_attach = on_attach,
  init_options = {
    preferences = {
      -- prefer real source over .d.ts when jumping
      preferGoToSourceDefinition = true,
    },
  },
})

vim.diagnostic.config({ virtual_text = true })

