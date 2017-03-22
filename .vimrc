" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
endif

" VIM PLUG
call plug#begin('~/.vim/plugged')

Plug 'wting/cheetah.vim'
Plug 'kien/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'alessandroyorba/sidonia'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-sensible'

call plug#end()

" display options {
    colorscheme nord     "change to taste. try `desert' or `evening'

    set wrap                "wrap long lines
    set showcmd             "give command in the status line
    set wildmode=longest:full "make filename-completion more terminal-like
    set wildignore=*.pyc,*.sw[pno],.*.bak,.*.tmp  "files we never want to edit
    set colorcolumn=80,132
" }

" searching {
    set hlsearch            "highlight the search
    set ignorecase          "ignore case
    set smartcase           " ...unless the search uses uppercase letters

    "Use case-sensitive search for the * command though.
    :nnoremap * /\<<C-R>=expand('<cword>')<CR>\>\C<CR>
    :nnoremap # ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>
" }

" Put all .swo files into one dir {
    set undofile
    set undodir=~/.vim/undo

    set backupdir=~/.vim/backup
    set directory=~/.vim/backup
" }

" movement options {
    "enable mouse in normal, visual, help, prompt modes
    "I skip insert/command modes because it prevents proper middle-click pasting
    "TODO: can we get paste to work even with mouse enabled?
    set mouse=nvrh

    " Moving up/down moves visually.
    " This makes files with very long lines much more manageable.
    nnoremap j gj
    nnoremap k gk
    " Moving left/right will wrap around to the previous/next line.
    set whichwrap=b,s,h,l,<,>,~,[,]

    "Bind the 'old' up and down. Use these to skip past a very long line.
    noremap gj j
    noremap gk k
" }

" general usability {
    "turn off the annoying "ding!"
    set visualbell

    "allow setting extra option directly in files
    "example: "vim: syntax=vim"
    set modeline

    "don't clobber the buffer when pasting in visual mode
    vmap P p
    vnoremap p pgvy
" }

" Show spaces and tabs
  set list
  set listchars=tab:»·,trail:·

" windows-style mappings {
    "ctrl+S to save.
    "NOTE: put this in ~/.bashrc for it to work properly in terminal vim:
    "       stty -ixon -ixoff
    map <c-s> :update<cr>
    imap <c-s> <c-o><c-s>
    "ctrl+A to select all
    noremap <c-a> ggVG
    imap <c-a> <esc><c-a>
    "ctrl+C to copy
    map <c-c> "+y
    "ctrl+Y to redo
    map <c-y> <c-r>
    imap <c-y> <c-o><c-r>
    imap <c-r> <c-o><c-r>
    "ctrl+Z to undo
    "map <c-z> u            "this clobbers UNIX ctrl+z to background vim
    imap <c-z> <c-o>u
    "ctrl+Q to save/quit
    map <c-q> :update\|q<cr>
    imap <c-q> <c-o><c-q>
" }

" common typos {
    " Often I hold shift too long when issuing these commands.
    command! Q q
    command! Qall qall
    command! W w
    command! Wall wall
    command! WQ wq
    command! Wq wq
    command! -bang Redraw redraw!
    nmap Q: :q

    " this one causes a pause whenever you use q, so I don't use it
    " nmap q: :q

    "never use Ex mode -- I never *mean* to press it
    nnoremap Q <ESC>

    "never use F1 -- I'm reaching for escape
    noremap  <F1> <ESC>
    noremap! <F1> <ESC>
    lnoremap <F1> <ESC>
" }

" multiple files {
    " be smarter about multiple buffers / vim instances
    "quick buffer switching with TAB, even with edited files
    set hidden
    nmap <TAB> :bn<CR>
    nmap <S-TAB> :bp<CR>
    set shortmess+=IA       "no intro message, no swap-file message

    "replacement for CTRL-I, also known as <tab>
    noremap <C-P> <C-I>

    "window switching: ctrl+[hjkl]
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-H> <C-W>h
    nnoremap <C-L> <C-W>l
    nnoremap <C-Q> <C-W>q
" }

"indentation options {
    set expandtab                       "use spaces, not tabs
    set softtabstop=4 shiftwidth=4      "4-space indents

    set shiftround                      "always use a multiple of 4 for indents
    "DONT USE: smartindent              "it does stupid things with comments

    "smart indenting by filetype, better than smartindent
    filetype on
    filetype indent on
    filetype plugin on
" }

"extra filetypes {
    au BufNewFile,BufRead *.md set filetype=markdown
" }

" tkdiff-like bindings for vimdiff {
    if &diff
        "next match
        nnoremap m ]cz.
        "previous match
        nnoremap M [cz.
        "refresh the diff
        nnoremap R :w\|set nodiff\|set diff<cr>
        "quit, both panes
        nnoremap q :qall<cr>

        "show me the top of the "new" file
        autocmd VimEnter * normal lgg

        "ignore whitespace changes
        set diffopt+=iwhite

        " line numbers when diffing
        windo set nu
    endif
" }


" fix the vimdiff colors
:hi DiffAdd term=bold ctermfg=0 ctermbg=4
:hi DiffChange term=bold ctermfg=0 ctermbg=5
:hi DiffDelete term=bold ctermfg=1 ctermbg=6
:hi DiffText term=reverse cterm=bold ctermbg=9

" Resize windows automatically
autocmd VimResized * wincmd =


" { from http://www.bestofvim.com/tip/diff-diff/
    nnoremap <Leader>df :call DiffToggle()<CR>

    function! DiffToggle()
        if &diff
            diffoff
        else
            diffthis
        endif
    :endfunction
" }

" vim:et:sts=4:sw=4
