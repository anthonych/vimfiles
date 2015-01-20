" Author: Anthony Chen <anthonychen@gmail.com>
" Initial Date: 2013/10/30
" Last Update: 1.3 2015/01/20 fix scrollbar problem of Linux gui

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

" Manage vundle by vundle
Bundle 'gmarik/vundle'

" Snipmate budles {
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "garbas/vim-snipmate"            
    Bundle 'honza/vim-snippets'
"}

" NERDTree, a tree explorer plugin for vim.
Bundle 'scrooloose/nerdtree'            
" Automatically opens popup menu for completions.
" Bundle 'AutoComplPop'                   
" Lean & mean status/tabline for vim.
Bundle 'bling/vim-airline'              
" Make gvim-only colorschemes work transparently in terminal vim.
Bundle 'godlygeek/csapprox'            
" Fuzzy file, buffer, mru, tag, etc finder.
Bundle 'ctrlp.vim'                      
" Insert or delete brackets, parens, quotes in pair.
Bundle 'auto-pairs'                     
" Highlight colors in css files.
Bundle 'ap/vim-css-color'               
" A Git wrapper
Bundle 'tpope/vim-fugitive'   
" A autocompletion plugin for Python
" Bundle 'davidhalter/jedi-vim'
" A code-completion engine for Vim
Bundle 'Valloric/YouCompleteMe'


call vundle#end()
filetype on

"--------------------------------------------------------------
" ### General ###
"--------------------------------------------------------------
set nocompatible                        " Do not compatible with old vi mode
set backspace=indent,eol,start          " Allow backspacing over everything in insert mode
set history=1000                        " Command line history to remember
set lines=40 columns=120                " Default initial window size
set noerrorbells                        " Disable error sound
set novisualbell                        " Disable visual error effect

"--------------------------------------------------------------
" ### Appearance ###
"--------------------------------------------------------------
set cmdheight=1                         " Set command line height
set showmode                            " Show current mode
set showcmd                             " Show command line
set cursorline                          " Highlight current line
set laststatus=2                        " Display status line always

" GUI settings
if has("gui_running")
    set guioptions-=T                   " Remove toolbar
    set guioptions-=r                   " Remove right-hand scroll bar
    set guioptions-=L                   " Remove left vertically split scrollbar
    set guioptions-=l                   " Remove left scrollbar   
    set guioptions-=R                   " Remove right scrollbar 
    set guioptions-=r                   " Remove right vertically split scrollbar   
    set guioptions-=b                   " Remove buttom scrollbar 
    set guioptions-=h                   " Limit horizontal scrollbar size  
    set guitablabel=\[%N\]\ %t\ %M      " Setup tab title
    set background=dark                 " Backgroud style
    colorscheme atom-dark               " Color scheme

    " Platform specific gui settings {
        if has("gui_win32") || has("gui_win32s")
            set lines=30 columns=110            " Initial window size
            set guifont=Consolas:h12            " Windows font setting
        elseif has('unix')
            set lines=40 columns=120            " Initial window size
            set guifont=Ubuntu\ Mono\ 13        " Linux font setting
        endif
    "}
else
    " Terminal console settings
    set t_Co=256          " Use 256 colors
    set background=dark
    colorscheme atom-dark           " Color scheme
    set mouse=a
    set ttymouse=xterm2
endif

"--------------------------------------------------------------
" ### Edit ###
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
    set smartcase         " Use case-smart searching
"}

" Code folding {
    set foldmethod=syntax " Folding methods - manual/indent/syntax/expr/marker/diff
    set foldlevel=1000    " Default foldinf level
    set foldnestmax=2     " Deepest folding nest level
    set foldcolumn=3      " Sets the width for a column on left side to indicate folds
"}

" Word wrap {
    set wrap              " Visual word wrap
    set linebreak         " Wrap long lines at a character in 'breakat' 
" }

" Omni completion {
    set completeopt=longest,menu    " Not to select the first item
" }

"--------------------------------------------------------------
" ### Keymap ###
"--------------------------------------------------------------

" Tab {
    " Open tab
    map <C-t><C-t> :tabnew<CR>  
    " Close tab
    map <C-w><C-w> :tabclose<CR>
    " Next tab 
    map <C-l> :tabn<CR>
    " Previous tab
    map <C-h> :tabp<CR>
"}

" Copy&Paste {
    " Copy and go to insert mode immediately
    vmap <C-c> "+yi
    " Cut in visual mode
    vmap <C-x> "+c
    " Paste in visual mode
    vmap <C-v> c<ESC>"+p
    " Paste in visual mode
    imap <C-v> <C-r><C-o>+
"}

" Compile & Run {
"}

" Set Ctrl+E as NERDTree hot key
if has("gui_win32") || has("gui_win32s")
    map <silent> <C-E> :NERDTreeToggle D:\Projects\<CR>
elseif has('unix')
    map <silent> <C-E> :NERDTreeToggle $HOME/Projects<CR>
endif

"--------------------------------------------------------------
" ### Encoding ###
"--------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"--------------------------------------------------------------
" ### Plugin Settings ###
"--------------------------------------------------------------

" vim-airline settings
let g:airline_theme='wombat'

" NERDTree settings {
    let NERDTreeWinPos="left"           " Display NERDTree panel at left/right side
    let g:NERDTreeDirArrows=1           " Enable/disable directory arraows
    let NERDTreeShowBookmarks=1         " Show bookmarks by default
    let NERDTreeQuitOnOpen=1            " Quit on opening files from the tree
    let NERDTreeHighlightCursorline=1   " Highlight the selected entry in the tree
    let NERDTreeMinimalUI=0           " User minimal UI display

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

" YouCompleteMe settings {
    " Set the path of ycm_extra_config.py 
    let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm'
    " Enable auto complete in comments
    let g:ycm_complete_in_comments = 1
    " 
    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>','<Enter>']
"}

"--------------------------------------------------------------
"  ### Miscellaneous ###
"--------------------------------------------------------------

" Reload vimrc file automatically
autocmd! BufWritePost .vimrc,_vimrc,vimrc source $MYVIMRC

" Change working directory to current folder
set autochdir

"--------------------------------------------------------------
"  ### Customized Functions ###
"--------------------------------------------------------------

" Toggle netrw explorer
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            exec expl_win_num . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction


