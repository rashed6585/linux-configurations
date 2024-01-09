#!/bin/bash

echo "installing zsh, exa, bat, vim ..."
sudo apt update && sudo apt upgrade
sudo apt install zsh wget exa bat vim git -y
echo "$(zsh --version) installation done!"
echo "$SHELL is current shell"
sed -2i "if test -t 1;then exec zsh fi" >> ~/.bashrc
echo "$SHELL is current shell"
echo "installing ohmyzsh..."
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "installation done"