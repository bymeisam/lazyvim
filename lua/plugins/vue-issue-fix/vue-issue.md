# Vue + TypeScript Setup in LazyVim - Complete Guide

## The Problem

Setting up Vue.js with TypeScript in LazyVim presents several interconnected challenges that can take weeks to debug:

### Issues Encountered

1. **Infinite Loop Error**: `tsconfig.app.json` continuously reinitializing
2. **Duplicate LSP Servers**: Both `volar` and `vue_ls` running simultaneously (they're the same server)
3. **Missing TypeScript Integration**: Error message "Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`"
4. **Broken Go-to-Definition**: `gd` command not working in Vue files
5. **TypeScript Features Not Working**: No type checking or IntelliSense in `<script setup lang="ts">` blocks

### Root Causes

The confusion stems from:

- **Multiple overlapping LSP servers** that can handle Vue files differently
- **Hybrid mode** vs **take-over mode** - unclear documentation
- **Hidden dependencies** - Vue TypeScript plugin location not obvious
- **Conflicting configurations** - LazyVim defaults clashing with custom configs
- **Poor error messages** that don't indicate the actual solution

---

## Understanding the Architecture

### What Each LSP Server Does

| Server          | Purpose                                                                      | Files                        |
| --------------- | ---------------------------------------------------------------------------- | ---------------------------- |
| **volar**       | Vue language server - handles templates, scripts, and styles in `.vue` files | `.vue`                       |
| **vtsls**       | TypeScript/JavaScript language server - provides TS/JS intelligence          | `.ts`, `.tsx`, `.js`, `.jsx` |
| **vue_ls**      | Old name for volar - SAME SERVER, causes duplicates                          | `.vue`                       |
| **eslint**      | Linting for JS/TS/Vue                                                        | `.vue`, `.ts`, `.js`         |
| **tailwindcss** | Tailwind CSS IntelliSense                                                    | `.vue`, `.html`, `.css`      |

### Two Modes of Operation

**Hybrid Mode** (Recommended):

- Volar handles Vue templates and component structure
- VTSLS handles TypeScript in `<script>` blocks via a plugin
- Best performance and compatibility

**Take-Over Mode**:

- Volar handles everything (templates + TypeScript)
- Simpler but can be slower
- May have compatibility issues

---

## The Solution

### Step 1: Enable LazyVim Extras

Open Neovim and run:

```vim
:LazyExtras
```

Enable these extras (press `x` to toggle):

- ✅ `lang.typescript`
- ✅ `lang.vue`
- ✅ `formatting.prettier` (optional but recommended)

### Step 2: Install Mason Packages

Run `:Mason` and install:

- `volar` - Vue language server
- `vue-language-server` - Contains the TypeScript plugin
- `vtsls` - TypeScript language server
- `prettier` - Code formatter
- `eslint-lsp` - ESLint support

### Step 3: Install Treesitter Parsers

```vim
:TSInstall vue css scss html javascript typescript
```

### Step 4: Configure LSP Servers

Create `~/.config/nvim/lua/plugins/vue.lua`:

```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable vue_ls to prevent duplicates
        vue_ls = false,

        -- Configure Volar in hybrid mode
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = {
              hybridMode = true, -- Key setting!
            },
          },
        },

        -- Configure VTSLS to support Vue files with TypeScript plugin
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue", -- Include vue files
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
                    location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
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
```

### Step 5: Add Vue Type Declarations

Create `env.d.ts` in your project root or `src/` folder:

```typescript
/// <reference types="vite/client" />

declare module "*.vue" {
  import type { DefineComponent } from "vue";
  const component: DefineComponent<{}, {}, any>;
  export default component;
}
```

### Step 6: Update TypeScript Config

Ensure your `tsconfig.json` includes:

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "jsx": "preserve",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "strict": true
  },
  "include": ["src/**/*", "src/**/*.vue", "env.d.ts"],
  "exclude": ["node_modules", "dist"]
}
```

### Step 7: Restart and Verify

1. Close Neovim completely
2. Reopen Neovim
3. Open a `.vue` file
4. Run `:LspInfo`

Expected output:

```
Active Clients:
- volar (id: 1)       ← Vue templates and structure
- vtsls (id: 2)       ← TypeScript in <script> blocks
- eslint (id: 3)      ← Linting
- tailwindcss (id: 4) ← CSS IntelliSense
```

---

## Testing Your Setup

### In a `.vue` file:

```vue
<template>
  <div>{{ message }}</div>
</template>

<script setup lang="ts">
import { ref } from "vue";

const message = ref<string>("Hello Vue!");
</script>

<style scoped>
div {
  color: blue;
}
</style>
```

Test these features:

- ✅ Type `ref` and press `Ctrl+Space` → Should show Vue completions
- ✅ Hover over `ref` with `K` → Should show documentation
- ✅ Press `gd` on `ref` → Should jump to Vue type definition
- ✅ Format with `<leader>cf` → Should run Prettier
- ✅ Get type errors for incorrect types

### In a `.ts` file:

- ✅ Full TypeScript IntelliSense
- ✅ Import auto-completion
- ✅ Type checking
- ✅ Go to definition

---

## Key Configuration Principles

### Why This Works

1. **`hybridMode: true`** tells Volar to delegate TypeScript handling to vtsls
2. **VTSLS handles both `.ts` AND `.vue` files** with the Vue TypeScript plugin
3. **Vue TypeScript plugin** bridges vtsls and Vue components
4. **`vue_ls = false`** prevents duplicate servers running
5. **Proper filetypes** ensure each server only handles appropriate files

### What Each Setting Does

| Setting                            | Purpose                                            |
| ---------------------------------- | -------------------------------------------------- |
| `hybridMode: true`                 | Volar delegates TS to vtsls instead of handling it |
| `vtsls.filetypes` includes `"vue"` | Allows vtsls to provide TS features in Vue files   |
| `globalPlugins` with Vue plugin    | Teaches vtsls how to understand Vue components     |
| `vue_ls = false`                   | Prevents duplicate volar instances                 |

---

## Troubleshooting

### Issue: "Could not find ts_ls/vtsls"

**Cause**: Volar in non-hybrid mode expects a TypeScript server but can't find one.

**Fix**: Set `hybridMode: true` and ensure vtsls includes `"vue"` in filetypes.

### Issue: Infinite tsconfig.app.json loop

**Cause**: Multiple servers trying to reload TypeScript config simultaneously.

**Fix**:

- Use hybrid mode (Volar doesn't handle TS directly)
- Add `maxTsServerMemory` to vtsls settings
- Ensure proper `exclude` in tsconfig.json

### Issue: Go to definition not working

**Cause**: Missing Vue type declarations or TypeScript can't resolve `.vue` modules.

**Fix**: Add `env.d.ts` with Vue module declarations.

### Issue: Both volar and vue_ls running

**Cause**: They're the same server with different names.

**Fix**: Explicitly set `vue_ls = false` in config.

---

## What You Get

With this setup, you have:

- ✅ Full TypeScript support in Vue SFC `<script>` blocks
- ✅ Template type checking and IntelliSense
- ✅ Auto-completion for Vue APIs (ref, computed, etc.)
- ✅ Go to definition across components and files
- ✅ Hover documentation
- ✅ Rename refactoring
- ✅ ESLint integration
- ✅ Prettier formatting
- ✅ Tailwind CSS IntelliSense
- ✅ Import auto-completion and organization
- ✅ Real-time diagnostics and error checking

---

## Additional Tips

### Optional: Custom Formatting

```lua
-- ~/.config/nvim/lua/plugins/formatting.lua
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        vue = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
      },
    },
  },
}
```

### Disable Luarocks Warning

If you get luarocks warnings in `:checkhealth`:

```lua
-- In ~/.config/nvim/lua/config/lazy.lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  rocks = {
    enabled = false, -- Disable if no plugins need it
  },
})
```

### Useful Commands

- `:LspInfo` - Check active LSP servers
- `:LspRestart` - Restart LSP servers
- `:Mason` - Manage LSP server installations
- `:LazyExtras` - Enable/disable LazyVim extras
- `:checkhealth` - Check Neovim configuration health
- `:messages` - View Neovim messages and errors

---

## Conclusion

The Vue + TypeScript setup in LazyVim is complex because it requires coordinating multiple LSP servers with specific roles. The key insight is understanding **hybrid mode**: Volar handles Vue-specific features while VTSLS handles TypeScript through a plugin.

This configuration provides a professional Vue development environment that rivals (and often exceeds) VSCode's capabilities.

**Time invested**: Potentially weeks of debugging
**Result**: A rock-solid, performant Vue development setup ✨
