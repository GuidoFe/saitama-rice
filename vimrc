" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ap/vim-css-color'
Plugin 'chriskempson/base16-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'reedes/vim-pencil'
Plugin 'lervag/vimtex'
" Emmet-vim is a vim plug-in which provides support for expanding abbreviations similar to emmet.
Plugin 'mattn/emmet-vim'
" A Vim plugin which shows a git diff in the 'gutter' (sign column). It shows which lines have been added, modified, or removed. You can also preview, stage, and undo individual hunks. The plugin also provides a hunk text object.
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'

Plugin 'plasticboy/vim-markdown'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'pangloss/vim-javascript'
Plugin 'vimwiki/vimwiki'



call vundle#end()            " required
filetype plugin indent on    " required
" Attempt to determine the type of a file based on its name and possibly itPlugin 'reedes/vim-pencil's contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
set t_Co=256
" Enable syntax highlighting
syntax on
let base16colorspace=256 
colorscheme base16-gruvbox-dark-soft
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
" set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
" set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
" set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
"set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
" set pastetoggle=<F11>
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>
" 
" Set yank register to "+, the same of X buffer

set clipboard=unnamedplus

" Set text wrap

set linebreak
set breakindent

" Spell checking for tex and md
"
autocmd FileType tex setlocal spell spelllang=en,it
autocmd FileType md setlocal spell spelllang=en,it

" Cursor appear in the previous session position

augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
