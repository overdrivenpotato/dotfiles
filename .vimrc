set runtimepath+=~/.vim/vim-plug/

call plug#begin('~/.vim/plugged/')

" UI / IDE Features
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'xolox/vim-session'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'danro/rename.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tpope/vim-fugitive'

" Text editing
Plug 'jiangmiao/auto-pairs.git'
Plug 'Shougo/neocomplcache.vim'
Plug 'tpope/vim-surround'
Plug 'roryokane/detectindent'
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

" Misc
Plug 'xolox/vim-misc'

call plug#end()

filetype plugin indent on

" NeoSnippet-------------------------------------

" Auto Reloading
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" End NeoSnippet--------------------------------

" Colors and fonts
silent! colorscheme obsidian
set guifont=Sauce\ Code\ Powerline\ ExtraLight:h12
syntax on

" Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set smarttab
set autoindent
augroup DetectIndent
   autocmd!
   autocmd BufReadPost *  DetectIndent
augroup END

" Tabs instead of spaces for makefile
autocmd FileType make setlocal noexpandtab

" Show numbers
set number

" Splitting
set splitright
set splitbelow

" Scrolling
set go-=b
set go-=L
set go-=r
set nowrap

" Remove toolbar
set go-=T

" Mapping
map <D-b> :NERDTreeToggle<CR>
imap <D-b> <Esc><D-b>

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

" dont open nerdtree if given arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/Development | endif

" close nerdtree if only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" js settings
let g:javascript_plugin_flow = 1

" Sesssion management
let g:session_autosave = 'no'

" Completion
let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.6.0/src'

" Auto pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|.DS_Store\|.git\|target\|dist\|.class'
let g:ctrlp_working_path_mode = 'ra'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore .DS_Store --ignore .git/ --ignore node_modules'

  " ag is fast enough that CtrlP doesn't need to cache
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
