call plug#begin('~/.vim/plugged/')

" UI / IDE Features
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'jamessan/vim-gnupg'
Plug 'tpope/vim-scriptease'

" Text editing
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'vim-scripts/DeleteTrailingWhitespace'

" Colors
" Plug 'flazz/vim-colorschemes'
Plug 'jordwalke/flatlandia'
Plug 'farseer90718/flattr.vim'
Plug 'blerins/flattown'
Plug 'overdrivenpotato/vim-obsidian'
Plug 'penicolas/simplon.vim'
Plug 'vyshane/vydark-vim-color'
Plug 'duythinht/inori'
Plug 'jonathanfilip/vim-lucius'

" Languages
Plug 'cespare/vim-toml'
Plug 'tikhomirov/vim-glsl'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-git'
Plug 'rust-lang/rust.vim'
Plug 'wavded/vim-stylus'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'tfnico/vim-gradle'
Plug 'vim-scripts/asmM68k.vim'
Plug 'pangloss/vim-javascript'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fatih/vim-nginx'
Plug 'vim-scripts/sql.vim--Stinson'
Plug 'JulesWang/css.vim'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'elzr/vim-json'
Plug 'tmux-plugins/vim-tmux'
Plug 'elixir-lang/vim-elixir'
Plug 'leafgarland/typescript-vim'
Plug 'flowtype/vim-flow'
Plug 'ianks/vim-tsx'
Plug 'elmcast/elm-vim'
Plug 'plasticboy/vim-markdown'
Plug 'gluon-lang/vim-gluon'
Plug 'rhysd/vim-llvm'
Plug 'vim-scripts/octave.vim--'
Plug 'DingDean/wgsl.vim'
Plug 'pest-parser/pest.vim'

" Misc
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

filetype plugin indent on


" Auto Reloading
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost resolve(expand("$DOTFILES/.vimrc")) source $MYVIMRC
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

syntax on
silent! colorscheme obsidian
set cursorline

" Load the shellrc file as an sh script
au BufNewFile,BufRead .shellrc set filetype=sh

" Enable true color
if has('termguicolors')
  set termguicolors
endif


" Encoding
set encoding=utf-8

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set autoindent

" Tabs instead of spaces for makefile
autocmd FileType make setlocal noexpandtab

" Show relative line numbers and current line
set number
set relativenumber

" Splitting
set splitright
set splitbelow

" Scrolling
set nowrap
set mouse=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif
set scrolloff=3
set sidescrolloff=5

" Smooth scrolling
set mousescroll=ver:1,hor:1

" Clipboard
set clipboard=unnamed

set incsearch

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap Q <NOP>

" Command abbreviations
command! W w
command! WQ wq
command! Wq wq
command! Q q

" custom highlighting
autocmd BufNewFile,BufRead *.nginx.conf set syntax=nginx
autocmd BufNewFile,BufRead .babelrc set syntax=javascript
autocmd BufNewFile,BufRead .browserslistrc set syntax=javascript
autocmd BufNewFile,BufRead .eslintrc set syntax=javascript

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" Disable check on save
let g:flow#enable = 0

" Flow Syntax highlighting
let g:javascript_plugin_flow = 1

" Use local flow if global isn't available
if !executable('flow') && executable('npm')
  let g:flow#flowpath = system('echo -n $(npm bin)/flow')
  let g:syntastic_javascript_flow_exe = g:flow#flowpath
endif

" JSX highlighting in .js files
let g:jsx_ext_required = 0


" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|.DS_Store\|.git\|target\|dist\|.class'
let g:ctrlp_root_markers = ['Cargo.toml']

if executable('rg') " ripgrep
  set grepprg=rg
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
endif

" Lifetimes for rust
augroup vimrc-rust-autopairs
  autocmd!
  autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup END

let g:AutoPairsMultilineClose = 0

augroup coc-goto
  autocmd!
  autocmd FileType rust nnoremap gd :call CocActionAsync('jumpDefinition')<CR>
  autocmd FileType javascript nnoremap gd :call CocActionAsync('jumpDefinition')<CR>
augroup END

if !has('nvim')
  set cryptmethod=blowfish2
endif
set backupcopy=yes

" Markdown
let g:vim_markdown_folding_disabled = 1

" Remap <ESC> to jk
inoremap <esc> <nop>
inoremap <esc>^[ <esc>^[
inoremap jk <esc>
vnoremap <esc> <nop>
vnoremap <esc>^[ <esc>^[
vnoremap jk <esc>
set timeoutlen=150

" Clear search on escape
nnoremap <ESC> :noh<CR><ESC>

" The default lightning emoji breaks alacritty and many other emulators. Seems
" to be a bug in `wcwidth`.
"
" https://github.com/alacritty/alacritty/issues/1295
" https://gitlab.freedesktop.org/terminal-wg/specifications/issues/9
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.dirty = "\uf0e7"

" Theme tweaks
hi CocHintSign guifg=#1b3e4f
hi CocHintFloat guifg=#c4c8cc

let g:tex_flavor = 'latex'

" This could be better
autocmd BufNewFile,BufRead *.metal set syntax=cpp

" Octave syntax
augroup filetypedetect
  au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END

set signcolumn=number


" coc.nvim settings below:

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
