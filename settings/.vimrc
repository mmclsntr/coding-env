"*****************************************************************************
" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        \ >/dev/null 2>&1
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"*****************************************************************************
" Plug install packages
"*****************************************************************************
call plug#begin(expand('~/.vim/plugged'))

" Visual
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icon
Plug 'ryanoasis/vim-devicons'

" Indent line
Plug 'Yggdroot/indentLine'

" Polyglot
Plug 'sheerun/vim-polyglot'

" Color Scheme
Plug 'tomasr/molokai'

" fern vim
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Buffer kill
Plug 'qpkorr/vim-bufkill'

" Alter command
Plug 'kana/vim-altercmd'

" Outline view
Plug 'liuchengxu/vista.vim'


" LSP
Plug 'prabirshrestha/vim-lsp'

" popup and help
Plug 'matsui54/denops-signature_help'
Plug 'matsui54/denops-popup-preview.vim'

" ddc.vim本体
Plug 'Shougo/ddc.vim'
" Deno plugin
Plug 'vim-denops/denops.vim'
" ポップアップウィンドウを表示するプラグイン
Plug 'Shougo/pum.vim'
Plug 'Shougo/ddc-ui-pum'

" カーソル周辺の既出単語を補完するsource
Plug 'Shougo/ddc-around'
" ファイル名を補完するsource
Plug 'LumaKernel/ddc-file'
" Lsp source
Plug 'shun/ddc-source-vim-lsp'

" 入力中の単語を補完の対象にするfilter
Plug 'Shougo/ddc-matcher_head'
" 補完候補を適切にソートするfilter
Plug 'Shougo/ddc-sorter_rank'
" 補完候補の重複を防ぐためのfilter
Plug 'Shougo/ddc-converter_remove_overlap'


call plug#end()

filetype plugin indent on


"*****************************************************************************
" Function
"*****************************************************************************

" Install check
function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction


" save session
function Save_session()
    mksession! ~/.vim/.session
endfunction

" restore session
function Restore_session()
    if filereadable(expand("~/.vim/.session"))
        source ~/.vim/.session
    endif
endfunction

"*****************************************************************************
" Basic Setup
"*****************************************************************************

" Encoding
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf8
set bomb
set binary
set ttyfast
set mouse-=a
set ttymouse=xterm2

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set indentexpr=

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" Copy/Paste/Cut
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Map leader to ,
let mapleader = "\<Space>"
nnoremap <Leader>a :echo "Hello"<CR>

" message
set shortmess+=F

" Buffers
set hidden
set nobackup
set noswapfile
set noundofile
set autoread

set fileformats=unix,dos,mac
set wildmenu wildmode=full

" Disable visualbell
set belloff=all
set noerrorbells

" Cursor
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

"*****************************************************************************
" Visual Settings
"*****************************************************************************
syntax on
set synmaxcol=320
set ruler
set number
set re=0

" Color 256
set t_Co=256
if !exists('g:not_finish_vimplug')
    colorscheme murphy
endif

" Scroll offset.
set scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

" VirtualEdit
set virtualedit=onemore

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" conceal
set conceallevel=0
let g:vim_json_syntax_conceal = 0

" tab, whitespace highlight
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" zenkaku whitespace highlight
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

"*****************************************************************************
" Autocmd Rules
"*****************************************************************************
" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=1000
augroup END

augroup vimrc-highlight
  autocmd!
  autocmd Syntax * syntax sync minlines=1000
augroup END

" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"Grep vim
augroup GrepCmd
    autocmd!
    autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
augroup END

" Save undo
if has('persistent_undo')
  set undodir=./.vimundo,~/.vimundo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

" Session
augroup SessionAutocommands
    autocmd!
    autocmd VimLeave * call Save_session()
augroup END

"*****************************************************************************
" Abbreviations
"*****************************************************************************
" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"*****************************************************************************
" Plugin configuration
"*****************************************************************************

if s:is_plugged("indentLine")
    " IndentLine
    let g:indentLine_enabled = 1
    let g:indentLine_char = '¦'
    let g:indentLine_faster = 1
endif

if s:is_plugged("fern.vim")
    " fern.vim
    let g:fern#renderer = 'nerdfont'
    let g:fern#disable_drawer_auto_quit = 1
    let g:fern#default_hidden = 1
    nnoremap <leader>e :Fern . -reveal=% -drawer -toggle -width=40<CR>

    function! s:init_fern() abort
      setlocal nonumber
      " Use 'select' instead of 'edit' for default 'open' action
      nmap <buffer><expr>
            \ <Plug>(fern-my-open-expand-collapse)
            \ fern#smart#leaf(
            \   "\<Plug>(fern-action-open:select)",
            \   "\<Plug>(fern-action-expand)",
            \   "\<Plug>(fern-action-collapse)",
            \ )
      nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
      nmap <buffer> a <Plug>(fern-action-new-path)
      nmap <buffer> A <Plug>(fern-action-choice)
      nmap <buffer> d <Plug>(fern-action-remove)
      nmap <buffer> <Backspace> <Plug>(fern-action-collapse)
      nmap <buffer> r <Plug>(fern-action-move)
      nmap <buffer> R <Plug>(fern-action-reload)
      nmap <buffer> <nowait> i <Plug>(fern-action-hidden:toggle)
      nmap <buffer> c <Plug>(fern-action-clipboard-copy)
      nmap <buffer> p <Plug>(fern-action-clipboard-paste)
    endfunction

    augroup fern-custom
      autocmd! *
      autocmd FileType fern nested call s:init_fern()
    augroup END

    augroup my-glyph-palette
      autocmd! *
      autocmd FileType fern call glyph_palette#apply()
      autocmd FileType nerdtree,startify call glyph_palette#apply()
    augroup END

endif

" bufkill
if s:is_plugged("vim-altercmd")
    " Mappings
    autocmd VimEnter * AlterCommand bun BUN
    autocmd VimEnter * AlterCommand bd BD
    autocmd VimEnter * AlterCommand bw BW
    autocmd VimEnter * AlterCommand BD bd
    autocmd VimEnter * AlterCommand BW bw
    autocmd VimEnter * AlterCommand BUN bun

    "" Buffer nav
    noremap <leader>p :bp<CR>
    noremap <leader>n :bn<CR>
    "" Close buffer
    noremap <leader>c :BW<CR>
endif


" LSP
if s:is_plugged("vim-lsp")

    " nodejs
    if executable('typescript-language-server')
        au User lsp_setup call lsp#register_server({
          \ 'name': 'javascript support using typescript-language-server',
          \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
          \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
          \ })
    endif

    " python
    if executable('pyls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': {server_info->['pyls']},
            \ 'whitelist': ['python'],
            \ })
    endif

    " golang
    if executable('gopls')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-remote=auto']},
            \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
            \ })
        autocmd BufWritePre *.go
            \ call execute('LspDocumentFormatSync') |
            \ call execute('LspCodeActionSync source.organizeImports')
    endif

    " java
    if executable('java') && filereadable(expand('~/javalsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'))
        au User lsp_setup call lsp#register_server({
            \ 'name': 'eclipse.jdt.ls',
            \ 'cmd': {server_info->[
            \     'java',
            \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            \     '-Dosgi.bundles.defaultStartLevel=4',
            \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
            \     '-Dlog.level=ALL',
            \     '-noverify',
            \     '-Dfile.encoding=UTF-8',
            \     '-Xmx1G',
            \     '-jar',
            \     expand('~/javalsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'),
            \     '-configuration',
            \     expand('~/lsp/eclipse.jdt.ls/config_linux'),
            \     '-data',
            \     getcwd()
            \ ]},
            \ 'whitelist': ['java'],
            \ })
    endif

    " html
    if executable('vscode-html-language-server')
      au User lsp_setup call lsp#register_server({
        \ 'name': 'vscode-html-language-server',
        \ 'cmd': {server_info->['vscode-html-language-server', '--stdio']},
        \ 'whitelist': ['html'],
      \ })
    endif

    " css
    if executable('vscode-css-language-server')
      au User lsp_setup call lsp#register_server({
        \ 'name': 'vscode-css-language-server',
        \ 'cmd': {server_info->['vscode-css-language-server', '--stdio']},
        \ 'whitelist': ['css', 'less', 'sass', 'scss'],
      \ })
    endif

    " json
    if executable('vscode-jss-language-server')
      au User lsp_setup call lsp#register_server({
        \ 'name': 'vscode-json-language-server',
        \ 'cmd': {server_info->['vscode-json-language-server', '--stdio']},
        \ 'whitelist': ['json', 'jsonc'],
      \ })
    endif

    " docker
    if executable('docker-langserver')
        au User lsp_setup call lsp#register_server({
            \ 'name': 'docker-langserver',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
            \ 'whitelist': ['dockerfile'],
            \ })
    endif

    " yaml
    if executable('yaml-language-server')
      augroup LspYaml
       autocmd!
       autocmd User lsp_setup call lsp#register_server({
           \ 'name': 'yaml-language-server',
           \ 'cmd': {server_info->['yaml-language-server', '--stdio']},
           \ 'allowlist': ['yaml', 'yaml.ansible'],
           \ 'workspace_config': {
           \   'yaml': {
           \     'validate': v:true,
           \     'hover': v:true,
           \     'completion': v:true,
           \     'customTags': [],
           \     'schemas': {},
           \     'schemaStore': { 'enable': v:true },
           \   }
           \ }
           \})
      augroup END
    endif

    " vimrc
    if executable('vim-language-server')
      augroup LspVim
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'vim-language-server',
            \ 'cmd': {server_info->['vim-language-server', '--stdio']},
            \ 'whitelist': ['vim'],
            \ 'initialization_options': {
            \   'vimruntime': $VIMRUNTIME,
            \   'runtimepath': &rtp,
            \ }})
      augroup END
    endif

    function! s:on_lsp_buffer_enabled() abort
        setlocal omnifunc=lsp#complete
        setlocal signcolumn=yes
        "if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
        nmap <buffer> gd <plug>(lsp-definition)
        nmap <buffer> gr <plug>(lsp-references)
        nmap <buffer> gi <plug>(lsp-implementation)
        nmap <buffer> gt <plug>(lsp-type-definition)
        nmap <buffer> <leader>rn <plug>(lsp-rename)
        nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
        nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
        nmap <buffer> K <plug>(lsp-hover)

        let g:lsp_format_sync_timeout = 1000
    endfunction

    augroup lsp_install
        au!
        " call s:on_lsp_buffer_enabled only for languages that has the server registered.
        autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END

    let g:lsp_diagnostics_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signature_help_enabled = 0
    let g:lsp_diagnostics_signs_enabled = 1
    let g:lsp_diagnostics_signs_error = {'text': '✗'}
    let g:lsp_diagnostics_signs_warning = {'text': '‼'}
    let g:lsp_diagnostics_signs_hint = {'text': '?'}
    let g:lsp_diagnostics_signs_information = {'text': 'i'}
    let g:lsp_diagnostics_virtual_text_enabled = 0
endif

if s:is_plugged("ddc.vim") && s:is_plugged("pum.vim")
    " ddc.vim
    call ddc#custom#patch_global('ui', 'pum')
    call ddc#custom#patch_global('sources', [
     \ 'around',
     \ 'vim-lsp',
     \ 'file'
     \ ])
    call ddc#custom#patch_global('sourceOptions', {
     \ '_': {
     \   'sorters': ['sorter_rank'],
     \   'converters': ['converter_remove_overlap'],
     \ },
     \ 'around': {
     \   'mark': 'around',
     \   'matchers': ['matcher_head']
     \ },
     \ 'vim-lsp': {
     \   'mark': 'lsp', 
     \   'forceCompletionPattern': '\.|:|->|"\w+/*'
     \ },
     \ 'file': {
     \   'mark': 'file',
     \   'isVolatile': v:true, 
     \   'forceCompletionPattern': '\S/\S*'
     \ }})

    call ddc#enable()

    " pum
    inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
    inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
    inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
    inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
    inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
    inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
endif

if s:is_plugged("denops-popup-preview.vim") && s:is_plugged("denops-signature_help")
    " popup
    call popup_preview#enable()
    call signature_help#enable()
endif


if s:is_plugged("vista.vim")
    " Vista
    let g:vista_default_executive = 'vim_lsp'
    let g:vista_update_on_text_changed = 1
    let g:vista_sidebar_width = 40
    let g:vista_echo_cursor = 0
endif

if s:is_plugged("vim-polyglot")
    " Polyglot
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_conceal_code_blocks = 0
endif

if s:is_plugged("vim-airline")
    " vim-airline
    let g:airline_theme = 'papercolor'
    let g:airline#extensions#syntastic#enabled = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'default'
    let g:airline#extensions#tabline#show_splits = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline_skip_empty_sections = 1
endif
