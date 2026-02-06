return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add          = { text = "│" },
                change       = { text = "│" },
                delete       = { text = "_" },
                topdelete    = { text = "‾" },
                changedelete = { text = "~" },
            },
            numhl = false,
            linehl = false,
            word_diff = false,
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = false,
            sign_priority = 6,
            update_debounce = 200,
            status_formatter = nil,
        })

        -- Keymaps
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })

        map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, { expr = true, desc = "Previous git hunk" })

        -- Actions
        map({"n", "v"}, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
        map({"n", "v"}, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>gbR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>gbl", function() gs.blame_line{full=true} end, { desc = "Blame line" })
        map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this buffer" })
        map("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff against last commit" })
        map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted signs" })
    end,
}
