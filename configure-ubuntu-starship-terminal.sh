#!/bin/bash

cd ~
sudo apt update && sudo apt upgrade
# install zsh
sudo apt install zsh wget exa bat vim fzf git net-tools unzip -y
echo "$(zsh --version) installation done!"
echo "$SHELL is current shell"
sed -i "2 i if test -t 1;then exec zsh fi" ~/.bashrc
echo "$SHELL is current shell"
# install ohmyzsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "installing plugins..."
cd ~
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate
git clone https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bat
# https://safjan.com/top-popular-zsh-plugins-on-github-2023/
cd /tmp
git clone https://github.com/rashed6585/linux-configurations.git
cp -f /tmp/linux-configurations/dotfiles/.zshrc ~/
cp -f /tmp/linux-configurations/dotfiles/aliases.zsh ~/.oh-my-zsh/custom/
source ~/.zshrc
mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
cp -f /tmp/linux-configurations/dotfiles/.vimrc ~/
# install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
# Add the following to the end of ~/.zshrc:
eval "$(starship init zsh)" 
# create configure file
mkdir -p ~/.config && touch ~/.config/starship.toml
cp -f /tmp/linux-configurations/dotfiles/starship.toml ~/.config/
# install tmux
sudo apt install tmux
# install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp -f /tmp/linux-configurations/dotfiles/.tmux.conf ~/
# Press prefix + I (capital i, as in Install) to fetch the plugin.