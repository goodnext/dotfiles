"文字コード設定
set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set fileformats=unix,dos,mac

"表示
colorscheme molokai
set t_Co=256
set number

"コメントを濃い緑にする
autocmd ColorScheme * highlight Comment ctermfg=50 guifg=#008800
"""""""""""""""
"挿入モード時、ステータスラインの色を変更
"""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx','', '')
  return hl
endfunction

"ステータスラインを常に表示
set laststatus=2

"ステータスラインに文字コードと改行コードを表示
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

"入力系
"タブを入力するとスペースに変換
set smarttab

"バックスースペース入力すると4つ削除される
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
syntax on

if has("syntax")
    " PODバグ対策
    syn sync fromstart
    function! ActivateInvisibleIndicator()
    "下の行の"　"は全角スペース
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
   highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endfunction
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

"タブ可視化
set listchars=tab:>-

"perl系
autocmd FileType pl,pmperl,cgi :compiler perl  
map ,pt <Esc>:%! perltidy -se<CR>


" netrwは常にtree view
let g:netrw_liststyle = 3
" .svnと.vimとで始まるファイルは表示しない
let g:netrw_list_hide = '.svn,.vim,.pki'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
 let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

"classメソッドへ遷移させる
au BufNewFile,BufRead  set tags+=$HOME/tags

"tagジャンプの時に複数あるときは一覧表示
nnoremap <C-]> g<C-]> 



