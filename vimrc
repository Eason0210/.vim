" __  ____   ____     _____ __  __ ____   ____
"|  \/  \ \ / /\ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  \ \ / / | || |\/| | |_) | |
"| |  | | | |    \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|     \_/  |___|_|  |_|_| \_\\____|

" Author: @Aqua

" Checkout-list
" vim-esearch
" fmoralesc/worldslice
" SidOfc/mkdx

scriptencoding utf-8
set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Windows Compatible
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" ============================================================================
" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
if using_neovim
    let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
else
    let vim_plug_path = expand('~/.vim/autoload/plug.vim')
endif
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the config down below 
" as you wish :)
" IMPORTANT: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
if using_neovim
    call plug#begin("~/.config/nvim/plugged")
else
    call plug#begin("~/.vim/plugged")
endif
" Now the actual plugins:

Plug 'mg979/vim-xtabline'
"Plug 'xolox/vim-session'
"Plug 'xolox/vim-misc' " vim-session dep
Plug 'idanarye/vim-vebugger'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}


" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'theniceboy/eleline.vim'
Plug 'bling/vim-bufferline'
"Plug 'liuchengxu/space-vim-theme'
Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'ajmwagar/vim-deus'

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
"FZF
if has("mac") || has("gui_macvim")
Plug '/usr/local/opt/fzf'
endif

if has("win32")
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
"Plug 'yuki-ycino/fzf-preview.vim'
"Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
"Plug 'junegunn/fzf'
Plug 'francoiscabrol/ranger.vim'

" Terminal
Plug 'jpalardy/vim-slime'
"Plug 'jupyter-vim/jupyter-vim'
"Plug 'wmvanvliet/jupyter-vim'
" Taglist
"Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }
Plug 'liuchengxu/vista.vim'

" Error checking, handled by coc

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Haskell Support
"Plug 'neovimhaskell/haskell-vim'

" Snippets(Ultisnips remove support for Python2)
if has('python3')
    Plug 'SirVer/ultisnips'
elseif has('python')
    Plug 'SirVer/ultisnips', {
        \   'tag': '3.2',
        \   'dir': get(g:, 'plug_home', '~/.vim/bundle') . '/ultisnips_py2',
        \ }
endif
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'

" CSharp
Plug 'OmniSharp/omnisharp-vim'
Plug 'ctrlpvim/ctrlp.vim' , { 'for': ['cs', 'vim-plug'] } " omnisharp-vim dependency

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'jaxbot/browserlink.vim'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Python
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'theniceboy/bullets.vim'

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph, 
Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'
Plug 'Konfekt/FastFold'
Plug 'junegunn/vim-peekaboo'

" Input Method Autoswitch
"Plug 'rlue/vim-barbaric' " slowing down vim-multiple-cursors

" Formatter
Plug 'Chiel92/vim-autoformat'

" For general writing
Plug 'junegunn/goyo.vim'
"Plug 'reedes/vim-wordy'
"Plug 'ron89/thesaurus_query.vim'

" Bookmarks
"Plug 'kshenoy/vim-signature'
Plug 'MattesGroeger/vim-bookmarks'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'osyo-manga/vim-anzu'

" Documentation
"Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
"Plug 'voldikss/vim-floaterm'
"Plug 'liuchengxu/vim-clap'
"Plug 'jceb/vim-orgmode'
Plug 'mhinz/vim-startify'
"Plug 'theniceboy/vim-leader-mapper'(nvim only)

" Vim Applications
"Plug 'itchyny/calendar.vim'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

" Other useful utilities
Plug 'tpope/vim-eunuch' " do stuff like :SudoWrite
Plug 'makerj/vim-pdf'

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'
Plug 'rbgrouleff/bclose.vim' " For ranger.vim

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish
 
if using_vim
    " A bunch of things that are set by default in neovim, but not in vim

    "Language Setting
    set langmenu=en_US
    let $LANG='en_US'
    " close interface information
    set shortmess=atI
    " no vi-compatible
    set nocompatible

    "set clipboard=unnamedplus
    let &t_ut=''
    set autochdir
    " allow plugins by file type (required for plugins!)
    filetype plugin on
    filetype indent on
    " always show status bar
    set laststatus=2

    " incremental search
    set incsearch
    " highlighted search results
    set hlsearch

    "change cursor shape to beam at Inset-mode
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    " syntax highlight on
    syntax on

    "fix backspace issues in window os
    set backspace=2
    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/dirs/tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/dirs/backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
endif

" ===
" === Editor behavior
" ===
" show line numbers
set number
set relativenumber
set cursorline

" tabs and spaces handling
"set expandtab
set noexpandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
"set inccommand=split "It is a neovim function"
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
set colorcolumn=80
set updatetime=1000

"remember the position last edited
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" ===
" === Terminal Behaviors(TODO)
" ===
"let g:neoterm_autoscroll = 1
"autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
"tnoremap <C-O> <C-\><C-N><C-O>
"let g:terminal_color_0  = '#000000'
"let g:terminal_color_1  = '#FF5555'
"let g:terminal_color_2  = '#50FA7B'
"let g:terminal_color_3  = '#F1FA8C'
"let g:terminal_color_4  = '#BD93F9'
"let g:terminal_color_5  = '#FF79C6'
"let g:terminal_color_6  = '#8BE9FD'
"let g:terminal_color_7  = '#BFBFBF'
"let g:terminal_color_8  = '#4D4D4D'
"let g:terminal_color_9  = '#FF6E67'
"let g:terminal_color_10 = '#5AF78E'
"let g:terminal_color_11 = '#F4F99D'
"let g:terminal_color_12 = '#CAA9FA'
"let g:terminal_color_13 = '#FF92D0'
"let g:terminal_color_14 = '#9AEDFE'

" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
"noremap ; :
noremap <LEADER>; q:i

" Save & quit
noremap Q :q<CR>
"noremap <C-q> :qa<CR>
noremap S :w<CR>

"cOpen the vimrc file anytime
noremap <LEADER>rc :e ~/.vim/vimrc<CR>
noremap <LEADER>so :source $MYVIMRC<CR>

"Open Startify
"noremap <LEADER>st :Startify<CR>


" make Y to copy till the end of the line TODO
"nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g

" Folding(TODO)
noremap <silent> <LEADER>o za

" Open up lazygit
noremap \g :term lazygit<CR>
noremap <c-g> :term lazygit<CR>


" ===
" === Cursor Movement
" ===
"Cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     k
" < h   l >
"     j
"     v

" K/J keys for 5 times k/j (faster navigation) TODO
"noremap <silent> K 5k
"noremap <silent> J 5j

" N key: go to the start of the line TODO
"noremap <silent> N 0
" I key: go to the end of the line TODO
"noremap <silent> I $

" Faster in-line navigation
noremap W 5w
noremap B 5b

" Ctrl + U or E will move up/down the view port without moving the cursor TODO
"noremap <C-U> 5<C-y>
"noremap <C-E> 5<C-e>


" ===
" === Insert Mode Cursor Movement
" ===
inoremap <C-a> <ESC>A


" ===
" === Command Mode Cursor Movement
" ===
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>


" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
"tnoremap <LEADER>w <C-w>w
"tnoremap <C-q> exit<CR>
"noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap ss <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>


" ===
" === Tab management
" ===
" Create a new tab
noremap tn :tabe<CR>
" Move around tabs
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs
noremap tbh :-tabmove<CR>
noremap tbl :+tabmove<CR>


" ===
" === Markdown Settings
" ===
" Snippets
source ~/.vim/md-snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


" ===
" === Other useful stuff
" ===
" Move the next character to the end of the line with ctrl+9
inoremap <C-i> <ESC>lx$p

" Opening a terminal window
noremap <LEADER>/ :term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Press ` to change case (instead of ~)
noremap ` ~

noremap <C-c> zz

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

"" Call figlet(TODO)
"noremap tx :r !figlet

"noremap <LEADER>- :lN<CR>
"noremap <LEADER>= :lne<CR>

" find and replace
noremap \s :%s//g<left><left>

" Compile function
noremap er :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		":sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		":sp
		:term go run %
	endif
endfunc


"================
"图形界面设置
"================

if has("gui_running")
    " 设定中英文输入法自动切换
    "  autocmd! InsertEnter * set noimdisable
    "  autocmd! InsertLeave * set imdisable
    "  set noimdisable

    if has("win32")
        " Windows兼容配置
        " 设定图形界面大小
        set lines=40
        set columns=80
        set guioptions-=m "menu"
        set guioptions-=T "tool bar"
        set guioptions-=r "right scrollbar"
        set guioptions-=L "left scrollbar"

        "noremap <LEADER>rc :e ~/.vimrc<CR>
        " 字体配置
        "exec 'set guifont='.iconv('DejaVu_Sans_Mono', &enc, 'gbk').':h12:cANSI'
        "exec 'set guifontwide='.iconv('微软雅黑', &enc, 'gbk').':h12'
        "set guifont=FuraMono_NF:h12
        "set guifont=DejaVu_Sans_Mono_Nerd_Font_Complete_Windows_Compatible:h12
        set guifont=MesloLGM_NF:h12
        "set guifont=Hack_Nerd_Font_Mono_Regular:12
        set gfw=楷体:h14
        "自动设当前编辑的文件所在目录为当前工作路径
        exec 'cd ' . fnameescape('d:\Code')
        set autochdir
    endif

    if has("unix") && !has('gui_macvim')
        "set guifont=DejaVu_Sans_Mono:h12
    endif
    if has("mac") || has("gui_macvim")
        "set guifont=Menlo:h15
        "set guifont=DejaVu_Sans_Mono_for_Powerline:h15
        set guifont=DejaVu_Sans_Mono_Nerd_Font_Complete:h15
        "set guifont=DejaVu_Sans_Mono:h12
        if has("gui_macvim")
            "set transparency=4
             "set lines=200 columns=142
             set lines=50 columns=80

             let s:lines=&lines
             let s:columns=&columns
             func! FullScreenEnter()
                 set lines=999 columns=999
                 set fu
             endf

             func! FullScreenLeave()
                 let &lines=s:lines
                 let &columns=s:columns
                 set nofu
             endf

             func! FullScreenToggle()
                 if &fullscreen
                     call FullScreenLeave()
                 else
                     call FullScreenEnter()
                 endif
             endf
        endif
    endif
endif

"Under the Mac(MacVim)
if has("gui_macvim")
    " Mac 下，按 Leader + ff 切换全屏
    map <Leader>ff  :call FullScreenToggle()<cr>

    " Set input method off
    "set noimdisable
    "自动设当前编辑的文件所在目录为当前工作路径
    exec 'cd ' . fnameescape('~/Code')
    set autochdir
    "Open .vimrc and .bash_profile
    map <LEADER>bf :e ~/.bash_profile<CR>
endif

" ===
" === Dress up my vim
" ===
set termguicolors	" enable true colors support

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    set background=dark
    colorscheme gruvbox
else
    set background=dark
    colorscheme gruvbox
endif

hi NonText ctermfg=gray guifg=grey10

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
if has("unix") || has('mac')
"set shell=/bin/bash
set shell=/bin/zsh
"source ~/.zshrc
endif
" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)(TODO)
"au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" ===
" === airline.vim
" ===
let g:airline_powerline_fonts = 1

" ==
" == GitGutter(TODO)
" ==
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ===
" === coc
" ===
" fix the most annoying bug that coc has
nnoremap <LEADER>cf :CocConfig<CR>
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = ['coc-python','coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-vimlsp', 'coc-tailwindcss', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-git', 'coc-pyright', 'coc-sourcekit', 'coc-translator']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <silent><expr> <CR> pumvisible() ? "\<C-y><CR>" : "\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>py :CocCommand python.startREPL<CR>
" coc-todolist
noremap ta :CocCommand todolist.create<CR>
noremap td :CocCommand todolist.upload<CR>
noremap tD :CocCommand todolist.download<CR>
noremap tc :CocCommand todolist.clearNotice<CR>
noremap tc :CocCommand todolist.clearNotice<CR>
noremap tcl :CocList --normal todolist<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" coc-markmap
command! Markmap CocCommand markmap.create


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
""" let g:python_slow_sync = 0

" ===
" === Python-mode
" ===

""let g:pymode = 1
"let g:pymode_python = 'python3'
"let g:pymode_indent = 1
""Currently folding is considered experimental.
"let g:pymode_folding = 0
"let g:pymode_motion = 1
"let g:pymode_doc = 1
"let g:pymode_doc_bind = 'K'
"
""let g:pymode_virtualenv = 1
""let g:pymode_virtualenv_path = $VIRTUAL_ENV
""Run code
"let g:pymode_run = 1
"let g:pymode_run_bind = '<leader>r'
""Debug
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_bind = '<leader>b'
""Manually set breakpoint command (leave empty for automatic detection)
"let g:pymode_breakpoint_cmd = ''
"
""Code checking
"let g:pymode_lint = 1
"let g:pymode_lint_on_write = 1
""let g:pymode_lint_on_fly = 0
"let g:pymode_lint_message = 1
""Values may be chosen from: `pylint`, `pep8`, `mccabe`, `pep257`, `pyflakes`.
"let g:pymode_lint_checkers = ['pylint', 'pep8']
""let g:pymode_lint_ignore = ["E501", "W",]
""let g:pymode_lint_select = ["E501", "W0011", "W430"]
"let g:pymode_lint_cwindow = 1
"let g:pymode_lint_signs = 1
""Defind error signs
"let g:pymode_lint_todo_symbol = 'WW'
"let g:pymode_lint_comment_symbol = 'CC'
"let g:pymode_lint_visual_symbol = 'RR'
"let g:pymode_lint_error_symbol = 'EE'
"let g:pymode_lint_info_symbol = 'II'
"let g:pymode_lint_pyflakes_symbol = 'FF'
""completion
"let g:pymode_rope_completion = 1
"let g:pymode_rope_completion_bind = '<C-Space>'
""goto definition 
"let g:pymode_rope_goto_definition_bind = '<C-c>g'
"let g:pymode_syntax = 1
"let g:pymode_syntax_all = 1

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" === FZF
" ===
"set rtp+=/usr/local/opt/fzf
noremap <C-p> :FZF<CR>
noremap <C-f> :Ag<CR>
noremap <C-h> :MRU<CR>
noremap <C-t> :BTags<CR>
noremap <C-l> :LinesWithPreview<CR>
noremap <LEADER>w :Buffers<CR>
noremap ; :History:<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang -nargs=* Buffers
  \ call fzf#vim#buffers(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:0%', '?'),
  \   <bang>0)


command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({}, 'up:50%', '?'),
    \   1)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)


command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())

command! -bang BTags
  \ call fzf#vim#buffer_tags('', {
  \     'down': '40%',
  \     'options': '--with-nth 1 
  \                 --reverse 
  \                 --prompt "> " 
  \                 --preview-window="70%" 
  \                 --preview "
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
  \                     head -n 16"'
  \ })


"" ===
"" === fzf-preview.vim
"" ===
"noremap <C-w> :BuffersPreview<CR>
"let g:fzf_preview_default_key_bindings = 'ctrl-e:down,ctrl-u:up'
"let g:fzf_preview_layout = 'belowright split new'
"let g:fzf_preview_rate = 0.4
"let g:fzf_full_preview_toggle_key = '<C-f>'
"let g:fzf_preview_command = 'ccat --color=always {-1}'
"let g:fzf_binary_preview_command = 'echo "It is a binary file"'


" ===
" === CTRLP (Dependency for omnisharp)
" ===
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'


" ===
" === vim-bookmarks
" ===

let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap mal <Plug>BookmarkShowAll
nmap ml <Plug>BookmarkNext
nmap mh <Plug>BookmarkPrev
nmap mC <Plug>BookmarkClear
nmap mX <Plug>BookmarkClearAll
nmap mk <Plug>BookmarkMoveUp
nmap mj <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1

" ===
" === Undotree(TODO)
" ===
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc


" ==
" == vim-multiple-cursor
" ==
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key = '<c-k>'
let g:multi_cursor_select_all_word_key = '<a-k>'
let g:multi_cursor_start_key = 'g<c-k>'
let g:multi_cursor_select_all_key = 'g<a-k>'
let g:multi_cursor_next_key = '<c-k>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<C-s>'
let g:multi_cursor_quit_key = '<Esc>'


" ===
" === Far.vim
" ===
noremap <LEADER>f :F  %<left><left>


" ===
" === Bullets.vim
" ===
"let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]

" ===
" === Vim-slime
" ===
let g:slime_target = "vimterminal"
"let g:slime_vimterminal_config = {options}
let g:slime_python_ipython = 1
let g:slime_haskell_ghci_add_let = 0
"let g:slime_vimterminal_cmd = "ipython"
"let g:slime_vimterminal_config = {"term_finish": "close"}

" ===
" === Taglist
" ===
"map <silent> T :TagbarOpenAutoClose<CR>

" ===
" === Vista.vim
" ===
noremap <silent> T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
"return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "l"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ==
" == NERDTree-git
" ==
" <leader>c<space> 注释/取消注释
" <leader>cc // 注释
" <leader>cm 只用一组符号注释
" <leader>cA 在行尾添加注释
" <leader>c$ /* 注释 */
" <leader>cs /* 块注释 */
" <leader>cy 注释并复制
" <leader>ca 切换　// 和 /* */
" <leader>cu 取消注释

" ===
" === Ranger.vim
" ===
nnoremap tr :Ranger<CR>
let g:ranger_map_keys = 0


" ===
" === fzf-gitignore
" ===
noremap <LEADER>gi :FzfGitignore<CR>


" ===
" === Ultisnips
" ===
"let g:tex_flavor = "latex"
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', 'UltiSnips']
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>



" ===
" === Anzu
" ===
set statusline=%{anzu#search_status()}
nnoremap = n
nnoremap - N


" ===
" === vim-go
" ===
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0

let g:go_statusline_duration = 30
let g:go_echo_command_info = 0
" ===
" === AutoFormat
" ===
nnoremap \f :Autoformat<CR>


" ===
" === OmniSharp
" ===
let g:OmniSharp_typeLookupInPreview = 1
let g:omnicomplete_fetch_full_documentation = 1

let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_selector_ui = 'ctrlp'

autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>

sign define OmniSharpCodeActions text=💡

augroup OSCountCodeActions
	autocmd!
	autocmd FileType cs set signcolumn=yes
	autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

function! OSCountCodeActions() abort
	if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
	if !OmniSharp#IsServerRunning() | return | endif
	let opts = {
				\ 'CallbackCount': function('s:CBReturnCount'),
				\ 'CallbackCleanup': {-> execute('sign unplace 99')}
				\}
	call OmniSharp#CountCodeActions(opts)
endfunction

function! s:CBReturnCount(count) abort
	if a:count
		let l = getpos('.')[1]
		let f = expand('%:p')
		execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
	endif
endfunction


" ===
" === Colorizer
" ===
let g:colorizer_syntax = 1


" ===
" === vim-floaterm
" ===
"nnoremap ? :FloatermToggle<CR>
"let g:floaterm_position = 'center'
"let g:floaterm_winblend = 20
"let g:floaterm_height = winheight(0)/3*2
"let g:floaterm_width = &columns/3*2


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
map ' <Plug>(easymotion-bd-f)
nmap ' <Plug>(easymotion-bd-f)
"map E <Plug>(easymotion-j)
"map U <Plug>(easymotion-k)
"nmap f <Plug>(easymotion-overwin-f)
"map \; <Plug>(easymotion-prefix)
"nmap ' <Plug>(easymotion-overwin-f2)
"map 'l <Plug>(easymotion-bd-jk)
"nmap 'l <Plug>(easymotion-overwin-line)
"map  'w <Plug>(easymotion-bd-w)
"nmap 'w <Plug>(easymotion-overwin-w)


" ===
" === goyo
" ===
map <LEADER>gy :Goyo<CR>


" ===
" === jsx
" ===
let g:vim_jsx_pretty_colorful_config = 1


" ===
" === fastfold
" ===
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:vimsyn_folding = 'af'
let g:xml_syntax_folding = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1


" ===
" === vim-easy-align
" ===
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === vim-map-leader
" ===
"let g:leaderMenu = {'name':  "Shortcut Menu",
"\'SPC f':  ['Advanced find'],
"\'SPC rc': ['Edit vim config'],
"\'SPC Enter':  ['Clear search'],
"\'SPC dw':  ['Remove adj. dup. words'],
"\'SPC tt':  ['spc to tabs'],
"\'SPC o':  ['Open folds'],
"\'SPC q':  ['Close win below'],
"\'SPC /':  ['Open terminal'],
"\'SPC <SPC>':  ['Find <++>'],
"\'SPC sc':  ['Toggle spell-check'],
"\'SPC gf':  ['Fold unchanged'],
"\'SPC g-':  ['Previous hunk'],
"\'SPC g=':  ['Next Hunk'],
"\'SPC rn':  ['Rename variable'],
"\'SPC tm':  ['Toggle table-mode'],
"\'SPC a':  ['Calculate equation'],
"\'SPC gi':  ['New .gitignore'],
"\'SPC gy':  ['Toggle focus mode'],
"\'SPC w':  ['Change Buffers'],
"\}
"nnoremap <silent> ? :call leaderMapper#start() "<Space>"<CR>
"let g:leaderMapperWidth = 80


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :XTabInfo<CR>


"" ===
"" === vim session
"" ===
"let g:session_directory = $HOME."/.config/nvim/tmp/sessions"
"let g:session_autosave = 'no'
"let g:session_autoload = 'no'
""let g:session_autosave_periodic = 1
""let g:session_autosave_silent = 1
"set sessionoptions-=buffers
"set sessionoptions-=options
"noremap sl :OpenSession<CR>
"noremap ss :SaveSession<CR>
"noremap sc :CloseSession<CR>
"noremap sD :DeleteSession<CR>
"noremap sA :AppendTabSession<CR>


" ===
" === vebugger
" ===
" Compile function
let g:vebugger_leader='<leader>a'
noremap <c-d> :call DebuggerRun()<CR>:VBGcontinue<CR>
"noremap <f5> :call DebuggerRun()<CR>
func! DebuggerRun()
	exec "w"
	if &filetype == 'python'
		VBGstartPDB3 %
	endif
endfunc
noremap <f3> :VBGkill<CR>
noremap <f5> :VBGcontinue<CR>
noremap <f9> :VBGtoggleBreakpointThisLine<CR>
noremap <f10> :VBGstepOver<CR>
noremap <f11> :VBGstepInto<CR>
noremap <f12> :VBGstepOut<CR>


" ===
" === Haskell-vim
" ===
"filetype plugin indent on
"syntax on
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enabl

" Custom configurations ----------------
filetype indent plugin on
syntax enable
exec "nohlsearch"

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.config/nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif
