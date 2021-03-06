"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                preamble                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

let $LANG = 'en'      "set message language
set langmenu=en       "set menu's language of gvim
set encoding=utf-8

" Needed for vundle, will be turned on after vundle inits
filetype off

" Setup vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Vundle configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These need to come before the configuration options for the plugins since
" vundle will add the plugin folders to the runtimepath only after it has seen
" the plugin's Plugin command.

Plugin 'gmarik/Vundle.vim'
Plugin 'kirtgoh/vim-cpp-syntax'
Plugin 'kirtgoh/vim-kgoh-colorscheme'
" vim-ariline needed to show git branch
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'FSwitch'
Plugin 'YankRing.vim'
if has("win32")
" YouCompleteMe for windows
" Taken form https://bitbucket.org/Haroogan/vim-youcompleteme-for-windows/src
" For more info, see: https://github.com/Valloric/YouCompleteMe/wiki/Windows-Installation-Guide
  Plugin 'kirtgoh/vim-ycm-windows'
else
  Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'gerw/vim-HiLinkTrace'
Plugin 'Rykka/colorv.vim'
Plugin 'godlygeek/tabular'
Plugin 'derekwyatt/vim-protodef'
Plugin 'tomtom/tcomment_vim'
" requires compilation
" For windows, the name of the DLL must match the Ruby version Vim was compiled with
Plugin 'wincent/Command-T'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/ListToggle'
" Seems more active than perl-based latexmk
"Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'majutsushi/tagbar'
Plugin 'Rename'
Plugin 'sjl/gundo.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        turn on filetype plugins                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call vundle#end()
" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Home away from home. We store some config files and snippets here and the
" whole dotfiles dir is a git repo. Should be the last entry in rtp (for
" UltiSnips).
set rtp+=$HOME/dotfiles/vim

" DISPLAY SETTINGS
if has("gui_running")
  winpos 325 235
  set lines=40 columns=160
endif

colorscheme kgoh	" sets the colorscheme
set background=light	" enable for light terminals
set t_Co=256		" enable 256 color terminals
set laststatus=2	" the statusline is now always shown
set number		" enable line numbers
set noshowmode          " no show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set cursorline          " highlights the current line
set hlsearch		" highlights the search word

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif


" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu
" This changes the default display of tab and CR chars in list mode
" but symbols below does not display correctly in win7
if has("win32")
else
  set listchars=tab:▸\ ,eol:¬
endif

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" no set, no difference ?
" set autoindent          " on new lines, match indent of previous line
"set copyindent          " copy the previous indentation on autoindenting
" set cindent             " smart indenting for c-like code
"set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
"set softtabstop=2
"set shiftround          " makes indenting a multiple of shiftwidth
" set expandtab           " turn a tab into spaces

" misc settings
set foldmethod=marker
set foldmarker={,}

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=80

" turns on spell checkout when edit tex file
autocmd BufNewFile,BufRead *.tex set spell

" We want our cross-machine spell file to be used
set spellfile=$HOME/dotfiles/vim/spell/en.latin1.add

" vim latex type is plaintex 
let g:tex_flavor='latex'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            custom mappings                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" our <leader> will be the space key
let mapleader=","

" key bindings for quickly moving between windows
" h left, l right, k up, j down
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" key bindings for quickly moving between buffers
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>l :bnext<cr>

" with this, we can now type "jk" to exit out of insert mode
" if we really wanted to type "jk" then just type one char, wait half a sec,
" type another
inoremap jk <Esc>
vnoremap jk <Esc>

" Toggle and untoggle spell checking
noremap <leader>ss :setlocal spell! spelllang=en_us<cr>

" spelling shortcuts using <leader>
" ]s next misspelled word
" [s previous misspelled word
" zg add to dict
" z= get suggestions
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>su z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Airline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" symbols does not diaplsy correctly in win7
if has("win32")
else
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.branch = '⎇'
  ""let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  ""let g:airline_symbols.paste = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
endif

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nnoremap <leader>bl :ls<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               easymotion                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_leader_key = '<Leader>e'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                fswitch                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch to the file and load it into the current window
nnoremap <silent> <Leader>oh :FSHere<cr>
" Switch to the file and load it into the window on the right
nnoremap <silent> <Leader>or :FSRight<cr>
" Switch to the file and load it into a new window split on the right
nnoremap <silent> <Leader>oR :FSSplitRight<cr>
" Switch to the file and load it into the window on the left
nnoremap <silent> <Leader>ol :FSLeft<cr>
" Switch to the file and load it into a new window split on the left
nnoremap <silent> <Leader>oL :FSSplitLeft<cr>
" Switch to the file and load it into the window above
nnoremap <silent> <Leader>ot :FSAbove<cr>
" Switch to the file and load it into a new window split above
nnoremap <silent> <Leader>oT :FSSplitAbove<cr>
" Switch to the file and load it into the window below
nnoremap <silent> <Leader>ob :FSBelow<cr>
" Switch to the file and load it into a new window split below
nnoremap <silent> <Leader>oB :FSSplitBelow<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Gundo                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" f5 toggles the Gundo plugin window
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                yankring                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:yankring_history_dir = '$HOME/tmp/vim'
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
nnoremap <leader>r :YRShow<CR>

" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                ListToggle                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lt_location_list_toggle_map = '<leader>L'
let g:lt_quickfix_list_toggle_map = '<leader>q'

let g:lt_height = 10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--select=F,C9 --max-complexity=10'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              YouCompleteMe                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" global c++ compile flags config
if has("win32")
  let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/vim-ycm-windows/third_party/ycmd/cpp/.ycm_extra_conf.py'
else
  let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/.ycm_extra_conf.py'
endif

let g:ycm_warning_symbol = '*>'
let g:ycm_confirm_extra_conf = 0

let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1

let g:ycm_always_populate_location_list = 1
"let g:ycm_collect_identifiers_from_tags_files = 1

nnoremap <leader>y :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader><leader>d :YcmCompleter GoToDefinition<CR>
nnoremap <leader><leader>c :YcmCompleter GoToDeclaration<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                UltiSnips                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsSnippetsDir         = $HOME . '/dotfiles/vim/UltiSnips'
let g:UltiSnipsExpandTrigger       = "<c-l>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            latex-live-preview                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
  let g:livepreview_previewer = 'D:\CTEX\CTeX\ctex\bin\SumatraPDF.exe'
else
  let g:livepreview_previewer = 'evince'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                tagbar                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_left = 1
let g:tagbar_sort = 0
if has("gui_macvim")
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif

nnoremap <F4> :TagbarToggle<cr><c-w>=

