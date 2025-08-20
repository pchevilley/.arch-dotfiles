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
                filtered_items = {
                    visible = true,        -- show hidden files
                    hide_dotfiles = false, -- don’t hide dotfiles
                    hide_gitignored = false, -- optional: show gitignored files
                },
                filesystem = {
                    follow_current_file = {
                        enabled = true,      -- was previously just `true`
                        leave_dirs_open = false, -- optional: whether parent dirs stay open
                    },
                    hijack_netrw_behavior = "disabled",
                    use_libuv_file_watcher = true,
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
                    },
                },
            })

            -- Example keymap to toggle Neo-tree popup
            vim.keymap.set("n", "<leader>x", ":Neotree toggle<CR>", { desc = "Neo-tree popup" })
            vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Neo-tree popup" })
        end,
    }
}

