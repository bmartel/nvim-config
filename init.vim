" === Plugins
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('hrsh7th/nvim-compe')
  call minpac#add('nvim-lua/plenary.nvim')
  call minpac#add('nvim-lua/popup.nvim')
  call minpac#add('nvim-telescope/telescope.nvim')
  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('kabouzeid/nvim-lspinstall')
  call minpac#add('glepnir/lspsaga.nvim')
  call minpac#add('nvim-treesitter/nvim-treesitter')
  call minpac#add('nvim-treesitter/nvim-treesitter-textobjects')
  call minpac#add('luochen1990/rainbow')
  call minpac#add('Olical/conjure', {'tag': 'v4.21.0'})
  call minpac#add('vimwiki/vimwiki')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('bmartel/vim-snippets')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  call minpac#add('dyng/ctrlsf.vim')
  call minpac#add('justinmk/vim-sneak')

  call minpac#add('bmartel/shades-of-purple.vim')
  call minpac#add('haishanh/night-owl.vim')
  call minpac#add('glepnir/galaxyline.nvim' , {'branch': 'main'})
  call minpac#add('kyazdani42/nvim-web-devicons')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
" === /Plugins

" === Base Config
set iskeyword+=-                                 " treat dash separated words as a word text object"
set clipboard=unnamed,unnamedplus                " enable clipboard
set hidden                                       " hide buffers, don't close
set mouse=a                                      " enable mouse support
set nowrap                                       " disable wrapping
set number relativenumber                        " show line numbers
set textwidth=120                                " set width of all text
set splitbelow                                   " split panes on the bottom
set splitright                                   " split panes to the right
set formatoptions+=j                             " Delete comment character when joining commented lines
set scrolloff=999                                " center cursor position vertically
set expandtab                                    " autoindentation & tabbing
set shiftwidth=2 softtabstop=2 tabstop=2         " 1 tab = 2 spaces
set smartcase                                    " search options
set undofile undolevels=9999                     " undo options
set lazyredraw                                   " enable lazyredraw
set nocursorline                                 " disable cursorline
set ttyfast                                      " enable fast terminal connection
set updatetime=300                               " Faster completion
set timeoutlen=300                               " By default timeoutlen is 1000 ms

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme shades_of_purple

set guifont=IBM\ Plex\ Mono\ 13
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar right
set guioptions-=L  "scrollbar left
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi VertSplit ctermbg=NONE guibg=NONE

autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.rs call RemapFormatRust()
autocmd TermOpen * setlocal nonumber norelativenumber

" >> Lsp key bindings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>Lspsaga hover_doc<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> <C-n> <cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gf    <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>Lspsaga code_action<CR>
xnoremap <silent> ga    <cmd>Lspsaga range_code_action<CR>
nnoremap <silent> gs    <cmd>Lspsaga signature_help<CR>

"" Rainbow parens
let g:rainbow_active = 1

"" NetRW file list styles
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1

"" Vim Sneak
let g:sneak#label = 1

"" Vim Wiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! RemapNetrw()
  nnoremap <buffer><leader>k :bd<CR>
endfunction

function! CRustFmt()
    exec ":silent !cargo fmt -- " . bufname("%")
endfunction

function! RemapFormatRust()
  nnoremap <A-d> :call CRustFmt()<CR>
endfunction

augroup Netrw 
  autocmd!
  autocmd filetype netrw call RemapNetrw()
augroup END

" === /Base Config

" === Mappings
let mapleader=" "                               " leader key

nnoremap <leader># :g/\v^(#\|$)/d_<cr>|          " delete commented/blank lines
nnoremap <leader>d :w !diff % -<cr>|             " show diff
nnoremap <silent> <leader>i gg=G``<cr>|          " fix indentation
nnoremap <leader>rt :retab<cr>|                   " convert tabs to spaces
nnoremap <silent> <leader>ts :%s/\s\+$//e<cr>|    " trim whitespace
nnoremap <leader>tw :set wrap! wrap?<cr>|         " toggle wrapping

"" Clojure Repl
nmap <A-e> :ConjureEval<CR>
vmap <A-e> :ConjureEval<CR>

"" Vim Wiki
nmap <leader>vw <Plug>VimwikiIndex
nmap <leader>vq <Plug>VimwikiUISelect
nmap <leader>vt <Plug>VimwikiTabIndex
nmap <leader>vi <Plug>VimwikiDiaryIndex
nmap <leader>vd <Plug>VimwikiMakeDiaryNote
nmap <leader>vD <Plug>VimwikiTabMakeDiaryNote
nmap <leader>vy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <leader>vm <Plug>VimwikiMakeTomorrowDiaryNote
nmap <leader>vc <Plug>Vimwiki2HTML
nmap <leader>vb <Plug>Vimwiki2HTMLBrowse
nmap <leader>vg <Plug>VimwikiDiaryGenerateLinks
nmap <leader>vl <Plug>VimwikiDeleteLink
nmap <leader>vr <Plug>VimwikiRenameLink

"" Toggle light/dark background
map <leader>x :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"" Rename current file
nnoremap <leader>rr :call RenameFile()<cr>

"" Delete current file
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

"" Clean search (highlight)
nnoremap <silent> <leader>h :noh<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rv :vs#<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rh :sp#<CR>

"" Show buffer list/switch
nnoremap <silent> <leader>b :ls<CR>:e #

"" Buffer nav
noremap <A-q> :bp<CR>
noremap <A-p> :bn<CR>

"" Close current buffer
noremap <leader>c :bd<CR>

"" Force Close current buffer
noremap <leader>C :bd!<CR>

"" Close all buffers
function! CleanEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
      exe 'bw ' . join(buffers, ' ')
  endif
endfunction
noremap <leader>ac :%bd<CR>
noremap <leader>oc :%bd<CR><C-O>:bd#<CR>
noremap <leader>ae :call CleanEmptyBuffers()<CR>

"" maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" move a  visual block up or down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Change windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"" Close all other windows
nmap <C-w>c :enew<bar>bd #<CR>

" save
nnoremap <silent> <C-s> :w<CR>
" quit
nnoremap <silent> <C-Q> :wq!<CR>
" control-c instead of escape
nnoremap <silent> <C-c> <Esc>
"" escape
inoremap jk <Esc>
inoremap kj <Esc>

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
"
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Create new file with the current path filled in
noremap <leader>mf :!touch <C-R>=expand("%:p:h") . "/" <CR>

"" Create new directory with the current path filled in
noremap <leader>md :!mkdir <C-R>=expand("%:p:h") . "/" <CR>

"" Open an edit command with the path of the currently edited file path filled in
noremap <leader>ef :e <C-R>=expand("%:p:h") . "/" <CR>

"" Tabs
nnoremap <A-n> :tabnew<CR>
nnoremap <A-c> :tabc<CR>
nnoremap <A-y> :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <A-j> :tabn<CR>
nnoremap <A-k> :tabp<CR>
nnoremap <A-o> :tabo<CR>

" Terminal
nnoremap <A-t> :terminal<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" NetRW file explorer
nnoremap <leader>k :Explore<CR>

"" Edit VIMRC
nmap <silent> <leader>ev :edit $MYVIMRC<CR>

"" Source VIMRC
nmap <silent> <leader>ee :source $MYVIMRC<CR>

"" Abbreviations
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
" === /Mappings

" === Plugin Mappings
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_winsize = '50%'
let g:ctrlsf_position = 'left'
let g:ctrlsf_ackprg = 'rg'

"" CtrlSF - sublime text-esque global search and replace
nmap     <A-f> <Plug>CtrlSFPrompt
vmap     <A-f> <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fn <Plug>CtrlSFCwordPath
nmap     <leader>fp <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>

" >> Telescope bindings
nnoremap <leader>pp :lua require'telescope.builtin'.builtin{}<CR>

" most recentuly used files
nnoremap <leader>m :lua require'telescope.builtin'.oldfiles{}<CR>

" find buffer
nnoremap ; :lua require'telescope.builtin'.buffers{}<CR>

" find in current buffer
nnoremap <leader>/ :lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>

" bookmarks
nnoremap <leader>' :lua require'telescope.builtin'.marks{}<CR>

" git files
"" Fuzzy match files
" nnoremap <A-s> :Files<CR>
nnoremap <A-s> :lua require'telescope.builtin'.git_files{}<CR>

" all files
nnoremap <A-S> :lua require'telescope.builtin'.find_files{}<CR>

" ripgrep like grep through dir
"" Fuzzy match text in files
" nnoremap <A-g> :Rg<CR>
nnoremap <A-g> :lua require'telescope.builtin'.live_grep{}<CR>

" pick color scheme
nnoremap <leader>sc :lua require'telescope.builtin'.colorscheme{}<CR>

"" Format file with current formatter (likely prettier)
nnoremap <A-d> <cmd>lua vim.lsp.buf.formatting()<CR>

lua <<EOF
require("lsp")
require("treesitter")
require("statusbar")
require("completion")
EOF
" === /Plugin Mappings
