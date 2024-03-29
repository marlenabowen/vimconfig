call plug#begin('~/.config/nvim/plugged')
  Plug 'chaoren/vim-wordmotion', {'commit': '23fc891'}
  Plug 'ctrlpvim/ctrlp.vim', {'tag': '1.79'}
  Plug 'farmergreg/vim-lastplace', {'tag': 'v3.1.0'}
  Plug 'janko-m/vim-test', {'commit': 'ee2b01e'}
  Plug 'jlanzarotta/bufexplorer', {'tag': 'v7.4.6'}
  Plug 'jtratner/vim-flavored-markdown', {'commit': '4a70aa2'}
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'kassio/neoterm'
  Plug 'majutsushi/tagbar', {'commit': 'bef1fa4'}
  Plug 'mileszs/ack.vim', {'tag': '1.0.9'}
  Plug 'michaeljsmith/vim-indent-object', {'tag': '1.1.2'}
  Plug 'pangloss/vim-javascript', {'commit': 'a87c9443'}
  Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}
  Plug 'tommcdo/vim-exchange', {'commit': '05d82b8'}
  Plug 'tomtom/tcomment_vim', {'tag': '3.08'}
  Plug 'tpope/vim-endwise', {'commit': '0067ced'}
  Plug 'tpope/vim-fugitive', {'tag': 'v2.2'}
  Plug 'tpope/vim-surround', {'tag': 'v2.1'}
  Plug 'vim-airline/vim-airline', {'tag': 'v0.8'}
  Plug 'vim-airline/vim-airline-themes', {'commit': '13bad30'}
  Plug 'vim-scripts/argtextobj.vim', {'tag': '1.1.1'}
  Plug 'w0rp/ale', {'commit': '14679f0bd'}
call plug#end()

set dir=/tmp//
set hidden
set ignorecase
set mouse=
set number
set ruler
set showmatch
set smartcase
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set undofile
set clipboard=unnamed

autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd BufNewFile,BufRead *.txt setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
autocmd QuickFixCmdPost *grep* cwindow

" trailing whitespace
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd FileType javascript autocmd BufWritePre <buffer> :%s/\s\+$//e
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

function! ClearTerminalTransform(cmd) abort
  return 'clear;'.a:cmd
endfunction

colorscheme Tomorrow-Night

imap <C-L> <SPACE>=><SPACE>

nmap <silent> <LocalLeader>ff :CtrlP<CR>
nmap <silent> <LocalLeader>gw :Ggrep <cword><CR>
nmap <silent> <LocalLeader>na :ALEToggle<CR>
nmap <silent> <LocalLeader>nf :NERDTreeFind<CR>
nmap <silent> <LocalLeader>nh :nohls<CR>
nmap <silent> <LocalLeader>nt :NERDTreeToggle<CR>
nmap <silent> <LocalLeader>n<SPACE> :highlight clear ExtraWhitespace<CR>
nmap <silent> <LocalLeader><SPACE> :highlight ExtraWhitespace ctermbg=red guibg=red<CR>
nmap <silent> <LocalLeader>rb :wa <bar> :TestFile<CR>
nmap <silent> <LocalLeader>rf :wa <bar> :TestNearest<CR>
nmap <silent> <LocalLeader>rl :wa <bar> :TestLast<CR>
nmap <silent> <LocalLeader>tt :TagbarToggle<CR>
nmap <silent> <LocalLeader>tf :TagbarOpen fj<CR>
nmap <silent> <LocalLeader>tc :TagbarClose<CR>
nmap <silent> <LocalLeader>p :Files<CR>
nnoremap <LocalLeader>* :keepjumps normal! #*<CR>
nnoremap <LocalLeader># :keepjumps normal! *#<CR>

" remove whitespace
nnoremap <LocalLeader>W :%s/\s\+$//<cr>:let @/=''<CR>

let g:exchange_no_mappings=1
nmap <silent> cx <Plug>(Exchange)
xmap <silent> X <Plug>(Exchange)
nmap <silent> cxc <Plug>(ExchangeClear)
nmap <silent> cxx <Plug>(ExchangeLine)

nmap <silent> [q :cprevious<CR>
nmap <silent> ]q :cnext<CR>
nmap <silent> [Q :cfirst<CR>
nmap <silent> ]Q :clast<CR>

let g:neoterm_size = '20'
let g:test#custom_transformations = {'clear': function('ClearTerminalTransform')}
let g:test#transformation = 'clear'
let test#strategy = 'neoterm'

" Allows Ctrl-P to find hidden files like .env
let g:ctrlp_show_hidden = 1

" Allows mocha tests for RN to run in nvim
let test#javascript#mocha#options = '--require test/setup-tests.js --compilers js:babel-core/register'

" File and folder CtrlP exclusions. See https://github.com/kien/ctrlp.vim
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|node_modules$\|Pods$\|build$',
  \ }

let g:wordmotion_prefix = '<LocalLeader>'
let g:wordmotion_mappings = {
\ 'b' : '<LocalLeader>bb',
\ }

" Sort tags in order of appearance by default
let g:tagbar_sort = 0

" ###### ALE ######

" when to lint
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

" add sign column emoticons
let g:ale_sign_error = 'e'
let g:ale_sign_warning = 'w'

" message format
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" always show the sign column
let g:ale_sign_column_always = 1
let g:ale_set_higlights = 1

" reset sign column background colors
highlight link ALEError SignColumn
highlight link ALEWarning SignColumn
highlight link ALEErrorSign SignColumn
highlight link ALEWarningSign SignColumn

" faster fzf fuzzy find respecting gitignore
let $FZF_DEFAULT_COMMAND = '(git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'

" ###### PERSONAL CONFIG ######

if filereadable(expand("~/.my_nvimrc"))
  source $HOME/.my_nvimrc
endif
