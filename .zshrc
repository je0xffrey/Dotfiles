# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/avr/bin:$HOME/.local/bin:/usr/local/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export LS_COLORS='di=1;35:ln=02;31:so=32:pi=0;33:ex=00:bd=34;46:cd=34;43:su=0;41:sg=0;46:ow=1;35:*.pdf=0;33:*.md=00;93:*.txt=0:*.py=0'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 13
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"
zstyle ':completion:*' list-colors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# vi mode
bindkey -v
export KEYTIMEOUT=1

alias ll="ls -1G"
alias ls="ls -F --color=auto"

# python
alias python="python3"

setopt PROMPT_SUBST
# alias to reload zshrc
alias zshreload="source ~/.zshrc"

# john the ripper
alias john="~/security/jtr/run/john"

# %n for full hostname, %m is just up to the first period
PROMPT='%F{5}[%F{7}%B%m%b: %F{green}/%F{5}%3~] $%f ' 

#PROMPT='%B%F{7}%1~%f%b %# '

# use lf to switch directories + binds to control o
lfcd () { 
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# fast ctrlz to zip in and out of vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

bindkey '^R' history-incremental-search-backward

bindkey -s '^o' 'lfcd\n'
alias bday="~/Dotfiles/scripts/bday"
alias tint="redshift -l 36.778259:-119.417931 > /dev/null 2>&1 &"
alias untint="pkill -15 -f redshift"

bday

# source ~/Dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
