# =======================================================================================
# .zshrc
# @tasasaki
# =======================================================================================

# =======================================================================================
# setup
# =======================================================================================
#{{{
fpath=(${HOME}/.conf/.zsh/function/Completion ${fpath})
setopt no_beep
setopt nolistbeep
setopt interactive_comments
setopt numeric_glob_sort
setopt rm_star_silent
unsetopt no_clobber

setopt list_packed
#}}}

# =======================================================================================
# color
# =======================================================================================
#{{{
autoload colors; colors
#}}}

# =======================================================================================
# prompt
# =======================================================================================
#{{{
PROMPT="%{${fg[cyan]}%}-- `today` %* --%{${reset_color}%}
%(!.#.$) "
RPROMPT="%{${fg[red]}%}[%n@%m:%d]%{${reset_color}%}"
PORMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
SPROMPT="%B%{${fg[red]}%}correct?%{${reset_color}%}%b: %R -> %r "
#}}}

# =======================================================================================
# completion
# =======================================================================================
#{{{
autoload -U compinit; compinit

setopt auto_cd
setopt auto_menu
setopt correct
setopt magic_equal_subst
setopt noautoremoveslash
setopt list_types
setopt print_eight_bit

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#}}}

# =======================================================================================
# keybynd
# =======================================================================================
#{{{
#bindkey '^U' backward-kill-line
#bindkey "^h" backward-kill-word

bindkey "^[OA" history-beginning-search-backward-end
bindkey "^[OB" history-beginning-search-forward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#}}}

# =======================================================================================
# history
# =======================================================================================
#{{{
HISTFILE=${HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_reduce_blanks

setopt auto_pushd
setopt pushd_ignore_dups

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
#}}}

# =======================================================================================
# terminal
# =======================================================================================
#{{{
setopt complete_aliases

case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxFxCxdxBxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

case "${TERM}" in
xterm|xterm-color|kterm|kterm-color)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac
#}}}

# =======================================================================================
# screen
# =======================================================================================
#{{{
function ssh_screen(){
	eval server=\${$#}
	screen -t $server ssh "$@"
}

#if [ "$TERM" = "screen" ]; then
#	alias ssh=ssh_screen
#	chpwd () { echo -n "`dirs`\\" ; ll }
#	preexec () {
#		emulate -L zsh
#		local -a cmd; cmd=(${(z)2})
#		case $cmd[1] in
#			fg)
#				if *1; then
#					cmd=(builtin jobs -l %+)
#				else
#					cmd=(builtin jobs -l $cmd[2])
#				fi
#				;;
#			%+)
#				cmd=(builtin jobs -l $cmd[1])
#				;;
#			cd)
#				if *2; then
#					cmd[1]=$cmd[2]
#				fi
#				;&
#			*)
#				echo -n "k$cmd[1]:t\\"
#				return
#				;;
#		esac
#		local -A jt; jt=(${(kv)jobtexts})
#		$cmd >>(read num rest
#			cmd=(${(z)${(e):-\$jt$num}})
#			echo -n "k$cmd[1]:t\\") 2>/dev/null
#	}
#	chpwd
#fi
#}}}

