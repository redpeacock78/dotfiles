"----------基本設定----------
"文字コードをUTF-8に
set encoding=utf-8
"マルチバイト文字の使用
scriptencoding utf-8
"保存時の文字コード
set fileencoding=utf-8
"読み込み時の文字コードの自動判別. 左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
"改行コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac
"□や○文字が崩れる問題を解決
set ambiwidth=double
"スワップファイルを作らない
set noswapfile
"入力中のコマンドをステータスに表示
set showcmd
"バックスペースの有効化
set backspace=indent,eol,start
"----------ここまで----------



"----------外見・機能設定----------
"行番号の表示
set number
"インデントをスマートインデントに
set smartindent
"カッコにカーソルが当たったときに対になるカッコを強調
set showmatch
"ステータスラインを表示
set laststatus=2
"現在の行を強調
set cursorline
"現在の列を強調"
set cursorcolumn
"シンタックスハイライトの表示
syntax on
"インクリメンタルサーチ. １文字入力毎に検索を行う
set incsearch
"検索パターンに大文字小文字を区別しない
set ignorecase
"検索パターンに大文字を含んでいたら大文字小文字を区別する
set smartcase
"検索結果をハイライト
set hlsearch
"ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
"コマンドモードの補完
set wildmenu
"保存するコマンド履歴の数
set history=5000
"vimテーマ有効化
set background=dark
colorscheme solarized
"-----------ここまで----------



"-----------NeoBundle----------
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/neobundle.vim
"NeoBundleが未インストールであればgit cloneする
if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
  echo "install NeoBundle..."
  :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
endif
call neobundle#begin(expand('~/.vim/bundle/'))

"NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"------ここから下に入れたいNeobundle pluginを書く------
"NERDTree
NeoBundle 'scrooloose/nerdtree'
"自動で隠しファイル表示
let NERDTreeShowHidden = 1
"vimを開いた時点で自動起動
autocmd VimEnter * execute 'NERDTree'
"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"powerline
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
set guifont=Migu_1M_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'
let g:Powerline_theme='solarized256'
let g:Powerline_colorscheme='solarized256'
colorscheme solarized

"vim-airline
"NeoBundle 'vim-airline/vim-airline'
"NeoBundle 'vim-airline/vim-airline-themes'
"let g:airline_powerline_fonts=1
"let g:airline_solarized_bg='dark'
"let g:airline_theme='jellybeans'
"-------------------------ここまで-------------------------

call neobundle#end()
filetype plugin indent on
"未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする
NeoBundleCheck
"-------------ここまで-------------



"-----------機能関係-----------
".vimrcを再読み込み
autocmd BufEnter * if &modifiable | map <silent><C-r> :source ~/.vimrc<CR> | endif
"マウスを有効化
set mouse=a
"ペースト時に自動インデントをさせない
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"
  function XTermPasteBegin(ret)
	set paste
	return a:ret
  endfunction
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"----------ここまで-----------


"-----------キーマッピング---------
"ファイルを保存しないで終了
map <C-e> :q!<CR>
"ファイルの内容を保存して終了
map <C-z> :wq<CR>
"-----------ここまで-----------

