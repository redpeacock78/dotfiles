###zsh-plugin###
fpath=(/usr/local/share/zsh-completions $fpath)
##zsh-history-substring-search##
if [ -f /Users/redpeacock78/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /Users/redpeacock78/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi
##fzf##
if [ -f /Users/redpeacock78/.fzf.zsh ]; then
  source /Users/redpeacock78/.fzf.zsh
fi
##peco##
function peco-select-history() {                           
    BUFFER=$(\history -n 1 | tac | peco --query "$LBUFFER")
    CURSOR=$#BUFFER                                        
    zle clear-screen                                       
}                                                          
zle -N peco-select-history                                 
bindkey '^r' peco-select-history
##incr##
if [ -f /Users/redpeacock78/.zsh/incr*.zsh ]; then
  source /Users/redpeacock78/.zsh/incr*.zsh
fi

###補完機能###
autoload -Uz compinit;
compinit -u


###zsh-plugin(syntax)###
##zsh-syntax-highlighting##
if [ -f /Users/redpeacock78/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /Users/redpeacock78/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
##zsh-url-highlighter##
if [ -f /Users/redpeacock78/.zsh/zsh-url-highlighter/url/url-highlighter.zsh ]; then
  source /Users/redpeacock78/.zsh/zsh-url-highlighter/url/url-highlighter.zsh
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern url)
ZSH_HIGHLIGHT_STYLES[url-good]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[url-bad]='fg=magenta,bold'

###zstyle###
zstyle ':completion:*:default' menu select=2 #補完候補を ←↓↑→ でも選択出来るようにする
zstyle ':completion:*' use-cache true #apt-getとかdpkgコマンドをキャッシュを使って速くする
zstyle ':completion:*' list-separator '-->' #オプション補完でセパレータを設定する

###PROMPT内で変数展開・コマンド置換・算術演算を実行###
setopt prompt_subst

###カーソル位置は保持したままファイル名一覧を順次その場で表示###
setopt always_last_prompt

###補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)###
setopt list_types

###日本語ファイル名等8ビットを通す###
setopt print_eight_bit

###語の途中でもカーソル位置で補完###
setopt complete_in_word

###コマンドラインでも # 以降をコメントと見なす###
setopt interactive_comments

###*とか[]をコマンドに合わせてうまく認識させる###
setopt nonomatch

###色を使用する###
autoload -Uz colors;
colors

###色の定義###
DEFAULT="%{[1;m%}" #色のリセット
RED="%{[38;5;9m%}" #赤色
GREEN="%{[38;5;10m%}" #緑色
BLUE="%{[38;5;27m%}" #青色1
BLUE2="%{[38;5;20m%}" #青色2
PURPLE="%{[38;5;5m%}" #紫色
YELLOW="%{[38;5;226m%}" #黄色

###文字コード設定###
export LANG=ja_JP.UTF-8 #シェルで使用する文字コードをJP.UTF-8に

###lessシンタックスハイライト###
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

###言語関連###
##swift-PATH##
export PATH="/home/redpeacock978/swift-3.0.2-RELEASE-ubuntu16.04/usr/bin:$PATH"
##pyhton-PATH##
export PATH="$HOME/.pyenv/shims:$PATH"
##ryby-PATH##
export PATH="/usr/bin/ruby:$PATH"
###C#(mono)-PATH###
export PATH="/opt/mono/bin:$PATH"
###GO-PATH##
export GOPATH="/home/redpeacock978/go"
export PATH="/home/redpeacock978/go/bin:/usr/local/go/bin:$PATH"
##ShellScript-PATH##
export PATH="/home/redpeacock978/bin:$PATH"
###etc-PATH###
export PATH="/usr/games/:$PATH"
###coreutils###
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
###fink##
source /sw/bin/init.sh
###独自コマンド###
export PATH="/Users/redpeacock78/bin:$PATH"

###byobu-prompt###
[ -r /home/redpeacock978/.byobu/prompt ] && . /home/redpeacock978/.byobu/prompt

###プロンプト表示設定###
PROMPT="%B%(?.%(!.${PURPLE}.${GREEN}).${RED})%n"@"%m${DEFAULT}:${BLUE}%~${DEFAULT}%(!.#.$)%b " #メインプロンプト(通常時は緑、root時は紫、コマンドがエラーだった場合次に表示されるプロンプトは赤)
PROMPT2="%B%(?.%(!.${PURPLE}.${GREEN}).${RED})%n"@"%m${DEFAULT}:${BLUE}%~${DEFAULT}%(!.#.$)%b${BLUE2}%_> ${DEFAULT}" #セカンダリプロンプト
SPROMPT="%B%U${YELLOW}Correct${DEFAULT}%u: ${RED}%R${DEFAULT} 👉 ${BLUE}%r${DEFAULT} ?%b [No/Yes/About/Edit] " #コマンド訂正表示
RPROMPT="[%D{%Y/%m/%d %H:%M:%S}]" #右プロンプト時刻表示
#右プロンプト時刻自動更新
TRAPALRM () { zle reset-prompt }
TMOUT=01

##vcs_info機能呼び出し##
autoload -Uz vcs_info
###git(vcs_info)関連###
setopt prompt_subst
CHECK=$'\U2714'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}[!]"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}[+]"
zstyle ':vcs_info:*' formats "%F{green}[${CHECK} ]%c%u%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=$PROMPT'${vcs_info_msg_0_}'

###コマンド履歴###
HISTFILE=~/.zsh_history
HISTSIZE=6000000 #メモリに展開する履歴数
SAVEHIST=6000000 #保存する履歴数
setopt histignorealldups  #ヒストリーに重複を表示しない
setopt share_history  #他のターミナルと履歴を共有
setopt inc_append_history #シェルを横断して.zsh_historyに記録

###コマンド履歴検索###
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

###ディレクトリの指定で移動###
setopt auto_cd

###移動したディレクトリを記録###
setopt auto_pushd

###コマンド訂正###
setopt correct

###補完候補表示時のビープ音無効化###
setopt nolistbeep

###ビープ音の停止###
setopt NO_beep

###補完候補を詰めて表示###
setopt list_packed

###aliasの設定をrootの時だけ分ける###
case ${UID} in
  0)
    alias checkports='pkg_version -v -l \<'
    alias updateports='cd /usr/ports && make update fetchindex && checkports'
    alias updateindex='cd /usr/ports && make index && portsdb -u'
    alias portsclean portsclean -CD
    ;;
esac

###ウィンドウタイトルに現ユーザー、ホスト、現ディレクトリ表示###
precmd() {echo -ne "\033]0;${USER}@${HOST}:$(pwd | sed -e "s,^$HOME,~,g")\007"}

###alias設定###
alias /='../'
alias ls="ls -F --color=auto"
alias la="ls -A --color=auto"
alias ll="ls -l --color=auto"
alias lsr="ls -lR --color=auto"
alias lst="ls -ltr --color=auto"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias PATH="echo $PATH"
alias HOME="echo $HOME"
alias quit="exit"
alias vi="vim"
alias na="nano"
alias by="byobu"
alias nu="nautilus"
alias scl="clear"
alias alien"sudo alien -i"
alias vict="vimcat"
alias viles="/usr/share/vim/vim80/macros/less.sh"
alias dfc="sudo dfc"
alias dir="\ls -F | grep / >> .01.txt && column -x .01.txt && rm -f 01.txt"
alias fil="\ls -F | grep -v / >> .01.txt && column -x .01.txt && rm -f 01.txt"
alias grep="grep $GREP_OPTIONS"
alias als='(){ if find *(/) -prune > /dev/null 2>&1; then; echo -e "\e[34;1m$(find *(D/) -prune | sed -e "s/$/\//g" | tr "\n" " ")\e[m"; elif find *(D.) -prune > /dev/null 2>&1; then; echo -e "\e[32;1m$(find *(*) -prune 2>/dev/null | sed -e "s/$/\*/g" | tr "\n" " ")\e[m"$(find *(D^*/) -prune 2>/dev/null); fi }'
alias bcomrank='cat ~/.bash_history|cut -f1 -d" "|sort|uniq -c|sort -nr|head -n10'
alias zcomrank='cat ~/.zsh_history|cut -f1 -d" "|sort|uniq -c|sort -nr|head -n10'
##組み合わせ系##
alias mkcd='(){ mkdir -p "$@" && eval cd "\"\$$#\""; }'
alias excd='(){ cd $(pwd)/$1 }'
alias acdls='(){ cd $1 && als }'
alias awk="gawk"
alias ul='(){ unbuffer "$@" |& less -iSRM }'
alias ucl='(){ unbuffer ccat --bg=dark “$@“ |& less -iSRM }'
alias mount="mount-usb iTunes mount"
alias unmount="mount-usb iTunes unmount"
##デバイスアドレス差分抽出##
alias devad="ls -l /dev/ > /tmp/before.txt && ls -l /dev/ > /tmp/after.txt && diff /tmp/before.txt /tmp/after.txt"

###alias-ruby-shell###
alias rb="irb" #rubyの対話式シェルirbを実行
##ruby-ver-change##
alias rbev="rbenv versions"
alias rbeg="rbenv global"
alias rbel="rbenv local"
alias rbeser="rbenv install -l"
alias rbeinst="rbenv install"

###特殊コマンド(編集不可)###
##権限関連##
alias s="su"
alias SU="sudo -E su -" #現在の設定を引き継ぎながらroot権限の取得(パスワードは現在のユーザーのもの)
alias sudo="sudo -E " #sudo時でもaliasを有効にし環境変数も引き継ぐ
##zsh設定関連##
alias setrc="\cp -vf /home/redpeacock978/.zshrc /root/.zshrc" #.zshrcを/rootにコピー
alias update="source ~/.zshrc" #~/.zshrcの設定を再読込
alias rezsh='sudo zsh -c "\cp -fv /Users/redpeacock78/.zshrc /root/.zshrc && source ~/.zshrc"'
##Shell関連##
alias shells="cat /etc/shells" #現在インストールされているすべてのシェルのディレクトリを表示
alias relogin="exec $SHELL" #シェルのリセット

###apt関連###
alias aptcl="sudo apt-get clean" #アーカイブファイルの削除
alias aptacl="sudo apt-get autoclean" #使ってないパッケージのアーカイブファイルの削除
alias aptarm="sudo apt-get autoremove" #使ってないパッケージの削除
alias aptup="sudo apt-get update" #パッケージリストの更新
alias aptupgd="sudo apt-get upgrade" #インストールされてるパッケージの更新
alias dist-upgd="sudo apt-get dist-upgrade" #インストールされてるカーネルの更新(Ubuntu)/ディストリビューションの更新(Debian)
alias aptinst="sudo apt-get install" #パッケージのインストール
alias aptrm="sudo apt-get remove" #パッケージのアンインストール
alias aptcs="sudo apt-cache search" #パッケージの検索
alias addrepo="sudo add-apt-repository" #リポジトリの追加
alias aptkey="sudo apt-key adv --keyserver" #公式以外のリポジトリを追加

###aptitude関連###
alias atudecs="aptitude search"
alias atudesh="aptitude show"
alias atudeinst="sudo aptitude install"
alias atuderm="sudo aptitude remove"
alias atudepg="sudo aptitude purge"
alias atudehd="sudo aptitude hold"
alias atudekp="sudo aptitude keep"
alias atudeuhd="sudo aptitude unhold"
alias atudereinst="sudo aptitude reinstall"
alias atudeamk="sudo aptitude markauto"
alias atudeuamk="sudo aptitude unmarkauto"
alias atudefdver="sudo aptitude forbid-version"
alias atudeup="sudo aptitude update"
alias atudesupgd="sudo aptitude safe-upgrade"
alias atudefupgd="sudo aptitude full-upgrade"
alias atudeacl="sudo aptitude autoclean"
alias atudedl="sudo aptitude download"
alias atudehl="sudo aptitude help"

###npm関連###
alias npminst="sudo npm install -g" #npmのパッケージをインストール
alias npmuninst="sudo npm uninstall -g" #npmのパッケージをアンインストール
alias npmup="sudo npm update -g" #npmのパッケージをアップデート
alias npmupgd="sudo npm update -g npm" #npm自身をアップデート
alias npmls="npm ls -g" #npmの中を表示
alias npmhp="npm help 5 folders" #npmのmanを表示
alias npmout="npm outdated -g" #npmの古いglobalパッケージの確認

###git関連###
##リポジトリの作成およびメンテナンス##
alias gitin="git init" #リポジトリを作成する
alias gitcl="git clone" #リポジトリから過去の履歴を含め丸ごと取得
alias gitcl1="git clone --depth 1" #リポジトリから最新版のみを取得
alias gitfs="git fsck" #リポジトリの正当性チェックを行う
alias gitfsf="git fsck --full" #リポジトリの完全な正当性チェックを行う
alias gitg="git gc" #リポジトリ内の不要なオブジェクトを削除し、最適化を行う
##作業ツリーやブランチを操作・管理##
alias gitst="git status" #変更が加えられたファイルを表示する
alias gitdf="git diff" #ファイルに加えられた変更点をdiff形式で表示する
alias gitad="git add" #コミットするファイルを指定する
alias gitcom="git commit" #変更点をコミットする
alias gitcoma="git commit -a" #変更されたファイルを自動検出しコミットするが、新規ファイルは出来ない
alias gitcomm="git commit -m" #コミット時、コメントメッセージでエディタを起動せず直接メッセージを指定
alias gitlg="git log --graph --oneline --decorate=full" #gitの履歴をブランチ表示して色を付ける
alias regit="git reset --soft HEAD^" #直前に行ったコミットを取り消す
alias gitrev="git revert" #作業ツリーを指定したコミット時点の状態にまで戻し、コミットを行う
alias gitbr="git branch" #ブランチ情報の表示およびブランチの作成
alias gitco="git checkout" #ブランチの切り替え
alias gitcob="git checkout -b" #新たにブランチを作成してそのブランチに切り替える
alias gitsb="git show-branch" #ブランチの作成/変更/マージ履歴を表示
alias gitmg="git marge" #現在の作業ブランチに別のブランチで行われた変更点を取り込む
alias gittg="git tag" #直前のコミットに対して分かりやすい別名（タグ）を付ける
alias gitsh="git stash" #現在の作業ツリーの状態を一時的に保存しておく
alias gitreb="git rebase" #ブランチの派生元を変更する
##ほかのリポジトリとの連携##
alias gitpl="git pull" #ほかのリポジトリの変更点をローカルリポジトリにマージする
alias gitps="git push" #公開リポジトリに自分のリポジトリの内容を送信する

###拡張子判別・実行###
##スクリプト言語##
#pythonのファイル指定で実行#
alias -s py='(){ for P in *.py; do
shift && python $P $@ 
done}'
#rubyのファイル指定で実行#
alias -s rb='(){ for R in *.rb; do
shift && ruby $R $@ 
done}'
#swiftのファイル指定で実行#
alias -s swift='(){ for S in *.swift; do
shift && swift $S $@ 
done}'
#perlのファイル指定で実行#
alias -s pl='(){ for P in *.pl; do
shift && perl $P $@ 
done}'
#PowerShellスクリプトをファイル指定で実行
alias -s ps1='(){ for P in *.ps1; do
chmod a+x $P && shift && ./$P $@ 
done}'
##コンパイラ言語##
#C言語、C++をファイル指定でコンパイル及び実行#
alias -s {c,cc,cp,cpp,cxx}='(){ gcc -o ${1%.*} $1 && shift && ./${1%.*} $@ }'
#C#をコンパイル及び実行#
alias -s cs='(){ for C in *.cs; do
mcs $C && shift && ./${C/.cs/.exe} $@ 
done}'
#object-Cをコンパイル及び実行#
alias -s m='(){ for M in *.m;do
gcc $M -o ${M%.*} && shift && ./${M%.*} $@ 
done}'
#javaをコンパイル及び実行#
alias -s java='(){ for J in *.java; do
javac $J && shift && java ${J%.*} $@ 
done}'

##ファイル解凍##
#それぞれの拡張子に合わせてファイルを解凍#
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,rar,7z}='(){case $1 in
*.tar.gz|*.tgz) tar xzv ;;
*.tar.xz) tar Jxvf $1;;
*.zip) unzip -Z -;;
*.lzh) lha e $1;;
*.tar.bz2|*.tbz) tar xjvf $1;;
*.tar.Z) tar zxvf $1;;
*.gz) gzip -d $1;;
*.bz2) bzip2 -dc $1;;
*.Z) uncompress $1;;
*.tar) tar xvf $1;;
*.arj) unarj $1;;
*.rar) unrar $1;;
*.7z) 7z $1;;
esac}'
##パッケージインストール・変換##
alias -s {deb,rpm}='(){case $1 in
*.deb) sudo gdebi $1;;
*.rpm) sudo alien -i $1;;
esac}'
###exeファイル###
alias -s exe='(){wine env XMODIFIERS="@im=fcitx" $1}'


###独自コマンド###
alias wi="wiki"
alias wa="wiki -a"

###lsh###
alias lsh="/Users/redpeacock78/lsh/src/lsh"

###お遊び###
##水族館##
alias aqua="asciiquarium"
##FF##
alias ff='cat /home/redpeacock978/5205723/* | sed -e "s/#<undef>//"'
alias ff4='cat /home/redpeacock978/5205723/4.txt | sed -e "s/#<undef>//"'
alias ffbatz='cat /home/redpeacock978/5205723/batz.txt | sed -e "s/#<undef>//"'
alias ffgaluf='cat /home/redpeacock978/5205723/galuf.txt | sed -e "s/#<undef>//"'
alias ffkuro='cat /home/redpeacock978/5205723/kuro.txt | sed -e "s/#<undef>//"'
alias ffsiro='cat /home/redpeacock978/5205723/siro.txt | sed -e "s/#<undef>//"'
##果物##
alias banana='echo "\xf0\x9f\x8d\x8c"'

###256色表示###
function 256() {
    local code
    for c in {000..255}; do
        echo -n "\e[38;5;${c}m $c"; [ $(($c%16)) -eq 15 ] && echo
    done
echo
}

printf "\033[33m$(figlet Welcome! $(echo $USERNAME))\033[00m\n"
