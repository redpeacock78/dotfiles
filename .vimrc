"----------基本設定----------"
"文字コードをUTF-8に"
"set fenc=utf-8
"スワップファイルを作らない"
set noswapfile
"入力中のコマンドをステータスに表示"
set showcmd
"----------ここまで----------"



"----------外見設定----------"
"行番号の表示"
set number
"インデントをスマートインデントに"
set smartindent
"カッコを入力するときに対になるカッコを自動入力"
set showmatch
"ステータスラインを表示"
set laststatus=2
"現在の行を強調"
set cursorline
"シンタックスハイライトの表示"
syntax on
"vimテーマ有効化"
set background=dark
colorscheme  solarized
"-----------ここまで----------"



"-----------NeoBundle----------"
set nocompatible
filetype off
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
 
"------ここから下に入れたいNeobundle pluginを書く------"
"NERDTree"
NeoBundle 'scrooloose/nerdtree'
"自動で隠しファイル表示"
let NERDTreeShowHidden = 1
"vimを開いた時点で自動起動"
autocmd VimEnter * execute 'NERDTree'
"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"powerline"
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
set guifont=Migu_1M_for_Powerline:h11:cANSI
let g:Powerline_symbols='fancy'
let g:Powerline_theme='solarized256'
let g:Powerline_colorscheme='solarized256'
colorscheme solarized

"vim-airline"
"NeoBundle 'vim-airline/vim-airline'
"NeoBundle 'vim-airline/vim-airline-themes'
"let g:airline_powerline_fonts=1
"let g:airline_solarized_bg='dark'
"let g:airline_theme='jellybeans'
"-------------------------ここまで-------------------------"

call neobundle#end()
filetype plugin indent on
"-------------ここまで-------------"



"-----------機能関係-----------"
".vimrcを再読み込み"
autocmd BufEnter * if &modifiable | map <silent><C-r> :source ~/.vimrc<CR> | endif
"マウスを有効化"
set mouse=a
"----------ここまで-----------"


"-----------キーマッピング---------"
"ファイルを保存しないで終了"
map <C-e> :q!<CR>
"ファイルの内容を保存して終了"
map <C-z> :wq<CR>
"-----------ここまで-----------"