" ---------------------------
" Start Neobundle Settings.
" ---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim  ~/.vim/bundle/neobundle.vim")
  endif
                      " runtimepath の追加は必須
set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" neobundle自体をneobundleで管理
" Required:
call neobundle#begin(expand('~/.vim/bundle/ '))
let g:neobundle_default_git_protocol='https'
  
NeoBundleFetch 'Shougo/neobundle.vim'
   
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
" NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Townk/vim-autoclose'

NeoBundle 'Shougo/unite.vim'
" unite {{{
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}

NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}
"Haskell用プラグイン
":GhcModTypeで型の表示
NeoBundle 'eagletmt/ghcmod-vim'
"ghc-modをvimから使えるようにするプラグイン
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'mac' : 'make -f make_mac.mak',
			\    },
			\ }
"インデントプラグイン
NeoBundle 'kana/vim-filetype-haskell'
"補完用プラグイン
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/neco-ghc'
"コードを即座に実行する
NeoBundle 'thinca/vim-quickrun'
"エラーをvim上に表示する
"NeoBundle 'osyo-manga/vim-watchdogs'

call neobundle#end()
     
" Required:
filetype plugin indent on
      
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
"       
"       "-------------------------
"       " End Neobundle Settings.
"       "-------------------------

syntax on
set number

if has('gui_macvim')
    set transparency=3
    set guifont=Menlo:h12
    set lines=56 columns=100
    set guioptions-=T
endif

"Keymaps
"コマンドモード時にカーソル移動するのに便利
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Delete>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
" cnoremap <C-N> <Down>
" cnoremap <C-P> <Up>
