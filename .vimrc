try
    colorscheme colorsbox-material
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry


set number
set rnu
set nocompatible

"if your backspace doesn't work, you need: 
set backspace=2

"Auto cd into dir of open file
set autochdir

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Spaces feel like tabs
set softtabstop=4
" Use spaces instead of tabs
set expandtab


" Linebreak on 500 characters
set lbr
set tw=500


"Auto indent
set ai
"Smart indent
set si
"Wrap lines
set wrap


" Don't redraw while executing macros (good performance config)
set lazyredraw

" Sets how many lines of history VIM has to remember
set history=700

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"#################################################
" Tools
"#################################################

" Tab completion
"imap <Tab> <C-P>
"set wildmode=longest:full,full
"## This is dumb. Install supertab.


"#################################################
" Navigation
"#################################################


nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" Control HJKL to swap directionally between vimsplits.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Shift J | K to swap between tabs
nnoremap <S-j> gT
nnoremap <S-k> gt


"#################################################
" GUI
"#################################################

"No top toolbar
try
    set guioptions -=T
catch
    "lol
endtry


" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show current position
set ruler

" Show leader-based commands
set showcmd

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Make Vim's splitting behavior more normal
set splitbelow
set splitright


set tabline=%!MyTabLine()

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1 
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1]) 
  return fnamemodify(label, ":t") 
endfunction


"#################################################
" Searching Options
"#################################################


" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

"in visual mode, // searches for highlighted values
vnoremap // y/<C-R>"<CR>


"#################################################
"   Functions
"#################################################

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"Control-n to toggle between True Numbers and True-Relative Numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set rnu!
  else
    set relativenumber
  endif
endfunc

"Control-m -- Toggle between T/R Nums && No Nums
function! TNumberToggle()
  if(&relativenumber == 1)
    set number!
    set rnu!
  else
    set number
    set relativenumber
  endif
endfunc

"in visual mode, // searches for highlighted values
vnoremap // y/<C-R>"<CR> 
nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <C-m> :call TNumberToggle()<cr>


"###############################################
" Toggle plugins                               "
"###############################################

" F5 to toggle UndoTree Plugin
nnoremap <F5> :UndotreeToggle<cr> 

" F5 to toggle System File Tree (NERDtree plugin)
nnoremap <F6> :NERDTreeToggle<cr>

" F8 to toggle tagbar plugin
nmap <F8> :TagbarToggle<CR> 

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"###############################################
" For copy/pasting. Uncomment based on your OS "
"###############################################

vnoremap <s-y> y :redir! > ~/.vimbuffer <bar> echon @* <bar> redir END <CR> <CR>
vnoremap <s-p> :'<,'>!cat ~/.vimbuffer<CR>
nnoremap <s-p> :r ~/.vimbuffer<CR>

if has('macunix')
    ""######### LINUX WITH XCLIP ########
    "" shift-(y)oink  to (y)oink  to   clipboard (On Mac)
    "vnoremap <s-y> :w !pbcopy<cr><cr>
    "" shift (p)loink to (p)loink from clipboard (On Mac)
    "nnoremap <s-p> :r !pbpaste<cr>
"
else
    ""######### LINUX WITH XCLIP ########
    "" shift-(y)oink  to (y)oink  to   clipboard (On Linux w/ xclip)
    "vnoremap <s-y> :w !xclip -i -sel c<cr><cr>
    "" shift (p)loink to (p)loink from clipboard (On Linux w/ xclip)
    "nnoremap <s-p> :r !xclip -o -sel -c<cr>

    ""######### LINUX WITH XSEL #########
    "" shift-(y)oink  to (y)oink  to   clipboard (On Linux w/ xsel)
    ""vnoremap <s-y> :w !xsel -i -b<cr><cr>
    "" shift (p)loink to (p)loink from clipboard (On Linux w/ xsel)
    ""nnoremap <s-p> :r !xsel -o -b<cr>
endif


"###############################################
" Marcos                                       "
"###############################################


" Basic makefile. lol
let @m = "CXX=g++\nFLAGS=-g -std=c++11 -Wall -W\nPROG=\n\n$(PROG): main.o thing1.o thing2.o\n\t$(CXX) $(FLAGS) -o $(PROG) main.o thing1.o thing2.o\n\nthing1.o: thing1.cpp thing1.h\n\t$(CXX) $(FLAGS) -c thing1.cpp\n\nthing2.o: thing2.cpp thing2.h thing1.h\n\t$(CXX) $(FLAGS) -c thing2.cpp\n\nmain.o: main.cpp thing1.h thing2.h\n\t$(CXX) $(FLAGS) -c main.cpp\n\nclean: \n\trm *.o $(PROG)"


"###############################################
" Other Stuff                                  "
"###############################################

"For Vim.Pathogen
execute pathogen#infect()
"set term=builtin_beos-ansi
au BufRead,BufNewFile *.gpl    set filetype=gpl
filetype plugin indent on
syntax on
