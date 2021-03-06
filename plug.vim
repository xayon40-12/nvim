if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'vim-scripts/restore_view.vim'
Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'kovisoft/paredit'
Plug 'tpope/vim-surround'
"
" plugins for text object
Plug 'kana/vim-textobj-user'
" search text object plugin at https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'

"Plug 'mlochbaum/BQN', {'rtp': 'editors/vim'}
"Plug 'https://git.sr.ht/~detegr/nvim-bqn'
"let g:nvim_bqn="bqn"
Plug 'simrat39/rust-tools.nvim'
Plug 'ollykel/v-vim'
Plug 'jubnzv/mdeval.nvim'

Plug 'kyazdani42/nvim-web-devicons'

" Rendering markdown in browser, needs 'node' and 'yarn' installed
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
let g:mkdp_auto_start = 1
"let g:mkdp_command_for_global = 1
"let g:mkdp_browser = 'Applications/Safari.app'
"let g:mkdp_echo_preview_url = 1
"let g:mkdp_port = '11234'


if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-neorg/neorg'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'chrisbra/unicode.vim'
endif

call plug#end()

lua << EOF

require('lualine').setup {
  options = {
    --theme = 'molokai'
    theme = 'palenight'
  }
}

require 'mdeval'.setup({
  -- Don't ask before executing code blocks
  require_confirmation=false,
  -- Change code blocks evaluation options.
  eval_options = {},
})

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<S-CR>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<C-CR>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "neorg" },
    { name = "path" },
    { name = 'buffer' },

    -- For vsnip user.
    -- { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

  }
})



local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --require'completion'.on_attach(client, bufnr)


  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspacefolder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  if client.server_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "hls", "rust_analyzer", "ccls", "texlab", "vls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp.texlab.setup {
  settings = {
    texlab = {
      build = {
        onSave = true
      }
    }
  }
}

require('rust-tools').setup({})
nvim_lsp.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importPrefix = "by_self",
      },
      diagnostics = {
        disabled = { "unresolved-import" }
      },
      cargo = {
          loadOutDirsFromCheck = true
      },
      procMacro = {
          enable = true
      },
      checkOnSave = {
          command = "clippy"
      },
    }
  }
}

local saga = require 'lspsaga'
saga.init_lsp_saga()

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "norg",
    "norg_meta",
    "norg_table",
    "toml",
    "yaml",
    "cpp",
    "c",
    "v",
    "haskell",
    "java",
    "rust",
    "latex"
  },
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

require('neorg').setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.keybinds"] = { -- Configure core.keybinds
            config = {
                default_keybinds = true, -- Generate the default keybinds
                neorg_leader = "<Leader>o" -- This is the default if unspecified
            }
        },
        ["core.norg.concealer"] = {}, -- Allows for use of icons
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
                workspaces = {
                    my_workspace = "~/notes"
                }
            }
        },
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
          }
        },
    },
}

EOF
