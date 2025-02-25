#!/bin/bash

echo "installing zsh, exa, bat, vim ..."
cd ~
sudo apt update && sudo apt upgrade
sudo apt install zsh wget exa bat vim git unzip curl -y
echo "$(zsh --version) installation done!"
echo "$SHELL is current shell"
sed -i "2 i if test -t 1;then exec zsh fi" ~/.bashrc
echo "$SHELL is current shell"
echo "installing ohmyzsh..."
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "installing plugins..."
cd ~
# git -c http.sslVerify=false clone
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
# https://safjan.com/top-popular-zsh-plugins-on-github-2023/
cd /tmp
git clone https://github.com/rashed6585/linux-configurations.git
cp -f /tmp/linux-configurations/dotfiles/.zshrc ~/
source ~/.zshrc
echo "configuring vim..."
mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
cp -f /tmp/linux-configurations/dotfiles/.vimrc ~/
echo "installing uv"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
echo "installation done"
