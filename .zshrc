# vi mode
bindkey -v
export KEYTIMEOUT=1

alias ll="ls -1G"
alias ls="ls -F"

setopt PROMPT_SUBST
# alias to reload zshrc
alias zshreload="source ~/.zshrc"

# %n for full hostname, %m is just up to the first period
PROMPT='%F{5}[%F{7}%B%m%b:%F{5}${PWD/#$HOME/~}] $%f ' 

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
bindkey -s '^o' 'lfcd\n'

source /Users/jeffrey.hertzog/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
