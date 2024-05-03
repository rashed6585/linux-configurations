# ~/.oh-my-zsh/custom/aliases.zsh

# general
alias help="man"
alias t="tail -f"
alias ff="find . -type f -name"
(($ + commands[fd])) || alias fd='find . -type d -name'
alias fd="find . -type d -name"
alias grep="grep --color"
alias sgrep="grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}"
alias processes="ps -f"
alias apt-update="sudo apt update"
alias apt-upgrade="sudo apt upgrade"

# git
# ! define in ~/.gitconfig

# alias to avoid making mistakes
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rmdir='rm -r -v'


# exa for ls bunding
alias l='exa -l --icons -a'
alias lt='exa --tree --level=2 --long --icons'

# networking
alias ports="netstat -tulnp | grep LISTEN"
alias router="ip route | grep default"
alias ip-private="hostname -I | awk {'print $1}'"
alias ip-public="curl -4 ifconfig.co"

# compilers, repl, etc.
# alias python="python3"

# directories
alias goto-code="cd /mnt/e/Code"

# zsh
alias zshrc="vim ~/.zshrc"
alias zsh-alias="vim ~/.oh-my-zsh/custom/aliases.zsh"
alias refreshenv="source $HOME/.zshrc"

# starship
alias starship-conf="vim ~/.config/starship.toml"

# tmux
# alias tmain="~/.dotfiles/scripts/tmux-folder-session.sh ' main'"
alias tmux-conf="vim ~/.tmux.conf"

# git
# ! define in ~/.gitconfig
if [ -x "$(command -v fzf)" ]; then
  alias commits="git log --oneline | fzf --preview 'git show --name-only {1}'"
fi

# environment
alias env-export="export \$(cat .env)"
path-add() {
  export PATH=$PATH:$1
}

# alternatively, use the 'take' command
mkdircd() {
  mkdir $1
  cd $1
}

# backup file
bak() {
  cp $1{,.bak}
}

# add all permissions
perm-all() {
  chmod -R 777 $1
}

# change owner to me
claim() {
  sudo chown -R $USER $1
}

# file size
alias size-file-list="du -d 1 -ah | sort -h -r"
size-file() {
  du -h $1
}

# directory size
alias size-dir-list="du -d 1 -h | sort -h -r"
size-dir() {
  du -hs $1
}

# tar
compress() {
    FILE_NAME="$(cut -d . -f1 <<< $1)"
    tar -czvf "$FILE_NAME.archive.tar.gz" $1
}
decompress() {
  tar -zxv -f $1
}

# search and use bat as a previewer
if [[ -x "$(command -v fzf)" ]] && [[ -x "$(command -v bat)" ]]; then
  alias fp="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

  supersearch() {
    if [ $# -eq 0 ]; then
      fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
    else
      if [ -d $1 ]; then
        grep -R "$(find $1/* -type f -exec cat {} \; | fzf)" $1/
      else
        cat $1 | fzf
      fi
    fi
  }

  alias sps=supersearch
fi

# URL encoding
if [ -x "$(command -v node)" ]; then
  alias url_encode='node --eval "console.log(encodeURIComponent(process.argv[1]))"'
  alias url_decode='node --eval "console.log(decodeURIComponent(process.argv[1]))"'
fi

# base64
base64_encode() {
  echo -n "$1" | base64
}
base64_decode() {
  echo -n "$1" | base64 -d
}

# colorls: https://github.com/athityakumar/colorls#installation
if [ -x "$(command -v colorls)" ]; then
  alias ls="colorls --group-directories-first"
  alias la="colorls -Al --gs --group-directories-first"
  alias lt="colorls -Al --tree=3 --gs --group-directories-first"
fi

# diff-so-fancy: https://github.com/so-fancy/diff-so-fancy#install
#if [ -x "$(command -v diff-so-fancy)" ]; then
#  diffs() {
#    diff -u $1 $2 | diff-so-fancy
#  }
#fi

# ! WSL2 only
# TODO set username
# alias cd-windows="cd \"/mnt/c/Users/twj/Documents/\""
