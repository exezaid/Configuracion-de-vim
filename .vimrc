" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
"filetype off                    " force reloading *after* pathogen loaded
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title

set termencoding=utf-8
set encoding=utf-8

set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high

let mapleader=","
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=0            " start out with everything folded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()



if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}
    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/scripts/closetag.vim
    augroup end " }}}
    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=80
        autocmd filetype python match ErrorMsg '\%>80v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python map <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python imap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python map <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python imap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Run a quick static syntax check every time we save a Python file
        "autocmd BufWritePost *.py call Pyflakes()
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}
endif
" }}}

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$' ]

" }}}

filetype on  " Automatically detect file types.
filetype indent on
filetype plugin on
set nocompatible  " We don't want vi compatibility.
" Add recently accessed projects menu (project plugin)
set viminfo^=!
" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>
syntax enable
set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set wrap " Line wrapping on
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set incsearch "busqueda incremental (a medida que se escribe)
set hlsearch "resulados de busqudas resaltados
colorscheme delek  " Uncomment this to set a default theme

" Formatting (some of these are for coding in C and C++)
set ts=4  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=4  " Tabs under smart indent
set nocp incsearch
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab
set cursorline
set textwidth=80 "Genera un líneas de solo 80 caracteres máximos
"set fdm=indent

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
" Show $ at end of line and trailing space as ~
"set list
"set lcs=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set list listchars=tab:»»,trail:·
"set list lcs=tab:·⁖,trail:¶
" Quitar espacios al final de la linea
"autocmd BufWritePre * :%s/\s\+$//e
" Quitar tabs
"autocmd BufWritePre * retab
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
map <f10> :set paste<cr>
map <f11> :set nopaste<cr>

" Nuestros valores por defecto para el plugin Project
:let g:proj_flags="imstvcg"

" Pep 8 validator
noremap  <F6>  :call Pep8()<CR>

"tagbsearch  use binary searching in tags files
"set tbs
"set notbs

"tags list of file names to search for tags
"(global or local to buffer)
"set tag=./tags,./TAGS,tags,TAGS

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Common abbreviations / misspellings {{{
source ~/.vim/autocorrect.vim
" }}}

" Scratch
nmap <leader><tab> :Sscratch<CR><C-W>x<C-J>

" Thanks to Steve Losh for this liberating tip
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim
nnoremap / /\v
vnoremap / /\v

" Quick alignment of text
nmap <leader>al :left<CR>
nmap <leader>ar :right<CR>
nmap <leader>ac :center<CR>

" Dpaste 
map <leader>p :Dpaste<CR>

" Folding
nnoremap <Space> za
vnoremap <Space> za

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" YankRing stuff
let g:yankring_history_dir = '$HOME/.vim/.tmp'
nmap <leader>r :YRShow<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

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
map <c-pageup> :tabp<cr>
map <c-pagedown> :tabn<cr>

" Configuración del autocompletado inteligente (el de Python necesita un Vim
" compilado contra las librerías de Python para funcionar)
" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" Reduce number of entries found for speed
let g:fuzzy_ceiling = 40000

" Ignore vendor directory
let g:fuzzy_ignore = 'vendor/*'


" Lesscss files (*.less)
au BufNewFile,BufRead *.less set filetype=less

" Tabbing rules
"au BufRead *.rb set ts=2 sw=2 sts=2
au BufRead *.js set ts=4 sw=4 sts=4

" Let fugitive.vim show me git status
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P



"taglist
"set statusline=%<%f%=%([%{Tlist_Get_Tagname_By_Line()}]%)
"set title titlestring=%<%f\ %([%{Tlist_Get_Tagname_By_Line()}]%)

" Set font
set guifont=Bitstream_Vera_Sans_Mono:h12

" make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" Jump to the last position in the file on open
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
endif

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

" accesos directos para debugger
"map <F5> :Dbg over<CR>
"map <F6> :Dbg into<CR>
"map <F7> :Dbg out<CR>
"map <F8> :Dbg here<CR>
"map <F9> :Dbg break<CR>
"map <F10> :Dbg watch<CR>
"map <F11> :Dbg down<CR>
"map <F12> :Dbg up<CR>

" Colores y mas configuraciones del autocompletado
highlight Pmenu ctermbg=4 guibg=LightGray
" highlight PmenuSel ctermbg=8 guibg=DarkBlue guifg=Red
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
" use global scope search
let OmniCpp_GlobalScopeSearch = 1
" 0 = namespaces disabled
" 1 = search namespaces in the current buffer
" 2 = search namespaces in the current buffer and in included files
let OmniCpp_NamespaceSearch = 2
" 0 = auto
" 1 = always show all members
let OmniCpp_DisplayMode = 1
" 0 = don't show scope in abbreviation
" 1 = show scope in abbreviation and remove the last column
let OmniCpp_ShowScopeInAbbr = 0
" This option allows to display the prototype of a function in the abbreviation part of the popup menu.
" 0 = don't display prototype in abbreviation
" 1 = display prototype in abbreviation
let OmniCpp_ShowPrototypeInAbbr = 1
" This option allows to show/hide the access information ('+', '#', '-') in the popup menu.
" 0 = hide access
" 1 = show access
let OmniCpp_ShowAccess = 1

" This option can be use if you don't want to parse using namespace declarations in included files and want to add
" namespaces that are always used in your project.
let OmniCpp_DefaultNamespaces = ["std"]

" Complete Behaviour
let OmniCpp_MayCompleteDot = 0
let OmniCpp_MayCompleteArrow = 0
let OmniCpp_MayCompleteScope = 0
" When 'completeopt' does not contain "longest", Vim automatically select the first entry of the popup menu. You can
"change this behaviour with the OmniCpp_SelectFirstItem option.
let OmniCpp_SelectFirstItem = 0


"zencoding django-template
let g:user_zen_settings = {
\    'html' : {
\        'extends' : 'html',
\        'filters' : 'html',
\        'indentation' : '  '
\    },
\    'xml' : {
\        'extends' : 'html',
\    },
\    'haml' : {
\        'extends' : 'html',
\   },
\}

"If you want to complete tags using |ominifunc| then add this.
let g:use_zen_complete_tag = 1
"let g:user_zen_leader_key = '<c-e>'
"Or if you prefer to map for each actions, then you set each variables.
"    'user_zen_expandabbr_key'
"    'user_zen_expandword_key'
"    'user_zen_balancetaginward_key'
"    'user_zen_balancetagoutward_key'
"    'user_zen_next_key'
"    'user_zen_prev_key'
"    'user_zen_imagesize_key'
"    'user_zen_togglecomment_key'
"    'user_zen_splitjointag_key'
"    'user_zen_removetag_key'
"    'user_zen_anchorizeurl_key'
"    'user_zen_anchorizesummary_key'

let g:user_zen_expandabbr_key = '<c-e>'
