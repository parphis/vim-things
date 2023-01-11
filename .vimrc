" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.
set nocompatible              " be iMproved, required

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

function! GitBranch()
  let l:branchname = trim(system("git -C . branch 2>/dev/null"))
  return strlen(l:branchname) > 0 ? ' |'.l:branchname.'| ':'|- No Git -|'
endfunction

let mapleader="-"
let maplocalleader="--"

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

packloadall

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		        " Show (partial) command in status line.
set showmatch		    " Show matching brackets.
set ignorecase		    " Do case insensitive matching
"set smartcase		    " Do smart case matching
set smarttab            " Autotabs for certain code
set incsearch		    " Incremental search
set autowrite		    " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		    " Enable mouse usage (all modes)
set ruler               " Always shows locatzion in file
set encoding=utf-8      " Always use UTF8
set fileencoding=utf-8  " Alwys use UTF8
set shiftwidth=4        " Pythonic tab size
set tabstop=4           " Pythonic tab size
set expandtab           " Insert spaces instead of TABs

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

"" Keyboundings
" tabs open/move
noremap <F10> :tabe<CR>
noremap <F7> :tabp<CR>
noremap <F8> :tabn<CR>
inoremap <F10> <esc>:tabe<CR>
inoremap <F7> <esc>:tabp<CR>
inoremap <F8> <esc>:tabn<CR>

" save all buffer and quit
inoremap <F12> <esc>:wqa<CR>
noremap <F12> :wqa<CR>

" quit from all buffers without save and question
inoremap <c-q> <esc>:qa!<CR>
noremap <c-q> :qa!<CR>

" map <F11> :mksession ./cs.vim<CR>
noremap <F5> :source ./cs.vim<CR>

"" Plugins
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

"Bundle 'farseer90718/vim-taskwarrior'

" Twig
"Plugin 'nelsyeung/twig.vim'

" Python autocomplete
"Plugin 'davidhalter/jedi-vim'

" Markdown, https://github.com/plasticboy/vim-markdown
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'

"Plugin 'alvan/vim-closetag'

" All of your Plugins must be added before the following line
"call vundle#end()            " required

:autocmd BufNewFile,BufRead * let g:git_branch_info = GitBranch()

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"" Status line things
au InsertEnter * hi statusline guifg=#adadad guibg=#4e4e4e ctermfg=9 ctermbg=15
au InsertLeave * hi statusline guifg=#303030 guibg=#303030 ctermfg=233 ctermbg=28

hi statusline guifg=#adadad guibg=#4e4e4e ctermfg=233 ctermbg=28
hi User1      guifg=#000000 guibg=#000000 ctermfg=007 ctermbg=016
hi User2      guifg=#adadad guibg=#4e4e4e ctermfg=015 ctermbg=239

" Status line
" default: set statusline=%f\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Status Line Custom
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
set noshowmode
set statusline=
set statusline+=%0*\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=%1*\ %{g:git_branch_info}                " Git branch info
set statusline+=%2*\ %<%F%m%r%h%w\                       " File path, modified, readonly, helpfile, preview
set statusline+=%=                                       " Right Side
set statusline+=%1*\ %l:%v(%p%%\ %L)\                    " Colomn number


"" Miscs
" open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" Pretty format XML documents
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" change colors because the vimdiff is so unreadable
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
