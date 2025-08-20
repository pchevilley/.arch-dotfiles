vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    --use({ 'rose-pine/neovim', as = 'rose-pine' })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'ThePrimeagen/harpoon'

--    use 'mbbill/undotree'
    use 'lunarvim/horizon.nvim'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use({
        "kdheepak/lazygit.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    use 'f-person/git-blame.nvim'

    use('neovim/nvim-lspconfig')
    use('MunifTanjim/prettier.nvim')

    use 'github/copilot.vim'
end)
