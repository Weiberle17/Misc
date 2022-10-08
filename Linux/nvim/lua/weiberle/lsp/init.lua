local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "weiberle.lsp.configs"
require("weiberle.lsp.handlers").setup()
require "weiberle.lsp.null-ls"
