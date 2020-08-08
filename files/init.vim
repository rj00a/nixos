" Enable line numbers.
set number

" Line numbers are close to the edge of the window.
set numberwidth=3

" Disable visual line wrapping
set nowrap

" Set column limit for formatting with 'gq'.
set textwidth=100

" Do not move the cursor to the first column when typing '#' in .c files.
set cinkeys=0{,0},0),:,!^F,o,O,e

" Incremental Search.
" Jumps to the next match as you type.
set incsearch

" Highlight search results.
set hlsearch

" Disable case sensitive searches.
set ignorecase

" Become case sensitive while searching only if search string contains at least one capital letter.
set smartcase

" Vertical splits will put new windows right of the current window.
" Horizontal splits will put new windows above the current window.
set splitright

" Enable mouse support.
set mouse+=a

" In Gvim, remove the menu bar, toolbar, and scrollbar completely.
set guioptions=aegit

" Hide the tab line.
set showtabline=0

" Treat octal numbers like decimal numbers, becuase that's what they are most of the time.
set nrformats=bin,hex

" Don't insert two spaces after sentence-ending punctuation with a join command.
set nojoinspaces

" Hide the startup message.
set shortmess=I

" Share with system clipboard.
set clipboard^=unnamedplus

" Automatically reload files when they are modified externally.
set autoread

" Make history greater than default.
set history=500

" Always show the stuff at the bottom.
set ruler

" Less backslashes needed in regular expressions by default.
set magic

" Disable annoying error sounds.
set noerrorbells
set novisualbell

" Don't redraw screen while executing macro.
" Good for performance.
set lazyredraw

" Disable swap files, because we have version control anyway.
set noswapfile

" Shows a vertial completion menu when pressing <tab> in the command buffer.
set wildmenu
set wildmode=longest:full,full

" Shows the input of an incomplete command.
set showcmd

" Allows switching between multiple unsaved buffers.
set hidden

" Backspace unconditionally works against auto indentation and more.
set backspace=indent,eol,start

" Render tabs, trailing spaces, and non-breaking spaces.
set list
set listchars=tab:>\ ,space:\ ,trail:-

" Pressing tab inserts two spaces.
" Hard tabs appear two spaces wide.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Copy indent from current line when starting new line.
set autoindent

" Prevents exrc and other stuff from running potentially dangerous shell commands.
set secure

" Keep the cursor centered.
set scrolloff=999

" Enable syntax highlighting.
syntax on

" Detect filetype.
filetype plugin indent on

" The font for gvim.
set guifont=Inconsolata\ 12

" Make the cursor number line the same as the others.
hi CursorLineNR guifg=#020202 guibg=#444444

" Red and black cursor.
hi Cursor guifg=#000000 guibg=#ff0000 ctermfg=0 ctermbg=9

" Set the leader key to space
let mapleader = " "

" Makes Y consistent with C and D
noremap Y "*y$

" Paste with indent (`] is a special mark)
"noremap p p=`]
"noremap P P=`]

" Move display lines up/down, rather than actual lines.
" Useful when line wrap is enabled.
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" Clear search buffer.
nnoremap <silent> <esc> :noh<cr>

" Disable the annoying message in the command line when using Ctrl-c.
nnoremap <c-c> <silent> <c-c>

" Closes the current buffer without closing the window.
" Also doesn't leave any [New File]s around.
" Provided vim-bbye.
noremap <silent> <leader>k :up\|Bdelete<cr>
noremap <silent> <leader>K :Bdelete!<cr>

" Save and quit everything.
noremap <leader>q :wqa<cr>

" Write file with sudo permissions.
noremap <leader>W :w !sudo tee %<cr>
noremap <silent> <leader>w :up<cr>

" Open vertical terminal.
"noremap <silent> <leader>t :vert term<cr>

" Exit terminal mode.
"tnoremap <esc> <c-\><c-n>

" Toggle the floating terminal
nnoremap <silent> <c-q> :FloatermToggle<cr>
tnoremap <silent> <c-q> <c-\><c-n>:FloatermToggle<cr>

" Rebind K to be a complement to J.
vnoremap K <esc>i<cr><esc>k$
noremap K i<cr><esc>k$

" Switch between buffers.
noremap <silent> <c-k> :bp<cr>
inoremap <silent> <c-k> <esc>:bp<cr>
noremap <silent> <c-j> :bn<cr>
inoremap <silent> <c-j> <esc>:bn<cr>

" Session slots.
"nnoremap <leader>1 <esc>:wa\|mksession! ~/.config/nvim/sessions/1.vim<cr>
"nnoremap <leader>! <esc>:so ~/.config/nvim/sessions/1.vim<cr>
"nnoremap <leader>2 <esc>:wa\|mksession! ~/.config/sessions/2.vim<cr>
"nnoremap <leader>@ <esc>:so ~/.config/nvim/sessions/2.vim<cr>
"nnoremap <leader>3 <esc>:wa\|mksession! ~/.config/nvim/sessions/3.vim<cr>
"nnoremap <leader># <esc>:so ~/.config/nvim/sessions/3.vim<cr>

" Source this file.
nnoremap <leader>- <esc>:so %\|AirlineToggle\|AirlineToggle<cr>

" Delete trailing whitespace in buffer. (Or selection).
nnoremap <leader>0 :%s/\s\+$//e\|noh\|up<cr>
vnoremap <leader>0 :s/\s\+$//e\|noh\|up<cr>

" Toggle spell checking locally.
nnoremap <leader>9 :setlocal spell!<cr>

" Toggle hard line wrapping.
nnoremap <leader>8 :call ToggleHardLineWrap()<cr>

" Search for file with fzf.
nnoremap <leader>f :Files<cr>

" List files in git repo.
nnoremap <leader>F :GFiles<cr>

" Grep for string using ripgrep.
nnoremap <leader>s :Rg<cr>

" Search for open buffer.
nnoremap <leader>b :Buffers<cr>

" Search marks.
nnoremap <leader>m :Marks<cr>

" Search lines in open buffers.
nnoremap <leader>l :Lines<cr>

" Search v:oldfiles and open buffers.
nnoremap <leader>h :History<cr>

" Search Search history.
nnoremap <leader>/ :History/<cr>

" Search command history
nnoremap <leader>: :History:<cr>

" Toggle the NERDTree buffer.
nnoremap <silent> <leader>d :NERDTreeToggle<cr><c-w>=

" Open the NERDTree buffer and change the root to the CWD.
nnoremap <silent> <leader>c :NERDTreeCWD<cr><c-w>=

" List files from `git status`.
nnoremap <silent> <leader>gf :GFiles?<cr>

" List git commits for current buffer.
nnoremap <silent> <leader>gc :BCommits<cr>

" List git commits.
nnoremap <silent> <leader>gC :Commits<cr>

" Prompt for name of binary to start debugging.
"noremap <leader>g <esc>:Termdebug<space>
"noremap <leader>G <esc>:TermdebugCommand<space>

" For emacs bindings in the command line.
" See :help emacs-keys.
cnoremap <c-a> <home>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-e> <end>
cnoremap <c-f> <right>
cnoremap <c-n> <down>
cnoremap <c-p> <up>
" My own idea.
cnoremap <c-h> <s-left>
cnoremap <c-l> <s-right>

" Move the cursor left and right in insert mode
inoremap <c-f> <right>
inoremap <c-b> <left>

"" Alduin Colorscheme
" Darker background.
let g:alduin_Shout_Dragon_Aspect = 1

" Use underline matchparens instead of block.
let g:alduin_Shout_Aura_Whisper = 1

" Disable string background highlight.
let g:alduin_Shout_Animal_Allegiance = 1

colo alduin

" Disable help text.
let g:NERDTreeMinimalUI = 1

" Show hidden files.
let g:NERDTreeShowHidden = 1

" Don't hijack the netrw commands, because it opens an unkillable buffer which is annoying.
let g:NERDTreeHijackNetrw = 0

" Getting real tired of seeing junk in my home directory.
let g:NERDTreeBookmarksFile = "/tmp/.NERDTreeBookmarks"

" " How long to show highlighted yanked text (millis).
" let g:highlightedyank_highlight_duration = 150
" 
" " Make the yanked region color the same as the alduin search color.
" " TODO: neovim 5.0 makes the highlightedyank plugin obsolete.
" hi HighlightedyankRegion guifg=#dfdfaf guibg=#875f5f gui=NONE ctermfg=187 ctermbg=95 cterm=NONE

" Change the fzf layout to a popup instead of the default split.
let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.85 } }

" Set the size of the floating terminal
let g:floaterm_width = 0.95
let g:floaterm_height = 0.95

" Don't run zig fmt after saving.
let g:zig_fmt_autosave = 0

" Disable the abomination known as netrw.
let g:loaded_netrwPlugin = 1

" Show the list of open buffers and tabs at the top of the screen.
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Modify the default ignored buffer names so that neovim's terminal shows up in the bufferline.
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'

" Make the bufferline prettier.
let g:airline#extensions#bufferline#left_sep = ' '
let g:airline#extensions#bufferline#right_sep = ' '
let g:airline#extensions#bufferline#left_alt_sep = ' '
let g:airline#extensions#bufferline#right_alt_sep = ' '

"Make the tabline prettier.
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = ' '

" On the tabline, only show the file name with the full path on the right.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Set Airline theme with the vim-airline-themes plugin.
let g:airline_theme = 'atomic'

" Make fzf match the color scheme (Doesn't fully work for :Rg).
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal'],
\ 'hl': ['fg', 'Comment'],
\ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+': ['fg', 'Statement'],
\ 'info': ['fg', 'PreProc'],
\ 'border': ['fg', 'Ignore'],
\ 'prompt': ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker': ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header': ['fg', 'Comment'] }

" Exit fzf with escape. (Takes precedence over exiting terminal mode).
autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>

" Get the cursor to stay in the center of the screen at all times, except when at the top of the
" buffer.
" In other words, the cursor should never be in the bottom half of the screen.
" This is a different effect from just doing :set so=999
" CursorMovedI could not be used due to some unintended behavior with `zz` in insert mode.
"autocmd! CursorMoved * :normal zz
"autocmd! InsertEnter * :normal zz
"inoremap <cr> <cr><c-o>zz
"inoremap <bs> <bs><c-o>zz
"inoremap <c-w> <c-w><esc>zza
"inoremap <c-u> <c-u><esc>zza

" checktime makes autoread actually do what it's supposed to do.
autocmd! CursorHold * checktime

" Language plugins like to set formatoptions, but I don't want them doing that.
" (See :h fo-table)
autocmd! BufNewFile,BufRead * setlocal fo=q

" Open help buffers as a right split.
autocmd! BufEnter *.txt if &buftype == 'help' | wincmd L | endif

" Disable scrolloff when inside terminal buffers.
"autocmd! BufEnter * if &buftype == 'terminal' | set so=1 | else | set so=999 | endif

" Start NERDTree when opening vim on a directory.
autocmd! StdinReadPre * let s:std_in=1
autocmd! VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Close Vim when the NERDTree buffer is the only one left.
autocmd! BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" When editing Haskell, use two-space indentation.
autocmd! FileType haskell setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab

" When switching buffers, preserve window view.
autocmd! BufLeave * call AutoSaveWinView()
autocmd! BufEnter * call AutoRestoreWinView()

" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings when switching buffers.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

function! ToggleHardLineWrap()
    if &fo =~ 't'
        set fo-=t
        echo 'Hard line wrap disabled'
    else
        set fo+=t
        echo 'Hard line wrap enabled'
    endif
endfunction

noh

