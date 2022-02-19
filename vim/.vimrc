" Basic Vim sets
set backspace=indent,eol,start
set clipboard=unnamed,unnamedplus
set encoding=UTF-8
set expandtab
set incsearch
set mouse=a
set nobackup
set noswapfile
set number
set relativenumber
set scrolloff=8
set signcolumn=yes
set softtabstop=4
set tabstop=4 

set showmode
set showcmd
set undofile
set autoindent

" fast exit with exit key
set ttimeout
set ttimeoutlen=100
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

" prevents some security exploits
set modelines=0

" no need to be compatible with vi
set nocompatible

" set splitting of horizontal to start from below
set splitbelow
" set termwinsize=10x0

" search 
set incsearch
set hlsearch
set ignorecase
set showmatch
set smartcase

" search and replace
set gdefault

" Save on tabbing away
au FocusLost * :wa

" COC recommended vim settings
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
" COC recommended vim settings END

" Basic Vim sets END

" set the cursor on insert mode
autocmd InsertEnter,InsertLeave * set cul!
" do not need this because we have highlighter alread
" syntax on
"
" cursor becomes a thin line insert, underscore replace
" tmux settings, for pure iterm2/terminal please check another setting
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Leader key
let mapleader = " "

" start all the plugins
call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'peitalin/vim-jsx-typescript' " tsx 
" Plug 'ianks/vim-tsx' " tsx 
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'rust-lang/rust.vim' 
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
" fzf file search
Plug 'junegunn/fzf', {'do':{ -> fzf#install()}}
Plug 'junegunn/fzf.vim'
" ack for search value in file, use with silver searcher ?
Plug 'mileszs/ack.vim'
" git fugitive stuff
Plug 'tpope/vim-fugitive'
" git gutter, good for git diff
Plug 'airblade/vim-gitgutter'
" colorschemes
Plug 'morhetz/gruvbox'
" lightline
Plug 'itchyny/lightline.vim'
" Vim git fugitive 
Plug 'https://github.com/tpope/vim-fugitive'
" Unimpaired common mappings
Plug 'https://tpope.io/vim/unimpaired.git'
" auto complete for brackets, quotes, parentheses
Plug 'jiangmiao/auto-pairs'
" Multi cursor plugin
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Helps to go back to the last place
Plug 'https://github.com/farmergreg/vim-lastplace.git'
" surround brackets , tags quotes
Plug 'https://tpope.io/vim/surround.git'
" Vim sessions 
Plug 'https://github.com/tpope/vim-obsession.git'
" Vim snippet engine
Plug 'SirVer/ultisnips'
" Vim snippets
Plug 'honza/vim-snippets'
" Vim Markdown Preview
Plug 'JamshedVesuna/vim-markdown-preview'
" window swapping
Plug 'wesQ3/vim-windowswap'
" markdown presentation
Plug 'mattf1n/vimmarp'
" Editor config
Plug 'editorconfig/editorconfig-vim'
call plug#end()

" Rust files auto format on save
let g:rustfmt_autosave = 1

" color scheme - gruvbox
 colorscheme gruvbox
 let g:gruvbox_invert_selection=0


let g:rainbox_active = 0
let g:coc_global_extensions = [ 'coc-tsserver' ]

" Markdown preview requirement, using grip
let vim_markdown_preview_github=1

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'apprentice',
      \ 'active': {
      \   'left': [ ['mode', 'paste'] ,
      \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
      \   'right': [ ['lineinfo'] ,
      \             ['percent'] ,
      \             ['fileformat', 'filetype'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" need my silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" Vim snippets settings
let g:UltiSnipsExpandTrigger="<p>"
let g:UltiSnipsJumpForwardTrigger="<c-0>"
let g:UltiSnipsJumpBackwardTrigger="<c-9>"

" PrettierMapping
augroup prettier_mapping
    autocmd FileType typescript,typescriptreact,javascript,json,javascriptreact,css nmap <leader>p :CocCommand prettier.formatFile<CR>
    autocmd FileType rust nmap <leader>p :RustFmt<CR>
augroup END

" CoC mapping
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)

nmap <leader>ge :CocDiagnostics
nmap <silent>[g <Plug>(coc-diagnostic-prev)
nmap <silent>]g <Plug>(coc-diagnostic-next)

" Window Swapping
let g:windowswap_map_keys = 0 "prevent default bindings
" nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
" nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>swap :call WindowSwap#EasyWindowSwap()<CR>

" trigger tab autocomplete
inoremap <silent><expr> <tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<tab>" :
      \ coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Coc Mapping END

" COC Start
" - recommended config  https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" COC End

" Rust LSP start
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif 
" Rust LSP end

" Need this for pathogen, why ? not sure 
if(has('vim'))
    execute pathogen#infect()
endif

" Close all inactive buffers
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

" Mappings

" Escape from insert
inoremap jj <ESC>

" map ; to : , so don't need shift, command mode
nmap ; :

" Allow escape pairs (){}"" when insert mode
inoremap <C-e> <C-o>A

" Clears the search line 
nnoremap <leader><space> :noh<cr>

" buffer manipulation
nmap <c-q> :q<cr>
nmap <leader>W :only<cr> <C-w>v<C-w>l<cr> 
nmap <leader>bl :Buffers<cr>
nmap <leader>bs :BLines<cr>
nmap <leader>bas :Lines<cr>
nmap <leader>bc :BCommits<cr>

" quickfix list handling
nmap <leader>cc :cclose<cr>

" Find all occurences of word under cursor and replace
nnoremap <leader>R yiw:%s/\<<C-r>"\>//gc<left><left><left>

" Sorting css properties
nnoremap <leader>CS ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" File Manager Navigations
nnoremap <C-t> :Lex<CR>
nmap <leader>vf :Vexplore<CR>
nmap <leader>sf :Sexplore<CR>

" new split vertical
nnoremap <leader>w <C-w>v<C-w>l

" new tab containing current buffer
nnoremap <leader>wt :tab split<CR>

" new tab
nnoremap <leader>T :tabnew<CR>
nnoremap <leader>! :tabnext1<CR>
nnoremap <leader>@ :tabnext2<CR>
nnoremap <leader># :tabnext3<CR>
nnoremap <leader>$ :tabnext4<CR>
nnoremap <leader>% :tabnext5<CR>
nnoremap <leader>^ :tabnext6<CR>

" navigate around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" silver search mapping
nnoremap <C-o> :Ag<CR>
nnoremap <Tab> :GFiles<CR>

" fugitive git bindings
nnoremap <leader>gc :Git commit -m''<left>
nnoremap <leader>gb :Git blame<CR>

" TRAINING MY VIM , turns off the arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Weird remaps
nnoremap <leader>editvimrc :edit ~/.vim/.experimental.vimrc<CR>


"
" Remember some stuff here
" 
" "add delete into the 'a' register
" "by yank into the 'b' register
" "cp copy from the 'c' register
"
"
