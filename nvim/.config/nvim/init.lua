vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.laststatus = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 3
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.wildmode = { list = 'longest' }
vim.opt.listchars = { tab = '▸-', trail = '-', extends = '»', precedes = '«' }
vim.opt.colorcolumn = '80'
vim.api.nvim_create_autocmd(
  'Filetype', { pattern = 'rust', command = 'set colorcolumn=100' }
)
vim.opt.swapfile = false

vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { silent = true })
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('', '<F1>', '<Esc>')
vim.keymap.set('i', '<F1>', '<Esc>')
vim.keymap.set('', '<leader>n', ':NvimTreeToggle<CR>')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  -- color scheme
  {
    'cocopon/iceberg.vim',
    lazy = false,
    config = function()
      vim.cmd([[colorscheme iceberg]])
    end,
  },

  -- status line
 {
    'itchyny/lightline.vim',
    lazy = false,
    config = function()
      vim.o.showmode = false
      vim.g.lightline = {
        colorscheme = 'iceberg',
        active = {
          left = {
            { 'mode', 'paste' },
            { 'readonly', 'filename', 'modified' },
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'fileformat', 'fileencoding', 'filetype' },
      },
        },
      }
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require('nvim-tree').setup({})
    end,
  },

  -- navigation
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end
  },
  
  -- % motion
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },
  
  -- fgf
  {
    'ibhagwan/fzf-lua',
    config = function()
      vim.keymap.set('', '<C-\\>', ':FzfLua buffers<CR>')
      vim.keymap.set('', '<C-p>', ':FzfLua files<CR>')
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      require('lspconfig.ui.windows').default_options.border = 'single'
 
      -- Go
      lspconfig.gopls.setup({})

      -- Rust
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            imports = {
              granularity = {
                group = "module",
              },
            },
          },
        },
      }

      -- keymap
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    end
  },

  -- snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },

  -- code completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }), 
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'luasnap' },
        }, {
          { name = 'buffer' },
        })
      })
    end
  },

  -- rustfmt
  {
    'rust-lang/rust.vim',
    ft = { 'rust' },
    config = function()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- automatically check for plugin updates
  checker = { enabled = true },
})

