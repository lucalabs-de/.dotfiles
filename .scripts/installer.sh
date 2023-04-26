#!/bin/bash

echo "#### Installing Dotfiles ####"

git init --bare $HOME/.dotfiles

COMMAND="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"



echo "alias dots='$COMMAND'" >> $HOME/.bashrc

$COMMAND config status.showUntrackedFiles no
$COMMAND remote add origin git@github.com:lucalabs-de/.dotfiles.git
$COMMAND fetch --all
$COMMAND reset --hard origin/master


