"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'

" UI / IDE Features
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'xolox/vim-session'

" Text editing
NeoBundle 'jiangmiao/auto-pairs.git'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'roryokane/detectindent'
NeoBundle 'vim-scripts/DeleteTrailingWhitespace'

" Colors
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jordwalke/flatlandia'
NeoBundle 'farseer90718/flattr.vim'
NeoBundle 'blerins/flattown'
NeoBundle 'abra/vim-abra'
NeoBundle 'penicolas/simplon.vim'
NeoBundle 'vyshane/vydark-vim-color'

" Languages
NeoBundle 'cespare/vim-toml'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'tpope/vim-git'
" NeoBundle 'wting/rust.vim'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'kchmck/vim-coffee-script'

" Misc
NeoBundle 'xolox/vim-misc'

" You can specify revision/branch/tag.
" NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

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
colorscheme abra
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

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" dont open nerdtree if given arguments
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree ~/Development | endif

" close nerdtree if only buffer left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Sesssion management
let g:session_autosave = 'no'

" Completion
let g:racer_cmd = '~/Development/Rust/racer/bin/racer'
" set omnifunc=syntaxcomplete#Complete

" Auto pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', '`':'`'}

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|public'

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
