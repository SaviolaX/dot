#!/bin/bash
# shellcheck disable=SC1090,SC1091

case $- in
*i*) ;; # interactive
*) return ;;
esac

# ----------------------- env variables ------------------------------

export scripts="$HOME/Scripts/"
export PATH=$HOME/.local/bin:$PATH

# -------------------------- aliases ---------------------------------

alias scripts='cd $HOME/Scripts'
alias upd_config='$scripts/save_config'
alias upd_bash='source $HOME/.bashrc'

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -l --color=auto'

alias zed=''
 
# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }


# --- Colored Man Pages (Gruvbox Material Style) ---

export LS_COLORS="di=38;5;245:fi=38;5;223:ln=38;5;179:ex=38;5;108:*.txt=38;5;223"
# Start bold (yellow)
export LESS_TERMCAP_md=$'\e[01;33m'
# Start blinking (magenta)
export LESS_TERMCAP_mb=$'\e[01;35m'
# End all mode (reset)
export LESS_TERMCAP_me=$'\e[0m'
# Start standout/search highlight (greenish)
export LESS_TERMCAP_so=$'\e[01;38;5;108m'
# End standout
export LESS_TERMCAP_se=$'\e[0m'
# Start underline
export LESS_TERMCAP_us=$'\e[04;38;5;142m'
# End underline
export LESS_TERMCAP_ue=$'\e[0m'

# Ensure less handles the colors correctly
export MANPAGER="less -R --use-color -Dd+y -Du+b"
export GROFF_NO_SGR=1

# ------------------------------- pager ------------------------------

if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# ----------------------------- dircolors ----------------------------

if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
shopt -s histappend

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

	if _have tmux && [[ -n "$TMUX" ]]; then
		tmux rename-window "$(wd)"
	fi
}

wd() {
	dir="${PWD##*/}"
	parent="${PWD%"/${dir}"}"
	parent="${parent##*/}"
	echo "$parent/$dir"
} && export wd

PROMPT_COMMAND="__ps1"

# ----------------------------- keyboard -----------------------------

# only works if you have X and are using graphic Linux desktop

_have setxkbmap && test -n "$DISPLAY" &&
	setxkbmap -option caps:escape &>/dev/null

set-editor() {
	export EDITOR="$1"
	export VISUAL="$1"
	export GH_EDITOR="$1"
	export GIT_EDITOR="$1"
	alias vi="\$EDITOR"
}
_have "vim" && set-editor vi
_have "nvim" && set-editor nvim
