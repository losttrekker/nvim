local M = {}

local navic = require("nvim-navic")

local function on_attach(client, bufnr)
  navic.attach(client, bufnr)
end

function M.setup()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "use" },
        },
      },
    },
  })

  -- Rust and clangd are setup in their respective files in plugins/
  lspconfig.cmake.setup({ capabilities = capabilities })
  lspconfig.dockerls.setup({ capabilities = capabilities, on_attach = on_attach })
  lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
  lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
end

return M
