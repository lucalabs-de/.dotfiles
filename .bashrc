# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1="\W \[\e[1m\]λ \[\e[0m\]"

alias dots="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
