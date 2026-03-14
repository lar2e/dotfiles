# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ================================================================================================
# ZSH Configuration
# ================================================================================================

# ------------------------------------------------------------------------------------------------
# PATH & System Setup
# ------------------------------------------------------------------------------------------------
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$HOME/.local/share/mise/shims:$PATH"
export PATH="/Users/daiji.kayama/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------------------------------------------------------------
# Terminal & Locale Configuration
# ------------------------------------------------------------------------------------------------
export TERM="xterm-256color"
export LC_ALL=ja_JP.UTF-8
export EDITOR=nvim
export VISUAL=nvim

# ------------------------------------------------------------------------------------------------
# History Configuration
# ------------------------------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
setopt histignorealldups

# ------------------------------------------------------------------------------------------------
# Shell Options
# ------------------------------------------------------------------------------------------------
setopt correct
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt nonomatch

# ------------------------------------------------------------------------------------------------
# Completions
# ------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit

# ------------------------------------------------------------------------------------------------
# Sheldon Plugin Manager
# ------------------------------------------------------------------------------------------------
eval "$(gh completion -s zsh)"
eval "$(task --completion zsh)"

# SSH completion from ~/.ssh/config
function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' | awk '{print $2}' | sort) }

# ------------------------------------------------------------------------------------------------
# PowerLevel10k Theme
# ------------------------------------------------------------------------------------------------
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------------------------------------------
# FZF Shell Integration
# ------------------------------------------------------------------------------------------------
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh

# ------------------------------------------------------------------------------------------------
# Environment Managers
# ------------------------------------------------------------------------------------------------
eval "$(mise activate zsh)"

# ------------------------------------------------------------------------------------------------
# Aliases - File Operations
# ------------------------------------------------------------------------------------------------
alias la="ls -a"
alias ll="ls -l"
alias cat="bat"
alias grep="rg"
# alias find="fd"  # スクリプト互換性のためコメントアウト

# ------------------------------------------------------------------------------------------------
# Aliases - Development Tools
# ------------------------------------------------------------------------------------------------
alias vim="nvim"
alias vf="vim +VimFiler"

# Git aliases
alias gdc="git diff --cached"

# ------------------------------------------------------------------------------------------------
# Aliases - Applications
# ------------------------------------------------------------------------------------------------
alias chrome="open -a 'Google Chrome'"

# ------------------------------------------------------------------------------------------------
# Aliases - Tmux
# ------------------------------------------------------------------------------------------------
if [ $SHLVL = 2 ]; then
  alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/new-session"
fi
alias ta="tmux attach"
alias tat="tmux attach -t"
alias tad="tmux attach -d -t"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tksv="tmux kill-server"
alias tkss="tmux kill-session -t"

# ------------------------------------------------------------------------------------------------
# Aliases - Utilities
# ------------------------------------------------------------------------------------------------
alias osa="osascript -e 'display notification \"script done🚀\"' && afplay /System/Library/Sounds/Hero.aiff"

# ------------------------------------------------------------------------------------------------
# Directory Navigation
# ------------------------------------------------------------------------------------------------
precmd() {
  # Display current directory in iTerm2 tab
  echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"
}

# ------------------------------------------------------------------------------------------------
# Key Bindings
# ------------------------------------------------------------------------------------------------
function tab_rename() {
	BUFFER="echo -ne \"\e]1;"
	CURSOR=$#BUFFER
	BUFFER=$BUFFER\\a\"
}
zle -N tab_rename
bindkey '^[tab_rename' tab_rename

# ------------------------------------------------------------------------------------------------
# Local Overrides (not tracked in git)
# ------------------------------------------------------------------------------------------------
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
