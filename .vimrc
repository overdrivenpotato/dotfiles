set runtimepath+=~/.vim/vim-plug/

call plug#begin('~/.vim/plugged/')

" UI / IDE Features
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'xolox/vim-session'
Plug 'danro/rename.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'ervandew/supertab'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'diepm/vim-rest-console'
Plug 'terryma/vim-smooth-scroll'
Plug 'vim-syntastic/syntastic'

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
Plug 'abra/vim-obsidian'
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
Plug 'sql.vim--Stinson'
Plug 'JulesWang/css.vim'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'
Plug 'elzr/vim-json'
Plug 'tmux-plugins/vim-tmux'
Plug 'elixir-lang/vim-elixir'
Plug 'flowtype/vim-flow'

" Misc
Plug 'xolox/vim-misc'
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

filetype plugin indent on

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Auto Reloading
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Enable colors and set guifont
syntax on
set guifont=Sauce\ Code\ Powerline\ ExtraLight:h12

" Adjust TODO group due to current line highlight
silent! colorscheme obsidian
hi Todo guifg=#a082bd guibg=#FBFBFB
highlight! link SignColumn LineNr

" Highlight current line
set cursorline
hi CursorLine term=NONE cterm=NONE

" Load the shellrc file as an sh script
au BufNewFile,BufRead .shellrc set filetype=sh

" Enable true color
if has('termguicolors')
  set termguicolors

  " Use correct color codes if running through screen or tmux
  if &term =~ '^screen'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

" Tmux cursor
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\""

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
set go-=b
set go-=L
set go-=r
set nowrap
set mouse=niv
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif
set scrolloff=3
set sidescrolloff=5

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" Clipboard
set clipboard=unnamed

" Remove toolbar
set go-=T

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

" nginx conf files
autocmd BufNewFile,BufRead *.nginx.conf set syntax=nginx

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

let g:syntastic_javascript_checkers = ['flow']

" Sesssion management
let g:session_autosave = 'no'

" Completion
let g:ycm_rust_src_path = $RUST_SRC_PATH

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|.DS_Store\|.git\|target\|dist\|.class'

if executable('rg') " ripgrep
  set grepprg=rg
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
elseif executable('ag') " The Silver Searcher
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore .DS_Store --ignore .git/ --ignore node_modules'
  let g:ctrlp_use_caching = 0
endif

" Searching
hi IncSearch guibg=fg

" Lifetimes for rust
augroup vimrc-rust-autopairs
  autocmd!
  autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup END
