-- ============================================================================
-- basic options
-- ============================================================================

vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

vim.opt.termguicolors = true
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true
vim.opt.breakindent = true

vim.wo.number = true
vim.wo.relativenumber = true

-- ============================================================================
-- lazy.nvim bootstrap
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- keymaps
-- ============================================================================

local map = vim.keymap.set

map("n", "<C-s>", "<cmd>w<cr>", { silent = true })
map("i", "<C-s>", "<esc><cmd>w<cr>a", { silent = true })

map("n", "<A-j>", ":m .+1<CR>==", { silent = true })
map("n", "<A-k>", ":m .-2<CR>==", { silent = true })
map({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- ============================================================================
-- lazy plugins
-- ============================================================================

require("lazy").setup({

-- ----------------------------------------------------------------------------
-- core
-- ----------------------------------------------------------------------------

"nvim-lua/plenary.nvim",

-- ----------------------------------------------------------------------------
-- ui
-- ----------------------------------------------------------------------------

{
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("nvim-tree").setup({
            view = { width = 30, side = "left" },
            update_focused_file = { enable = true },
            filters = { dotfiles = false },
            actions = { open_file = { quit_on_open = false } },
        })
        map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true })
    end,
},

{
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup({})
        map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { silent = true })
    end,
},

-- ----------------------------------------------------------------------------
-- editing
-- ----------------------------------------------------------------------------

{
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup({
            disable_filetype = { "TelescopePrompt" },
            check_ts = true,
        })
    end,
},

{
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup()
    end,
},

"mg979/vim-visual-multi",

{
    "mustache/vim-mustache-handlebars",
    ft = { "hbs", "handlebars" },
},

-- ----------------------------------------------------------------------------
-- completion
-- ----------------------------------------------------------------------------

{
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
        })
    end,
},

-- ----------------------------------------------------------------------------
-- lsp + mason (neovim 0.11+)
-- ----------------------------------------------------------------------------

{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end,
},

{
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "gopls",
                "clangd",
                "pyright",
                "rust_analyzer",
                "lua_ls",
                "ts_ls", -- JS + TS
                "html"
            },
        })
    end,
},

{
    "neovim/nvim-lspconfig",
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        local on_attach = function(_, bufnr)
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end

        local servers = { "gopls", "clangd", "pyright", "rust_analyzer", "tsserver", "lua_ls" }
        for _, lsp in ipairs(servers) do
            vim.lsp.config(lsp, {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = lsp == "lua_ls" and {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" }, disable = { "undefined-global" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                } or nil,
            })
        end
    end,
},

{
  "vyfor/cord.nvim",
  build = ":Cord update",
  event = "VeryLazy",
  opts = {
    editor = {
      client = "neovim",
    },
    display = {
      show_time = true,
    },
  }
},

{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
},

})

-- vim.cmd.colorscheme("tokyonight")

-- ============================================================================
-- diagnostics
-- ============================================================================

local function remove_suffix(str, suffix)
    if str:sub(-#suffix) == suffix then
        return str:sub(1, -#suffix - 1)
    end
    return str
end

vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        source = "if_many",
        format = function(d)
            if not d.source then
                return remove_suffix(d.message, ".")
            end
            return string.format(
                "%s: %s",
                remove_suffix(d.source, "."),
                remove_suffix(d.message, ".")
            )
        end,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.lsp.config("html", {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "hbs", "handlebars" },
})

