#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# color commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
export LESS='-R --use-color -Dd+y$$Du+b'

PS1='\[\e[1;35m\]\u@\h \[\e[1;34m\]\w\n\[\e[1;37m\]\$\[\e[0m\] '
# PS1='[\u@\h \W]\$ '

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
