vim.g.syntax="off"

vim.g.errorbells=false
vim.opt.tabstop=4 
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.smartindent=true
-- set rnu
vim.opt.nu=true
vim.opt.wrap=false
vim.opt.smartcase=true
vim.opt.swapfile=false
vim.g.backup=false
vim.g.undodir="~/.config/nvim/undodir"
vim.g.undofile=true
vim.opt.incsearch= true
vim.opt.encoding="utf-8"
vim.opt.backspace="indent,eol,start"
vim.opt.mouse="a"
vim.g.colorcolumn=80
--vim.opt.foldmethod="indent"

vim.g.highlight="ColorColumn" 
vim.g.ctermbg=0 
vim.g.guibg="lightgrey"

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
--***These are regular plugins***
--Plug 'ycm-core/YouCompleteMe'
--Plug 'neoclide/coc.nvim', {'branch': 'release'}
--
-- native lsp
Plug 'neovim/nvim-lspconfig' --LSP support

Plug 'hrsh7th/nvim-cmp' -- Completion engine
Plug 'hrsh7th/cmp-nvim-lsp' -- LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-buffer' -- Buffer completion source
Plug 'hrsh7th/cmp-path' -- Path completion source
Plug 'hrsh7th/cmp-cmdline' -- Command line completion
Plug 'saadparwaiz1/cmp_luasnip' -- Snippet completion
Plug 'L3MON4D3/LuaSnip' -- Snippet engine
Plug 'tpope/vim-fugitive'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'

--lua line and icons
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

--line indents
Plug 'lukas-reineke/indent-blankline.nvim'

--Telescope dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug ('nvim-telescope/telescope.nvim', { branch= '0.1.x' })
Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do']= 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'nvim-telescope/telescope-file-browser.nvim'

--These are Theme plugins
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'gosukiwi/vim-atom-dark'
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug ('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})

--orgmode plugin
--Plug 'nvim-orgmode/orgmode'

--Twilight
Plug 'folke/twilight.nvim'

--Zen Mode
Plug 'folke/zen-mode.nvim'
vim.call("plug#end")

--color scheme
vim.cmd('colorscheme gruvbox')
vim.opt.background = 'dark'

if vim.fn.executable('rg') == 1 then
    vim.g.rg_derive_root = true
end

vim.g.ctrlp_user_command = "['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']"
vim.g.mapleader = " "

vim.g.netrw_browse_split = 2
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.ctrlp_use_caching = 0

-- save cursor placement
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local last_pos = vim.fn.line([['"]])
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- neovim lsp
require'lspconfig'.pylsp.setup{}

-- Setup nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP source
    { name = 'luasnip' }, -- Snippets
  }, {
    { name = 'buffer' }, -- Buffer completion
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['pyright'].setup {
  capabilities = capabilities,
}
require('lspconfig')['clangd'].setup {
  capabilities = capabilities,
}
--require'lspconfig'.pyright.setup{}
--require'lspconfig'.clangd.setup{}

-- Jump to definition
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })

-- Jump to references
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })

-- Jump to declaration
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })

-- Jump to implementation
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true, silent = true })

-- Hover for symbol information
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })

-- Show function signature
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true, silent = true })



--let g:coc_config_home = '/home/john/.config/coc/'
--
--"-------------------------------------------------------------
--"COC Commands
--""-------------------------------------------------------------
--fun! GoCoc()
--    inoremap <buffer> <silent><expr> <TAB>
--                \ pumvisible() ? "\<C-n>" :
--                \ <SID>check_back_space() ? "\<TAB>" :
--                \ coc#refresh()
--
--    inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
--    inoremap <buffer> <silent><expr> <C-space> coc#refresh()
--   
--    "COC GoTo code navigation
--    nmap <buffer> <leader>gd <Plug>(coc-definition)
--    nmap <buffer> <leader>gy <Plug>(coc-type-definition)
--    nmap <buffer> <leader>gi <Plug>(coc-implementation)
--    nmap <buffer> <leader>gr <Plug>(coc-references)
--    nnoremap <buffer> <leader>cr :CocRestart
--    
--    " Use K to show documentation in preview window.
--    nnoremap <silent> K :call <SID>show_documentation()<CR>
--endfun

--"-------------------------------------------------------------
--"Telescope commands
--""-------------------------------------------------------------
vim.api.nvim_set_keymap('n', 'ff', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fg', '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fb', '<cmd>Telescope file_browser<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'fh', '<cmd>Telescope help_tags<CR>', { noremap = true, silent = true })
--noremap <leader>ff <cmd>Telescope find_files<cr>
--noremap <leader>fg <cmd>Telescope live_grep<cr>
--noremap <leader>fb <cmd>Telescope file_browser<cr>
--noremap <leader>fh <cmd>Telescope help_tags<cr>

--start up NERDTree by default   ***  --REPLACED BY TELESCOPE--
--autocmd StdinReadPre * let s:std_in=1
--autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

---------------------------------------------------------------
--NerdTree shortcuts
--"-------------------------------------------------------------
vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true, silent = true })
--nnoremap <leader>n :NERDTreeFocus<CR>
--nnoremap <C-n> :NERDTree<CR>
--nnoremap <C-t> :NERDTreeToggle<CR>
--nnoremap <C-f> :NERDTreeFind<CR>

-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require("telescope").setup {
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      hidden = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require("telescope").load_extension "file_browser"

---------------------------------------------------------------
--OrgMode setup
--"-------------------------------------------------------------
--lua << EOF
---- Load custom treesitter grammar for org filetype
--require('orgmode').setup_ts_grammar()
--
---- Treesitter configuration
--require('nvim-treesitter.configs').setup {
--  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
--  -- highlighting will fallback to default Vim syntax highlighting
--  highlight = {
--    enable = true,
--    -- Required for spellcheck, some LaTex highlights and
--    -- code block highlights that do not have ts grammar
--    additional_vim_regex_highlighting = {'org'},
--  },
--  ensure_installed = {'org'}, -- Or run :TSUpdate org
--}
--
--require('orgmode').setup({
--  org_agenda_files = {'~/Documents/org/*', '~/my-orgs/**/*'},
--  org_default_notes_file = '~/Documents/org/refile.org',
--})
--EOF

---------------------------------------------------------------
--Lualine setup
--"-------------------------------------------------------------
require('lualine').setup{
options = { theme = 'horizon' }
}

---------------------------------------------------------------
--indent_blankline setup
--"-------------------------------------------------------------
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol: " --↴

require("ibl").setup {
    --space_char_blankline = " ",
    --show_current_context = true,
    --show_current_context_start = true,
}

---------------------------------------------------------------
--setup for Zen Mode
--"-------------------------------------------------------------
--nnoremap <Leader>z :ZenMode<CR>
vim.keymap.set('n', '<leader>z', ':ZenMode<CR>', { noremap = true, silent = true })
require("zen-mode").setup {
   window = {
    backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    -- height and width can be:
    -- * an absolute number of cells when > 1
    -- * a percentage of the width / height of the editor when <= 1
    -- * a function that returns the width or the height
    width = 90,--120, -- width of the Zen window
    height = 1, -- height of the Zen window
    -- by default, no options are changed for the Zen window
    -- uncomment any of the options below, or add other vim.wo options you want to apply
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      -- cursorcolumn = false, -- disable cursor column
      -- foldcolumn = "0", -- disable fold column
      -- list = false, -- disable whitespace characters
    },
  },
  plugins = {
    -- disable some global vim options (vim.o...)
    -- comment the lines to not apply the options
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    -- this will change the font size on kitty when in zen mode
    -- to make this work, you need to set the following kitty options:
    -- - allow_remote_control socket-only
    -- - listen_on unix:/tmp/kitty
    kitty = {
      enabled = false,
      font = "+4", -- font size increment
    },
    -- this will change the font size on alacritty when in zen mode
    -- requires  Alacritty Version 0.10.0 or higher
    -- uses `alacritty msg` subcommand to change font size
    alacritty = {
      enabled = false,
      font = "14", -- font size
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
  end,
    }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "query", "python", "asm" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

  -- List of parsers to ignore installing (for "all")
  --ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
    -- `false` will disable the whole extension
        enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

---------------------------------------------------------------
--setup for Twilight
--"-------------------------------------------------------------
  require("twilight").setup{
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "Normal", "#ffffff" },
    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {}, -- exclude these filetypes
}

