# =======================================================================================
# .zshrc
# @tasasaki
# =======================================================================================

# =======================================================================================
# setup
# =======================================================================================
#{{{
umask 022
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
PROMPT="$ "

setprompt () {
	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))
	
	local PROMPTSIZE=${#${(%):--- %D{%R.%S %a %b %d %Y}\! ---}}
	local PWDSIZE=${#${(%):-%~}}
	
	if [[ "$PROMPTSIZE + $PWDSIZE" -gt $TERMWIDTH ]]; then
		(( PR_PWDLEN = $TERMWIDTH - $PROMPTSIZE ))
	fi
    if [[ -n "${WINDOW}" ]]; then
		SCREEN=" S:${WINDOW}"
	else
		SCREEN=""
	fi

	if [[ $(jobs  | wc -l) -gt 0  ]]; then
		JOBS=" J:%j"
	else
		JOBS=""
	fi
    # Need this, so the prompt will work
	setopt prompt_subst
		
	# let's load colors into our environment, then set them
	autoload colors zsh/terminfo
	
	if [[ "$terminfo[colors]" -gt 8 ]]; then
		colors
	fi

	for COLOR in CYAN BLUE RED GREEN YELLOW WHITE BLACK; do
		eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
		eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
	done

	PR_RESET="%{$reset_color%}"

	# Finally, let's set the prompt
	PROMPT='\
${PR_BRIGHT_BLACK}<${PR_RESET}${PR_GREEN}<${PR_BRIGHT_GREEN}<${PR_RESET} \
%D{%R.%S %a %b %d %Y} ${PR_BLUE}!${PR_RESET} %n@%m ${PR_BLUE}!${PR_RESET} \
H:%h${SCREEN}${JOBS}%(?.. E:%?)  ${PR_BLUE}!${PR_RESET} \
%$PR_PWDLEN<...<%~%<< ${PR_BATTERY}${GITBRANCH}\

${PR_BRIGHT_BLACK}>${PR_RESET}%(?.${PR_CYAN}>${PR_BRIGHT_CYAN}>.${PR_RED}>${PR_BRIGHT_RED}>)\
${PR_BRIGHT_WHITE} '

	# Of course we need a matching continuation prompt
	PROMPT2='\
${PR_BRIGHT_BLACK}>${PR_RESET}${PR_GREEN}>${PR_BRIGHT_GREEN}>\
${PR_RESET} %_ ${PR_BRIGHT_BLACK}>${PR_RESET}${PR_GREEN}>\
${PR_BRIGHT_GREEN}>${PR_BRIGHT_WHITE} '
}
setprompt
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
setopt hist_ignore_all_dups
setopt hist_no_store
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

