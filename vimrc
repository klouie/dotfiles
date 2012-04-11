" NOTICE! The vimpagerrc file is a subset of this, please check that
"         what is being changed here is updated there if it exists.

set nocompatible

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

let mapleader = ","

set backspace=indent,eol,start
set hidden
set laststatus=2
set nowrap
set number
set ruler
set scrolloff=3
set showcmd
set splitbelow splitright
set wildignore+=*.class,*.o,.git,*/tmp/**

" Store backup & swap files elsewhere to avoid directory pollution
set backupdir=~/.vim/tmp,/tmp
set directory=~/.vim/tmp,/tmp

" Write all writeable buffers when changing buffers or losing focus.
autocmd FocusLost * silent! wall
set autowriteall

" ...but not for fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Search settings
set ignorecase
set incsearch
set smartcase

" Indentation settings (soft tabs, two spaces)
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set tabstop=4
set list listchars=tab:»·,trail:·
filetype plugin indent on

" Persistent undo
if(has("persistent_undo"))
  set undodir=~/.vim/undo
  set undofile
  set undolevels=1000
endif

if has('gui_running') || $TERM_PROGRAM != 'Apple_Terminal'
  set background=dark
  colorscheme solarized
endif

" Highlight if there is color
if(&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  nnoremap <silent> <leader>h :set hlsearch!<CR>
endif

" Copy current file path to system pasteboard.
if(has("macunix"))
  map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
elseif(has("unix") || has("win32"))
  map <silent> <C-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
endif

" Paste yanked text in command mode
if(has("macunix"))
  cnoremap <D-C> <C-R>"
endif

" Toggle spell check
map <leader>ss :setlocal spell!<cr>

" Make Y consistent with D and C.
map Y y$

" Indent/unindent visual mode selection with tab/shift+tab
vmap <tab> >gv
vmap <s-tab> <gv

" CtrlP
let g:ctrlp_max_height=20
let g:ctrlp_match_window_reversed=0
let g:ctrlp_use_caching=0
map <D-N>     :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <D-e>     :CtrlPBuffer<CR>
map <leader>e :e#<CR>

" Gundo
nnoremap <leader>u :GundoToggle<CR>

" NERDCommenter
let NERDSpaceDelims = 1
map <leader>/ <plug>NERDCommenterToggle

" NERDTree
map \ :NERDTreeToggle<CR>
map \| :NERDTreeFind<CR>

" Syntastic
let g:syntastic_enable_signs=1

" Tlist
map <leader>l :TlistToggle<CR>

" ZoomWin
map <leader>z :ZoomWin<CR>

" Delete trailing whitespace
func! DeleteTrailingWhitespace()
  exec "normal mZ"
  %s/\s\+$//e
  exec "normal `Z"
endfunc
autocmd BufWritePre *.{c,cpp,h,hpp,m,mm} :call DeleteTrailingWhitespace()
autocmd BufWritePre *.{erb,feature,haml,rb,yml} :call DeleteTrailingWhitespace()
autocmd BufWritePre *.{css,html,js,json,less,sass,xml} :call DeleteTrailingWhitespace()
autocmd BufWritePre *.{java,php} :call DeleteTrailingWhitespace()

" Associate some filetypes with their proper syntax
autocmd BufRead,BufNewFile *.applescript set filetype=applescript
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.txt set filetype=text

autocmd FileType scss set iskeyword=@,48-57,_,-,?,!,192-255

" Enable soft-wrapping for text files
autocmd FileType eruby,html,markdown,text,xhtml setlocal wrap linebreak nolist

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC
augroup END

if filereadable($HOME . "/.vimrc_local")
  source ~/.vimrc_local
endif
