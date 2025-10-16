# AI Assistant Prompt for Vue + TypeScript LazyVim Issues

## Ready-to-Use Prompt Template

Copy and paste this prompt to AI assistants (Claude, ChatGPT, etc.) when you need help:

```
I'm using LazyVim (Neovim distribution) and having issues setting up Vue.js with TypeScript.

Current problems:
- [Describe your specific issues, e.g., "infinite tsconfig.app.json loop", "go to definition not working", "duplicate LSP servers", etc.]

My current setup:
- Neovim version: [run: nvim --version]
- LazyVim extras enabled: [list them, or output of :LazyExtras]
- Mason packages installed: [list them, or relevant output from :Mason]
- LSP servers running: [output of :LspInfo when in a .vue file]

What I need:
1. A working Vue + TypeScript setup in LazyVim with proper LSP support
2. The setup should use Volar in hybrid mode with VTSLS
3. Go to definition (gd), hover (K), and auto-completion should all work
4. No infinite loops or duplicate servers

Key constraints:
- I want to use the LazyVim Vue extra (lang.vue)
- I need both .vue and .ts files to work correctly
- The solution should avoid running both volar and vue_ls simultaneously
- VTSLS should handle TypeScript in .vue files via the Vue TypeScript plugin

Please provide:
1. Complete configuration for ~/.config/nvim/lua/plugins/vue.lua
2. Explanation of why each setting is needed
3. Step-by-step instructions to apply the fix
4. How to verify it's working correctly

Context: The issue is that Volar, vue_ls, and vtsls can conflict when not configured properly.
The solution requires: hybridMode: true, vtsls handling both .ts and .vue files,
and the Vue TypeScript plugin properly configured in vtsls settings.
```

---

## Tips for Getting Better AI Help

### 1. Include Diagnostic Outputs

Always provide:

- Output from `:LspInfo` (especially when in a .vue file)
- Output from `:checkhealth lazy` and `:checkhealth vim.lsp`
- Any error messages from `:messages`
- Your current `~/.config/nvim/lua/plugins/vue.lua` if it exists

### 2. Specify Your Goal

Be clear about:

- Whether you want **hybrid mode** or **take-over mode**
- What features you absolutely need (e.g., "must have gd working")
- Your project setup (Vite, Nuxt, plain Vue, etc.)

### 3. Mention What You've Tried

List previous solutions that didn't work:

- "I tried setting hybridMode: false but got error X"
- "I disabled vtsls but then TypeScript stopped working"
- "I followed tutorial Y but it caused infinite loops"

### 4. Ask for Explanations

Request understanding, not just code:

- "Why is hybridMode: true needed?"
- "What's the difference between volar and vue_ls?"
- "Why does vtsls need the Vue TypeScript plugin?"

### 5. Request Verification Steps

Ask how to test the solution:

- "How do I verify all servers are running correctly?"
- "What should I see in :LspInfo?"
- "What test cases should work?"

---

## Example Follow-up Questions

### If Go to Definition Doesn't Work

```
The configuration didn't fully work. Go to definition (gd) is not working in .vue files.

Current status:
- :LspInfo shows: [paste output]
- When I press gd on an import: [describe what happens]
- Error messages: [paste from :messages]

Questions:
1. Which LSP servers should be attached to .vue files?
2. Should I see both volar and vtsls in :LspInfo?
3. Do I need an env.d.ts file?
```

### If You're Getting Infinite Loops

```
I'm getting infinite "Initializing tsconfig.app.json" messages.

Observations:
- It happens when I open any .vue file
- :LspInfo shows: [paste output]
- The loop stops if I close the .vue file

Questions:
1. Is this a vtsls or volar issue?
2. Should vtsls have "vue" in filetypes or not?
3. What's the correct hybridMode setting?
```

### If You Have Duplicate Servers

```
I see both 'volar' and 'vue_ls' running in :LspInfo.

Current config:
[Paste your vue.lua file]

Questions:
1. Are volar and vue_ls the same thing?
2. How do I disable one of them?
3. Which one should I keep?
```

---

## Red Flags to Watch For

If an AI suggests these, ask for clarification:

### ❌ Bad Advice Signs

- **Running both volar and vue_ls** - They're duplicates, should only use one
- **Setting hybridMode: false without explanation** - Usually causes issues
- **Removing "vue" from vtsls filetypes** - TypeScript won't work in .vue files
- **Not mentioning the Vue TypeScript plugin** - Essential for hybrid mode
- **Complex multi-plugin solutions** - Usually overcomplicating things
- **Suggesting to install vue-tsc separately** - Not needed with proper LSP setup

### 🤔 Things to Question

- **"Just use take-over mode"** - Ask why, and what the trade-offs are
- **Modifying LazyVim core files** - Should use plugins/ directory instead
- **Installing additional plugins** - LazyVim extras should be sufficient
- **Manual LSP server installation** - Mason should handle this

---

## Good Signs the AI Understands

Look for these indicators of quality help:

### ✅ Positive Signs

- **Mentions hybrid mode vs take-over mode explicitly**
- **Explains that vue_ls and volar are the same server**
- **Includes the Vue TypeScript plugin configuration**
- **Provides clear verification steps** (`:LspInfo`, test cases)
- **Explains why each configuration setting exists**
- **Mentions the correct Mason packages** (volar, vue-language-server, vtsls)
- **References LazyVim documentation** or extras
- **Warns about common pitfalls**

### ✅ Quality Responses Include

1. **Clear file structure**: Where to put the config file
2. **Complete code blocks**: Not partial snippets
3. **Explanation of settings**: Why each option is set
4. **Testing instructions**: How to verify it works
5. **Troubleshooting steps**: What to do if it fails

---

## Information to Gather Before Asking

### System Info

```bash
# Neovim version
nvim --version

# Check if LazyVim is installed
ls ~/.config/nvim/lua/lazyvim

# Check current LazyVim extras
# In Neovim: :LazyExtras
```

### LSP Info

```vim
" In Neovim, open a .vue file and run:
:LspInfo

" Check for errors:
:messages

" Check LSP logs:
:LspLog
```

### Mason Packages

```vim
" In Neovim:
:Mason

" Look for these packages:
" - volar (or vue-language-server)
" - vtsls
" - prettier
" - eslint-lsp
```

### Current Configuration

```bash
# Check if you have a vue.lua file:
cat ~/.config/nvim/lua/plugins/vue.lua

# Check LazyVim config:
cat ~/.config/nvim/lua/config/lazy.lua
```

---

## Template for Filing Issues

If you're filing a bug report or asking in forums:

````markdown
## Environment

- **OS**: macOS / Linux / Windows
- **Neovim Version**: [nvim --version]
- **LazyVim Version**: [from :Lazy]

## Problem Description

[Describe the issue clearly]

## Steps to Reproduce

1. Open Neovim
2. Open a .vue file
3. [Specific action that causes the issue]

## Expected Behavior

[What should happen]

## Actual Behavior

[What actually happens]

## Configuration

<details>
<summary>~/.config/nvim/lua/plugins/vue.lua</summary>

```lua
[Your configuration]
```
````

</details>

## Diagnostic Output

<details>
<summary>:LspInfo</summary>

```
[Paste output]
```

</details>

<details>
<summary>:messages</summary>

```
[Paste any errors]
```

</details>

## What I've Tried

- [List previous attempts]

````

---

## Quick Reference: The Working Solution

For AI assistants, here's the TL;DR of what works:

```lua
-- ~/.config/nvim/lua/plugins/vue.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vue_ls = false, -- Disable duplicate
        volar = {
          filetypes = { "vue" },
          init_options = {
            vue = { hybridMode = true }, -- KEY SETTING
          },
        },
        vtsls = {
          filetypes = { "javascript", "javascriptreact", "javascript.jsx",
                       "typescript", "typescriptreact", "typescript.tsx", "vue" },
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
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
````

**Key points to convey to AI:**

1. `hybridMode: true` is essential
2. `vtsls` must handle both `.ts` AND `.vue` files
3. Vue TypeScript plugin must be in `vtsls` settings
4. Disable `vue_ls` to prevent duplicates
5. Both `volar` and `vue-language-server` packages needed in Mason
