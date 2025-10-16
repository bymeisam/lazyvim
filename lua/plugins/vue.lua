-- ~/.config/nvim/lua/plugins/vue.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable vue_ls completely
        vue_ls = false,

        -- Configure Volar in HYBRID mode
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              hybridMode = true, -- Changed to true!
            },
          },
        },

        -- Configure VTSLS to support Vue WITH the TypeScript plugin
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue", -- Add vue back!
          },
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 8192,
              },
            },
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data")
                      .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
