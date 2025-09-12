local servers = { "lua_ls", "jdtls", "ts_ls", "marksman", "bashls", "eslint", "tailwindcss", "html", "emmet_ls", "jsonls","cssls" }
local DEservers={"ts_ls","marksman","bashls","emmet_ls","tailwindcss","html","cssls","jsonls"}
vim.lsp.enable(DEservers);
vim.lsp.config("emmet_ls", {
  filetypes = { "html", "javascript","typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})
vim.lsp.config("eslint", {
  filetypes = { "html", "typescriptreact","javascript", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})
-- require("mason-lspconfig").setup({
--   automatic_enable=DEservers,
-- })
local function enable_my_lsps()
  require("mason-lspconfig").setup({
    ensure_installed = servers,
  })
  vim.lsp.enable(servers)

end

local function disable_all_lsps()
  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    client:stop()
  end
  print("All LSPs disabled for current buffer")
end

vim.keymap.set("n", "<leader>lsp", enable_my_lsps, { desc = "Enable LSPs" })
vim.keymap.set("n", "<localleader>lsp", disable_all_lsps, { desc = "Disable all LSPs" })
vim.keymap.set({ "n", "i" }, "<localleader>java", "<Cmd>!java %<Cr>");
-- vim.lsp.enable('jdtls', false)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = "󰠠 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },

})

require("luasnip.loaders.from_vscode").lazy_load()
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "javascript", "typescript", "tsx", "html", "css", "json", "markdown", "svelte", "vue", "yaml", "c", "lua", "java",
    "vim", "bash", "query", "dockerfile", "markdown_inline", "graphql", "vimdoc",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-a>",
      node_incremental = "<C-a>",
      scope_incremental = false,
      node_decremental = "<bs>",
    }
  },
})
vim.keymap.set('n', '<leader>th', ':TSBufToggle highlight<CR>', {
  desc = '[T]oggle Tree[s]itter [H]ighlight'
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = DEservers,
--   callback = function()
--     vim.treesitter.start()   -- enable Treesitter for this buffer
--   end
-- })
