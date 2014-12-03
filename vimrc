" Author: Anthony Chen
" Date: 2013/10/30
" Version: 1.2 2014/12/03

"--------------------------------------------------------------
" ### Runtime settings ###
"--------------------------------------------------------------
" Setup runtimepath for Windows
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Install vundle plugin automatically
let iCanHazVundle=1
let vundle_readme=expand('$HOME/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    if has('win32') || has('win64')
        silent !mkdir -p \%HOMEPATH\%/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle \%HOMEPATH\%/.vim/bundle/vundle
    else
        silent !mkdir -p $HOME/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
    endif
    let iCanHazVundle=0
endif

"--------------------------------------------------------------
" ### Vundle ###
"--------------------------------------------------------------
set nocompatible " be iMproved
filetype off " required!

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/vundle
call vundle#begin()

" bundles
Bundle 'gmarik/vundle'

" Snipmate budles {
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "garbas/vim-snipmate"
    Bundle 'honza/vim-snippets'
"}

Bundle 'scrooloose/nerdtree'
Bundle 'AutoComplPop'
Bundle 'bling/vim-airline'
"Bundle 'supertab'
Bundle 'godlygeek/csapprox'
Bundle 'ctrlp.vim'
Bundle 'auto-pairs'

call vundle#end()
filetype on

"--------------------------------------------------------------
" ### General ###
"--------------------------------------------------------------
set nocompatible                    " Do not compatible with old vi mode
set backspace=indent,eol,start      " Allow backspacing over everything in insert mode
set history=1000                     " Command line history to remember
set lines=40 columns=120            " Initial window size

"--------------------------------------------------------------
" ### Appearance ###
"--------------------------------------------------------------
set cmdheight=1                     " Set command line height
set showmode                        " Show current mode
set showcmd
set cursorline                      " Highlight current line
set laststatus=2                    " Display status line always

if has("gui_running")               " GUI color and font settings
    set guioptions-=T               " Remove toolbar
    set guioptions-=r               " Remove right-hand scroll bar
    set guitablabel=\[%N\]\ %t\ %M  " Setup tab title
    set background=dark             " Backgroud style
    colorscheme atom-dark           " Color scheme

    " Copy&Paste {
        nmap <C-V> "+gP
        imap <C-V> <ESC>"+gpa
        vmap <C-C> "+y
    "}

    " Font settings {
        if has("gui_win32") || has("gui_win32s")
            set guifont=Consolas:h12
        elseif os == 'Linux'
            set guifont=Ubuntu\ Mono\ 13
        endif
    "}
else
    " terminal color settings
    set t_Co=256          " Use 256 colors
    set background=dark
    set mouse=a
    set ttymouse=xterm2
endif

"--------------------------------------------------------------
" ### Editing ###
"--------------------------------------------------------------
syntax on
filetype on               " Filetype detection
filetype plugin on        " Filetype plugin
set nobackup              " No backup
set noswapfile            " No swap file
set autoread              " Auto reload when file is changed from outside
set showmatch             " Show matching brackets when cursor is over
set number                " Display line number
set hidden                " Hide buffers instead of closing them

" Indentation {
    set autoindent        " auto indentation
    set copyindent        " copy the previous indentation on autoindenting
    set smartindent       " Smart indentation
"}

" TAB settings {
    set expandtab         "replace <TAB> with spaces
    set softtabstop=4
    set shiftwidth=4
"}

" Search settings {
    set nohlsearch        " No highlight search
    set incsearch         " Incremental search
    set ignorecase        " Ignore case when searching
    set smartcase         " Use case-smart searching
"}


" Code folding {}
    set foldmethod=syntax " Folding methods - manual/indent/syntax/expr/marker/diff
    set foldlevel=1000    " Default foldinf level
    set foldnestmax=2     " Deepest folding nest level
    set foldcolumn=3      " Sets the width for a column on left side to indicate folds
"}

"--------------------------------------------------------------
" ### keymap ###
"--------------------------------------------------------------

" New/Close tab {
    map <C-t><C-t> :tabnew<CR>
    map <C-t><C-w> :tabclose<CR>
"}

" Copy&Paste {
    nmap <C-V> "+gP
    imap <C-V> <ESC>"+gpa
    vmap <C-C> "+y
"}

" Set F2 as NERDTree hot key
nnoremap <silent> <F2> :NERDTree<CR>

"--------------------------------------------------------------
" ### Encoding ###
"--------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"--------------------------------------------------------------
"  ### Miscellaneous ###
"--------------------------------------------------------------

" Reload vimrc file automatically
autocmd! BufWritePost .vimrc,_vimrc,vimrc source $MYVIMRC

" vim-airline settings
let g:airline_theme='wombat'

" NERDTree settings {
    let NERDTreeWinPos="left"           " Display NERDTree panel at left/right side
    let g:NERDTreeDirArrows=1           " Enable/disable directory arraows
    let NERDTreeShowBookmarks=1         " Show bookmarks by default
    let NERDTreeQuitOnOpen=1            " Quit on opening files from the tree
    let NERDTreeHighlightCursorline=1   " Highlight the selected entry in the tree
    let NERDTreeMinimalUI = 0           " User minimal UI display

    " Single click to fold/unfold folders and double click to open files
    let NERDTreeMouseMode=2

    " Don't display these files
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
                         \ '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$',
                         \ '\~$']

    " Bookmark file location
    let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"}
