" let g:loaded_youcompleteme = 1

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

" Text editing
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/neocomplcache.vim'
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
Plug 'mtscout6/vim-cjsx'
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

" Misc
Plug 'xolox/vim-misc'

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

" Colors and fonts
silent! colorscheme obsidian
syntax on
set guifont=Sauce\ Code\ Powerline\ ExtraLight:h12
set cursorline
hi CursorLine term=NONE cterm=NONE

" Use correct color codes if running through screen or tmux
if &term =~ '^screen'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Enable true color
set termguicolors

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
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

if !has('gui_running')
  noremap <ScrollWheelUp> <C-Y>
  noremap <S-ScrollWheelUp> <C-U>
  noremap <ScrollWheelDown> <C-E>
  noremap <S-ScrollWheelDown> <C-D>
endif

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

" js settings
let g:javascript_plugin_flow = 1

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

" Conceal
hi Conceal guibg=bg guifg=fg
syn match rustFatRightArrowHead contained ">" conceal cchar= 
syn match rustFatRightArrowTail contained "=" conceal cchar=⇒
syn match rustNiceOperator "=>" contains=rustFatRightArrowHead,rustFatRightArrowTail
syn match rustNiceOperator /\<\@!_\(_*\>\)\@=/ conceal cchar=′
hi link rustNiceOperator Operator
hi! link Conceal Operator
" let g:rust_conceal=1

" Searching
hi IncSearch guibg=fg

" Lifetimes for rust
augroup vimrc-rust-autopairs
  autocmd!
  autocmd FileType rust let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}
augroup END
