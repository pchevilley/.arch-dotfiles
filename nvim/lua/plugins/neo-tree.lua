return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    follow_current_file = {
                        enabled = true,      -- was previously just `true`
                        leave_dirs_open = false, -- optional: whether parent dirs stay open
                    },
                    hijack_netrw_behavior = "disabled",
                    use_libuv_file_watcher = true,
                    filtered_items = {
                        visible = true,        -- show hidden files
                        hide_dotfiles = false, -- don’t hide dotfiles
                        hide_gitignored = false, -- optional: show gitignored files
                    },
                },
                window = {
                    --position = "float",  -- popup mode
                    --width = 50,
                    --height = 20,
                    position = "current",
                    mappings = {
                        ["<CR>"] = "open",
                        ["o"] = "open",
                        ["<C-c>"] = "close_window",
                        ["D"] = "add_directory",
                        ["-"] = "navigate_up",
                        ["z"] = "noop"
                    },
                },
                event_handlers = {
                    {
                        event = "neo_tree_buffer_enter",
                        handler = function()
                            -- Simulate pressing `zz` in this buffer
                            vim.cmd("normal! zz")
                        end,
                    },
                },
            })

            -- Example keymap to toggle Neo-tree popup
            vim.keymap.set("n", "<leader>x", ":Neotree toggle<CR>", { desc = "Neo-tree popup" })
            vim.keymap.set("n", "<leader>e", ":Neotree reveal toggle<CR>", { desc = "Neo-tree popup" })

            vim.api.nvim_create_autocmd("FileType", {
  pattern = "neo-tree",
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }

    -- Keep native z-motions working in Neo-tree
    vim.keymap.set("n", "zz", "zz", opts) -- center
    vim.keymap.set("n", "zt", "zt", opts) -- top
    vim.keymap.set("n", "zb", "zb", opts) -- bottom
  end,
})
        end,
    }
}

