local servers = {
    "lua_ls",
    "rust_analyzer",
    "gopls",
    "clangd",
    "bashls",
    "pylsp",
    "jsonls",
    "marksman",
    "yamlls",
    "sqls",
    "dockerls"
}

return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        config = function()
            local caps = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("clangd", {
                capabilities = caps,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--query-driver=/home/kiasoh/.platformio/packages/toolchain-xtensa-esp32/bin/xtensa-esp32-elf-*",
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = servers,
                -- handlers are removed from version 2+
            --     handlers = {
            --         function(server)
            --             vim.notify("LSP handler invoked for: " .. server, vim.log.levels.INFO)
            --             vim.api.nvim_echo({ { "LSP handler: " .. server, "WarningMsg" } }, true, {})
            --             if server == "clangd" then
            --                 vim.notify("clangd.setup() executing", vim.log.levels.WARN)
            --                 local capabilities = require('cmp_nvim_lsp').default_capabilities()
            --                 local lspconfig = require("lspconfig")
            --                 lspconfig.clangd.setup({
            --                     capabilities = capabilities,
            --                     cmd = {
            --                         "clangd",
            --                         "--background-index",
            --                         "--clang-tidy",
            --                         "--completion-style=detailed",
            --                     },
            --                     root_dir = lspconfig.util.root_pattern(
            --                         "compile_commands.json",
            --                         ".git"
            --                     ),
            --                 })
            --             else
            --                 local capabilities = require('cmp_nvim_lsp').default_capabilities()
            --                 local lspconfig = require("lspconfig")
            --                 lspconfig[server].setup({
            --                     capabilities = capabilities,
            --                 })
            --             end
            --         end,
            --     },
            })

            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- vim.lsp.start({
            --     name = "clangd",
            --     cmd = {
            --         "clangd",
            --         "--background-index",
            --         "--query-driver=/home/kiasoh/.arduino15/**/xtensa-esp32-elf-*",
            --     },
            --     capabilities = capabilities,
            -- })
            --
            -- local lspconfig = require("lspconfig")
            -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- -- vim.lsp.config.clangd.setup({
            -- lspconfig.clangd.setup({
            --     capabilities = capabilities,
            --     cmd = {
            --         "clangd",
            --         "--background-index",
            --         "--query-driver=/home/kiasoh/.arduino15/**/xtensa-esp32-elf-*",
            --     },
            --
            -- })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            --			local lspconfig = require("lspconfig")
            --			local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local opts = {}

            --			for _, server in ipairs(servers) do
            --				lspconfig[server].setup({
            --					capabilities = capabilities,
            --				})
            --			end

            -- global LSP keymaps
            vim.keymap.set('n', 'H', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup {
                extensions = {
                    ["ui-select"] = require("telescope.themes").get_dropdown {}
                }
            }
            require("telescope").load_extension("ui-select")
        end
    }
}
