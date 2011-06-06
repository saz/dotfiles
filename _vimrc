"  =========
"  Shortcuts
"  =========
let mapleader=","		" change leader to comma instead of back-slash
set nocompatible		"  Disable vi compatible mode
let g:pep8_map='<leader>8'	" run pep8

command! W :w
" Write file with sudo
cmap W! w !sudo tee % >/dev/null

" toggle tasklist
map <leader>td <Plug>TaskList

" <leader>v opens .vimrc
" <leader>V reloads it (remember to save file first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Open NERDTree
map <leader>n :NERDTreeToggle<CR>

" Ack searching
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nmap <leader>a <Esc>:Ack!

" Open Gundo window
map <leader>g :GundoToggle<CR>

" Run django tests
map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" run py.test's
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

" Jump to the definition of whatever the cursor is on
map <leader>j :RopeGotoDefinition<CR>

" Rename whatever the cursor is on (including references to it)
map <leader>r :RopeRename<CR>



" ================================
" Load plugins managed by Pathogen
" ================================
filetype off

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

if v:version < '702' || !has('python')
    call add(g:pathogen_disabled, 'pyflakes')
endif

if v:version < '702'
    call add(g:pathogen_disabled, 'acp')
endif

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ==============
" Basic settings
" ==============
" Disable the colorcolumn when switching modes. Make sure this is the
" first autocmd for the filetype here
if exists("&colorcolumn")
	autocmd FileType * setlocal colorcolumn=0
endif

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6			" Keep a small completion window
" ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set grepprg=ack-grep		" replace default grep program with ack

" show a line at column 79
if exists("&colorcolumn")
    set colorcolumn=79
endif

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>

syntax on			" enable syntax highlighting
filetype on			" try to detect filetypes
filetype plugin indent on	" enable loading indent file for filetype
set title			" show title in console title bar
set number			" display line numbers
set numberwidth=1		" use only one column when possible
set background=dark		" dark background in use
set incsearch			" do incremental search
set hlsearch			" highlight search value
set ignorecase			" case-insensitive search
set smartcase			" if a pattern contains an uppercase letter, it is case sensitive
set wrapscan			" wrap around to the beginning of file on search if end is reached
set showmatch			" show matching brackets
set wildmenu			" menu completion on <TAB> in command mode
set wildmode=full		" cycle between all matches
set ruler			" display cursor position
set autoindent			" always enable autoindenting
set smartindent			" use smart indent if there is no indent file
set tabstop=4			" <TAB> inserts four spaces
set shiftwidth=4		" indent level is 2 spaces wide TODO
set softtabstop=4		" <BS> over an autoindent deletes both spaces
set expandtab			" use spaces for autoindent/tab
set noautowrite			" write only on request
set noautowriteall		" write in all cases on request only
set noautoread			" don't re-read changed files automatically
set nowrap			" don't wrap text
set modeline			" allow vim options to be embedded in files
set modelines=5			" they must be within the first or last 5 lines
set ffs=unix,dos,mac		" try recognizing unix, dos and mac line endings
set laststatus=2		" always show statusline
"set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
set statusline=[%l,%v\ %p%%]\ %F%m%r%h%w\ %=%03.b,0x%B\ %{fugitive#statusline()}\ [%{&ff}]\ %y\ [len:%L]
set showmatch			" briefly jump to the matching brace
set cursorline			" highlight the line containing the cursor
set showcmd			" show incomplete commands
set nostartofline		" try to preserve column where cursor is positioned
set shiftround			" indent/outdent to nearest tabstops
set backspace=2			" Allow backspacing over autoindent, EOL, and BOL
set scrolloff=3			" Keep 3 context lines above and below the cursor
set virtualedit=block		" Let cursor move past the last char in <C-v> mode
set linebreak			" don't wrap text in the middle of a word
set matchpairs=<:>		" comma-separated list of characters that form pairs
set confirm			" raise a dialog because of unsaved changes
set report=0			" always display changed line count
set smarttab			" Handle tabs more intelligently
set shortmess+=a		" Use [+]/[RO]/[w] for modified/readonly/written.
set foldmethod=indent		" Lines with equal indent form a fold.
set foldlevel=99		" don't fold by default
"set foldcolumn=1		" show the fold column
set noerrorbells		" don't bell
set novisualbell t_vb=
set nobackup			" Turn backups off, since most stuff is in $VCS
set nowritebackup		" No backup before overwriting a file
colorscheme inkpot		" use colorscheme

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" don't outdent hashes
inoremap # #

" Enable 256 colors
set t_Co=256

augroup gzip
  autocmd!
  autocmd BufReadPre,FileReadPre     *.gz,*.Z,*.bz2 set bin
  autocmd BufReadPost,FileReadPost   *.gz,*.Z '[,']!gunzip
  autocmd BufReadPost,FileReadPost   *.bz2 '[,']!bunzip2
  autocmd BufReadPost,FileReadPost   *.gz,*.Z,*.bz2 set nobin
  autocmd BufReadPost,FileReadPost   *.gz,*.Z,*.bz2 execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePost,FileWritePost *.gz,*.Z,*.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r
  autocmd BufWritePost,FileWritePost *.bz2 !bzip2 <afile>:r
  autocmd BufWritePost,FileWritePost *.Z !compress <afile>:r
  autocmd FileAppendPre              *.gz,*.Z !gunzip <afile>
  autocmd FileAppendPre              *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre              *.gz,*.Z,*.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost             *.gz,*.Z,*.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost             *.gz !gzip <afile>:r
  autocmd FileAppendPost             *.bz2 !bzip2 <afile>:r
  autocmd FileAppendPost             *.Z !compress <afile>:r
augroup END


"""""""""""""""""""""""""""""""""
" FILE TYPE SYNTAX "
"""""""""""""""""""""""""""""""""
au BufRead /etc/network/interfaces :set syntax=interfaces


"""""""""""""""""""""""""""""""""
" KEY MAPPING "
"""""""""""""""""""""""""""""""""
"
" taglist
nnoremap <silent> <F8> :TlistToggle<CR>


"""""""""""""""""""""""""""""""""
" PLUGIN CONFIGURATION "
"""""""""""""""""""""""""""""""""
"
" taglist
"
" Close VIM if taglist is the only window
let Tlist_Exit_OnlyWindow = 1

" Display taglist window on the right
let Tlist_Use_Right_Window = 1
