
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias ls="ls -S -F"
alias la="ls -a"
alias ll="ls -l"
alias vf="vim +VimFiler"

export PATH=$HOME/.nodebrew/current/bin:$PATH


# added by Anaconda3 4.3.1 installer
export PATH="/anaconda/bin:$PATH"

# rbenv
eval "$(rbenv init -)"

# gitコマンドをhomebrewに変更
export PATH="/usr/local/Cellar/git/2.15.1_1/bin:$PATH"

# vim を homebrewに変更
export PATH="/usr/local/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
