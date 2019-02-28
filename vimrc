" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " load pathogen
  execute pathogen#infect()
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  " enable syntax highlighting
  syntax on
  " Insert shebang in new .sh files.
  autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\"|$
else
  set autoindent " always set autoindenting on
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Hybrid line numbering
set number relativenumber

" Highlight search
set hlsearch

" Disable arrow keys in normal mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Set comment string for csv files
:let g:csv_comment = '#'

" Show column in statusline with csv files
function MySTL()
  if has("statusline")
    hi User1 term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
    let stl = ...
    if exists("*CSV_WCol")
      let csv = '%1*%{&ft=~"csv" ? CSV_WCol() : ""}%*'
    else
      let csv = ''
    endif
      return stl.csv
    endif
endfunc
set stl=%!MySTL()

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit

