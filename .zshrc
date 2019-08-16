# ------------------------------------
# 環境変数
# ------------------------------------
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
#POWERLEVEL9K_ALWAYS_SHOW_USER=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(rbenv dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time date)
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

ZSH_THEME="powerlevel9k/powerlevel9k"

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# tmux
export TERM="xterm-256color"
# ------------------------------------
# alias
# ------------------------------------
alias ls="ls -S -F"
alias la="ls -a"
alias ll="ls -l"
alias vf="vim +VimFiler"
alias be="bundle exec"
alias gdc="git diff --cached"
alias doc="docker"
alias docp="docker-compose"
alias dogs="docker-compose logs -f"

# ------------------------------------
# 環境設定
# ------------------------------------
# 他のターミナルとヒストリーを共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

# コマンド入力ミスを修正
setopt correct

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# rbenv
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init - zsh)"

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# goenv
# export GOENV_ROOT=$HOME/.goenv
# export PATH=$GOENV_ROOT/bin:$PATH
# eval "$(goenv init -)"

# go lang
# export GOPATH=$HOME/go
# export PATH=$PATH:$GOPATH/bin

# direnv
eval "$(direnv hook zsh)"

# curlでクエスチョン
setopt nonomatch

# ------------------------------------
# zplug
# ------------------------------------

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit

# plugins
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
# zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "supercrabtree/k"
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "b4b4r07/enhancd", use:init.sh
zplug "paulirish/git-open", as:plugin
zplug "zsh-users/zsh-syntax-highlighting", defer:2
: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む(option --verbose)
zplug load

# ------------------------------------
# bind_keys
# ------------------------------------
# タブに名前を付ける
function tab_rename() {
	BUFFER="echo -ne \"\e]1;"
	CURSOR=$#BUFFER
	BUFFER=$BUFFER\\a\"
}
zle -N tab_rename
bindkey '^[tab_rename' tab_rename

# ------------------------------------
# cd
# ------------------------------------
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
chpwd() {
  # cdしたらtreeを表示
  tree -L 1
  # 現在のディレクトリ名をタブに表示 for iTerm2
  # echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
  # echo -ne "\e]1;${PWD##*/}\a"

  # ブランチ名によってタブの色を変える
  tab-reset
  git-current-branch-color
}

precmd() {
  # 現在のディレクトリ名をタブに表示 for iTerm2
  echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
}

# ------------------------------------
# iTerm2 Tab Color
# ------------------------------------
function git-current-branch-color {
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if $(echo $PWD | grep coinfx > /dev/null); then
    tab-color 255 255 0
  elif $(echo $PWD | grep rehaplan > /dev/null); then
    tab-color 255 105 180
  elif $(echo $PWD | grep ma_navi > /dev/null); then
    tab-color 65 105 225
  elif $(echo $PWD | grep karte-io-systems > /dev/null); then
    tab-color 184 0 34
  elif $(echo $PWD | grep karte-io > /dev/null); then
    tab-color 42 171 159
  elif $(echo $PWD | grep plaidev > /dev/null); then
    tab-color 184 0 34
  fi
}

tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
color-ssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "production|ec2-.*compute-1" ]]; then
            tab-color 255 0 0
        else
            tab-color 0 255 0
        fi
    fi
    ssh $*
}
compdef _ssh color-ssh=ssh

alias ssh=color-ssh
