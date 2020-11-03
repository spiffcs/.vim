"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Maintainer:
"    Christopher Phillips - @spiffcs
"
"
" Sections:
"    -> Plugins
"    -> General
"    -> VIM UX
"    -> Colors and Fonts
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto install vim-plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a director for plugins
" - For Neovim: ~/.vim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set line numbers in file
set number
set numberwidth=1

" turn hybrid line numbers on
set number relativenumber
set nu rnu

" With a mapleader it is possible to do extra key combinations
" EX: <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UX
""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Ignore case when searching, hilight results
set ignorecase
set smartcase
set hlsearch
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indivator is over them
set showmatch
set mat=2

""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set termguicolors
set background=dark
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try 
    colorscheme gruvbox
catch
endtry

" Set utf8 as the standard encoding
set encoding=utf8
