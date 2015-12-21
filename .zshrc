# -------------------------------------
# 環境変数
# -------------------------------------

# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# エディタ
export EDITOR=/usr/bin/vim
#export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim

# ページャ
#export PAGER=/usr/local/bin/vimpager
export PAGER=/usr/bin/less
#export MANPAGER=/usr/local/bin/vimpager
export MANPAGER=/usr/bin/less


# -------------------------------------
# zshのオプション
# -------------------------------------

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
#setopt auto_cd

# -------------------------------------
# パス
# -------------------------------------

# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath

export JAVA_HOME=`/usr/libexec/java_home`
#export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

path=(
    ${JAVA_HOME}/bin
    /Users/takano/.sdkman/springboot/current/bin
#    /Users/takano/.sdkman/groovy/current/bin
    /Users/takano/.sdkman/candidates/groovy/current/bin
#    /Users/takano/.sdkman/gradle/current/bin
    /Users/takano/.sdkman/candidates/gradle/current/bin
    ${NODEBREW_ROOT}/bin
    /usr/local/heroku/bin
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    /usr/bin
    /usr/sbin
    /sbin
    /bin
    /Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/db/bin
    $HOME/.rbenv/bin
    ~/.rbenv/shims
    $HOME/.nodebrew/current/bin
    /usr/local/Cellar/s3cmd/1.6.0/bin/s3cmd
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------

autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b]" '%m' '<!%a>'
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

OK="^_^ "
NG="X_X "

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# -------------------------------------
# エイリアス
# -------------------------------------

# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

#MacVim設定
# alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
# alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mVim "$@"'
# alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mVim "$@"'

# eclipse -clean
alias cleanec='/Applications/Eclipse.app/Contents/MacOS/eclipse -clean'

alias sshcon='vi ~/.ssh/config'
alias subl='open -a /Applications/Sublime\ Text.app'


# -------------------------------------
# キーバインド
# -------------------------------------

bindkey -e

function cdup() {
   echo
   cd ..
   zle reset-prompt
}
#zle -N cdup
#bindkey '^K' cdup

bindkey "^R" history-incremental-search-backward
# -------------------------------------
# その他
# ------------------kkkkjjjiii:::-------------------

# jjkkjjjcdしたあとで、自動的に ls する
function chpwd() { ls -1 }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}

#Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="cloud"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# sdkman settings
export SDKMAN_DIR="/Users/takano/.sdkman"
[[ -s "/Users/takano/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/takano/.sdkman/bin/sdkman-init.sh"

#rbenvの設定
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# zsh-completions settings
fpath=(/path/to/homebrew/share/zsh-completions $fpath)
 
# nodebrew setting
export NODEBREW_ROOT=~/.nodebrew/current

# nodebrew-completions settings
fpath=($fpath /usr/local/share/zsh/site-functions)
 
autoload -U compinit
compinit -u

CATALINA_HOME=/usr/local/Cellar/tomcat7/7.0.64/libexec

#SPRING_PROFILES_ACTIVE=locondo-development
