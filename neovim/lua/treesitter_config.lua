require('nvim-treesitter.configs').setup({
        ensure_installed = {"bash", "c", "cpp", "css", "dockerfile", "html", "json", "lua", "make", "python", "rust", "toml", "vim", "yaml" },
        context_commentstring = { enable = true, },
        highlight = { enable = true, },
        indent = { enable = false, },
    })
