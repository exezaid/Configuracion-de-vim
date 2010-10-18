filetype on  " Automatically detect file types.
filetype indent on
filetype plugin on
set nocompatible  " We don't want vi compatibility.
"helptags $HOME/.vim/doc

set background=dark
colorscheme delek

" Add recently accessed projects menu (project plugin)
set viminfo^=!

" Minibuffer Explorer Settings
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1



" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

syntax enable

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set wrap " Line wrapping on
"set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set incsearch "busqueda incremental (a medida que se escribe)
set hlsearch "resulados de busquedas resaltados
"colorscheme vividchalk  " Uncomment this to set a default theme

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
set cursorline
set textwidth=80 "Genera un líneas de solo 80 caracteres máximos

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
" Show $ at end of line and trailing space as ~
"set list
set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" gvim specific
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

" Backups & Files
"set backup                     " Enable creation of backup file.
"set backupdir=~/.vim/backups " Where backups will go.
"set directory=~/.vim/tmp     " Where temporary files will go.

" F10 activa modo pegar (no autoindenta, no descoloca lo que pegamos), F11
" lo desactiva
map <f10> :set paste</f10></cr><cr>
map <f11> :set nopaste</f11></cr><cr>

" Nuestros valores por defecto para el plugin Project
:let g:proj_flags="imstvcg"

" Colores que no te dejan ciego (al gusto del consumidor, se puede escribir
" :color e ir dando a tab para ver las combinaciones existentes, hay más en
" vim.org)
colors torte

" Que no haga la ventana de gvim demasiado pequeña
au GUIEnter * set lines=35 columns=110

" Plugin taglist
" Taglist variables
" Display function name in status bar:
let g:ctags_statusline=1
" Automatically start script
let generate_tags=1
" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0
" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>
" Various Taglist diplay config:
" Poner el frame en la derecha que el Project ya lo pone a la izquierda
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1
" Tamaño mínimo de frame de tags
let Tlist_WinWidth = 40



" Buffer explorer con F4
"map <f4> \be "si descomenta esta linea comentar los tags

" Activar navegador de archivos
map <F3> :NERDTreeToggle<CR>

" Cerrar sola ventana de ayuda de completado
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" acceso directo para autocompletado
imap <C-J> <C-X><C-O>

" Mostrar lista de todo's
map <F2> :TaskList<CR>

" Atajos para pestañas como los de Firefox/Chrome/Opera/etc
" Control T nueva pestaña (la cerramos con :q)
map <c-t> <esc>:tabnew<cr>
" Control PageUp/PageDown cambiar de pestaña
map <c-pageup> :tabp</c-pageup></cr><cr>
map <c-pagedown> :tabn</c-pagedown></cr><cr>

" Configuración del autocompletado inteligente (el de Python necesita un Vim
" compilado contra las librerías de Python para funcionar)
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"let g:pydiction_location = '/home/ezequiel/.vim/after/ftplugin/pydiction/complete-dict'


" Colores y mas configuraciones del autocompletado
"highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
" use global scope search
"let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
"let OmniCpp_NamespaceSearch = 2
" 0 = auto
" 1 = always show all members
"let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
"let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
"let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
"let OmniCpp_ShowAccess = 1
" This option can be use if you don't want to parse using namespace declarations in included files and want to add
" namespaces that are always used in your project.
"let OmniCpp_DefaultNamespaces = ["std"]
" Complete Behaviour
"let OmniCpp_MayCompleteDot = 0
"let OmniCpp_MayCompleteArrow = 0
"let OmniCpp_MayCompleteScope = 0
" When 'completeopt' does not contain 'longest', Vim automatically select the first entry of the popup menu. You can
"change this behaviour with the OmniCpp_SelectFirstItem option.
"let OmniCpp_SelectFirstItem = 0

"--------------Rails
" FuzzyFinderTexmate Options
" --------------------------
" Reduce number of entries found for speed
"let g:FuzzyFinderOptions.Base.enumerating_limit = 25
" Increase number of files FuzzyFinder can load
let g:fuzzy_ceiling = 40000

" Ignore vendor directory
let g:fuzzy_ignore = 'vendor/*'

" Remove all trailing whitespaces when saving a file
autocmd BufWritePre * :%s/\s\+$//e

" Lesscss files (*.less)
au BufNewFile,BufRead *.less set filetype=less

" Tabbing rules
au BufRead *.rb set ts=2 sw=2 sts=2
au BufRead *.js set ts=4 sw=4 sts=4

" Let fugitive.vim show me git status
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Disable rails.vim abbreviations
let g:rails_abbreviations=0

" FuzzyFinder Textmate
" (backslash)t
map <Leader>r :FuzzyFinderTextMate<CR>

" PeepOpen
map <Leader>t <Plug>PeepOpen

" Set font
"set guifont=ProFontX:h9
"set guifont=Menlo:h11
"set guifont=Bitstream_Vera_Sans_Mono:h11
set guifont=Bitstream_Vera_Sans_Mono:h12

" make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" Jump to the last position in the file on open
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

""""""""""""
" Mappings "
""""""""""""

" Allow for Command + < to pring out <%= x %> with the cursor
" set at "x"
"imap <D-lt> <%=  %><Esc>hhi

"fu! AddOutputERB()
"  execute "normal \<Esc>a<%=  %>\<Esc>hh"
"  execute "startinsert"
"endf

fu! AddERB()
  execute "normal \<Esc>a<% %>\<Esc>hh"
  execute "startinsert"
endf

imap <D-lt> <Esc>:call AddERB()<CR>
imap <D->> <C-x>/

" Map TextMate indent keys with vim
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv
""""""""""""""""""""""""""""""""""""""""""""""""""
" Snipmate with AutoComplPop(acp)                "
"""""""""""""""""""""""""""""""""""""""""""""""""
let g:acp_behaviorSnipmateLength = 1
let g:acp_ignorecaseOption = 0
