#kfa
# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi
# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles
# Screenshot: http://i.imgur.com/s0Blh.png

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
			export TERM=gnome-256color
	elif infocmp xterm-256color >/dev/null 2>&1; then
				export TERM=xterm-256color
		fi

		if tput setaf 1 &> /dev/null; then
			tput sgr0
				if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
					MAGENTA=$(tput setaf 9)
					ORANGE=$(tput setaf 172)
					GREEN=$(tput setaf 190)
					PURPLE=$(tput setaf 141)
					WHITE=$(tput setaf 256)
				else
					MAGENTA=$(tput setaf 5)
					ORANGE=$(tput setaf 4)
					GREEN=$(tput setaf 2)
					PURPLE=$(tput setaf 1)
					WHITE=$(tput setaf 7)
				fi
				BOLD=$(tput bold)
				RESET=$(tput sgr0)
				else
					MAGENTA="\033[1;31m"
					ORANGE="\033[1;33m"
					GREEN="\033[1;32m"
					PURPLE="\033[1;35m"
					WHITE="\033[1;37m"
					BOLD=""
					RESET="\033[m"
				fi

			function parse_git_dirty() {
				[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
			}

			function parse_git_branch() {
				git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
			}

PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#attempt at new prompt
#PS1='\[\e[1;32m\]\u@\h:\[\e[m\] \e[0;34m\]\W $ \e[m\]'

# Make bash check its window size after a process completes
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


#aliases - kfa
alias ll='ls -alG'
alias ls='ls -G'
alias t='~/.todo/todo.sh -d ~/.todo/todo.cfg'
alias less='less -R'

# Human readable
alias du='du -h'
alias df='df -h'

#aliases -kfa for ssh'ing into machines
alias slicehost='ssh root@slicehost'
alias spain='ssh root@spain'
alias f105='ssh root@f105'
alias lambo='ssh root@lambo'
alias tw-server='ssh root@tw-server'
alias acb12='ssh root@acb12'
alias region-server='ssh region-server'
alias login-server='ssh login-server'
alias aws-server='ssh aws-server'

#settings and functions taking from hmason
# auto-completion is not case sensitive anymore
bind "set completion-ignore-case on"

#dont hit tab twice for auto complete
bind "set show-all-if-ambiguous on"

# Tab completion for sudo
complete -cf sudo

###

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
