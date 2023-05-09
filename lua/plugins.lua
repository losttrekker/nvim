-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({
  -- better UI
  {
    "stevearc/dressing.nvim",
    config = function()
      require("plugins/dressing").setup()
    end,
  },

  -- better notifications
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
    end,
  },
  -- Keep cursor vertically centered
  -- {
  --   "arnamak/stay-centered.nvim",
  --   config = function()
  --     require("stay-centered")
  --   end,
  -- },

  -- Mason package manager for lsp servers, dap, etc.
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "cmake",
          "pyright",
          "dockerls",
          "jsonls",
          "clangd",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Local config files
  {
    "klen/nvim-config-local",
    config = function()
      require("config-local").setup({
        -- Default configuration (optional)
        config_files = { ".vimrc.lua", ".vimrc" }, -- Config file patterns to load (lua supported)
        hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true, -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
        silent = false, -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = false, -- Lookup config files in parent directories
      })
    end,
  },
  -- Keybindings configuration / visualisation
  -- Note: Keybindings are configured in keybindings.lua for better self-documentation
  {
    "folke/which-key.nvim",
  },

  -- File Explorer
  {
    -- "kyazdani42/nvim-tree.lua",
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              bo = {
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#e35e4f",
          })
        end,
      },
    },
    config = function()
      require("plugins/neotree").setup()
    end,
  },

  -- -- Preview vim register contents
  -- { "tversteeg/registers.nvim" },

  -- bufferline ("tabs")
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
    config = function()
      require("plugins/bufferline").setup()
    end,
  },

  -- Formatters
  {
    "sbdchd/neoformat",
  },

  -- Telescope, for file finders/browsers
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    config = function()
      require("plugins/telescope").setup()
    end,
  },

  -- Code completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "f3fora/cmp-spell",
      "L3mon4d3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
      "p00f/clangd_extensions.nvim",
      "rcarriga/cmp-dap",
    },
    config = function()
      require("plugins/autocompletion").setup()
    end,
  },
  -- Code snippets
  {
    "L3mon4d3/LuaSnip",
    config = function()
      require("plugins/luasnip").setup()
    end,
  },

  -- Configs for the built-in Language Server Protocol
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins/lspconfig").setup()
    end,
  },

  -- Lsp additions
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = { "catppuccin/nvim", "lewis6991/gitsigns.nvim" },
    config = function()
      require("plugins/lspsaga").setup()
    end,
  },

  -- clangd extensions (such as inlay hints)
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("plugins/clangd").setup()
    end,
  },

  -- Displaying errors/warnings in a window
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  -- cmake
  {
    -- "cdelledonne/vim-cmake",
    "Civitasv/cmake-tools.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins/cmake").setup()
    end,
  },

  -- rust
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("plugins/rust_tools").setup()
    end,
  },

  -- csv
  { "mechatroner/rainbow_csv" },

  -- comments
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- git

  {
    "TimUntersberger/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    config = function()
      require("plugins/neogit").setup()
    end,
  },

  -- diffing/merging
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

  -- debugging
  {
    "rcarriga/nvim-dap-ui",
    -- version = "v3.2.2",
    dependencies = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
      "jbyuki/one-small-step-for-vimkind",
    },
    config = function()
      require("plugins/debugging").setup()
    end,
  },

  -- Mason configuration for dap
  {
    "jayp0521/mason-nvim-dap.nvim",
    config = function()
      require("mason-nvim-dap").setup({
        automatic_installation = true,
        ensure_installed = { "python", "cppdbg", "codelldb" },
      })
    end,
  },

  -- Tresitter for minimal source code highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins/treesitter").setup()
    end,
  },

  -- startup.nvim startup manager
  {
    "startup-nvim/startup.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("startup").setup({ theme = "dashboard" })
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "mortepau/codicons.nvim" },
    config = function()
      require("plugins/lualine").setup()
    end,
  },

  -- undotree visualiser
  {
    "mbbill/undotree",
    config = function()
      require("plugins/undotree").setup()
    end,
  },

  -- Highlight & search todos
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins/todo-comments").setup()
    end,
  },

  -- UI based search/replace
  {
    "VonHeikemen/searchbox.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("plugins/searchbox").setup()
    end,
  },

  -- Image viewer (doesn't support Terminator)
  -- {
  --   "edluffy/hologram.nvim",
  --   config = function()
  --     require("plugins/hologram").setup()
  --   end,
  -- },

  -- Colour theme
  {
    -- "navarasu/onedark.nvim",
    "catppuccin/nvim",
    config = function()
      require("plugins/colourscheme").setup()
    end,
  },

  -- Indentation guides
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins/indent_blankline").setup()
    end,
  },

  -- jump motions
  {
    "ggandor/leap.nvim",
    dependencies = "tpope/vim-repeat",
    config = function()
      require("plugins/leap").setup()
    end,
  },

  -- folds
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("plugins/nvim_ufo").setup()
    end,
  },

  -- statuscol
  {
    "luukvbaal/statuscol.nvim",
    dependencies = { "mfussenegger/nvim-dap", "lewis6991/gitsigns.nvim" },
    config = function()
      require("plugins/statuscol").setup()
    end,
  },

  -- camel case or snake case motion
  {
    "chaoren/vim-wordmotion",
    config = function() end,
  },

  -- Highlight git changes in statuscol
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins/gitsigns").setup()
    end,
  },

  -- Show current code context
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("plugins/navic").setup()
    end,
  },

  -- Statusline built on navic to show the current code context
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("plugins/barbecue").setup()
    end,
  },

  -- Autopairs
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("plugins/mini-pairs").setup()
    end,
  },

  -- Jump forward/backward to various target types (e.g conflict marker, comment block)
  {
    "echasnovski/mini.bracketed",
    version = false,
    config = function()
      require("plugins/mini-bracketed").setup()
    end,
  },

  -- Search & replace
  {
    "windwp/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    config = function()
      require("plugins/spectre").setup()
    end,
  },

  { "kevinhwang91/promise-async" },
})
