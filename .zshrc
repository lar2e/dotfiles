# ------------------------------------
# 環境変数
# ------------------------------------
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1
#POWERLEVEL9K_ALWAYS_SHOW_USER=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time history time)
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

ZSH_THEME="powerlevel9k/powerlevel9k"

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# ------------------------------------
# alias
# ------------------------------------
alias ls="ls -S -F"
alias la="ls -a"
alias ll="ls -l"
alias vf="vim +VimFiler"
alias be="bundle exec"
alias coinfx="cd /Users/kayamadaiji/repos/techfactory-jp/coinfx/"
alias rehab="cd ~/repos/rehab/rehaplan/"
alias gdc="git diff --cached"
alias doc="docker"
alias docp="docker-compose"

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
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# goenv
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

# go lang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# ------------------------------------
# zplug
# ------------------------------------

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit
# プロンプトを変更
#prompt pure

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

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

# ------------------------------------
# powershell
# ------------------------------------
zplug "b-ryan/powerline-shell"

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in ${precmd_functions[@]}; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

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
  echo -ne "\e]1;${PWD##*/}\a"
  # ブランチ名によってタブの色を変える
  tab-reset
  git-current-branch-color
}

# ------------------------------------
# git
# ------------------------------------
function git-current-branch-color {
  if [ ! -e ".git" ]; then
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  if $(echo $PWD | grep coinfx > /dev/null); then
    tab-color 255 255 0
  elif $(echo $PWD | grep rehaplan > /dev/null); then
    tab-color 255 105 180
  elif $(echo $PWD | grep ma_navi > /dev/null); then
    tab-color 65 105 225
  fi
}

# ------------------------------------
# iTerm2
# ------------------------------------
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
