# Only run in interactive shells
case $- in
*i*) ;;
*) return ;;
esac

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# --------------------------- history -------------------------------
HISTCONTROL=ignoreboth # Ignore duplicates & commands starting with space
HISTSIZE=5000          # Commands kept in memory
HISTFILESIZE=10000     # Commands saved across sessions
shopt -s histappend    # Don't overwrite history, append to it

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# --------------------------- smart prompt ---------------------------
#                 (keeping in bashrc for portability)

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
    local P='$' dir="${PWD##*/}" B countme short long double \
        r='\[\e[31m\]' h='\[\e[34m\]' \
        u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
        b='\[\e[36m\]' x='\[\e[0m\]' \
        g="\[\033[38;2;90;82;76m\]"

    [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
    [[ $PWD = / ]] && dir=/
    [[ $PWD = "$HOME" ]] && dir='~'

    B=$(git branch --show-current 2>/dev/null)
    [[ $dir = "$B" ]] && B=.
    countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

    [[ $B == master || $B == main ]] && b="$r"
    [[ -n "$B" ]] && B="$g($b$B$g)"

    short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
    long="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n${g}╚$p$P$x "
    double="${g}╔$u\u$g$PROMPT_AT$h\h$g:$w$dir\n${g}║$B\n${g}╚$p$P$x "

    if ((${#countme} > PROMPT_MAX)); then
        PS1="$double"
    elif ((${#countme} > PROMPT_LONG)); then
        PS1="$long"
    else
        PS1="$short"
    fi
}

wd() {
    dir="${PWD##*/}"
    parent="${PWD%"/${dir}"}"
    parent="${parent##*/}"
    echo "$parent/$dir"
} && export wd

PROMPT_COMMAND="__ps1"

# ----------------------------- dircolors ----------------------------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if _have dircolors; then
    if [[ -r "$HOME/.dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Created by `pipx` on 2025-02-14 12:19:38
export PATH="$PATH:/home/saviola/.local/bin"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/bin/nvim
export PATH="$HOME/lua-language-server/bin:$PATH"
export PATH=$PATH:"$(go env GOPATH)/bin"
export PATH="$HOME/Scripts/:$PATH"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

set-editor() {
    export EDITOR="$1"
    #	export VISUAL="$1"
    #	export GH_EDITOR="$1"
    #	export GIT_EDITOR="$1"
    alias vi="\$EDITOR"
}
_have "vim" && set-editor vi
_have "nvim" && set-editor nvim
