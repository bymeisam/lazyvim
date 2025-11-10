-- ~/.config/nvim/lua/config/go.lua
-- ONE FILE = FULL Go auto-import experience (instant + on-save)

-- 1. Enable Go extra (gopls, goimports, gofumpt)
vim.schedule(function()
  table.insert(require("lazy").opts().spec or {}, { import = "lazyvim.plugins.extras.lang.go" })
end)

-- 2. Organize imports on every save (guaranteed cleanup)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
        end
      end
    end
  end,
})

-- 3. THIS IS THE PART THAT MUST BE RETURNED
return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },
  opts = function(_, opts)
    local cmp = require("cmp")

    -- Magic mapping: Tab confirms and auto-imports instantly
    opts.mapping = vim.tbl_deep_extend("force", opts.mapping or {}, {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          end
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<CR>"] = cmp.mapping.confirm({ select = false }),
    })

    -- Ensure LSP can resolve additional data (needed for auto-import)
    opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

    return opts
  end,
}
