#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "You must provide at least one Python version."
    exit 2
fi

VER=$1

PYTHON_VER_EXIST_1="$(cut -d . -f1 <<< $VER)"
PYTHON_VER_EXIST_2="$(cut -d . -f2 <<< $VER)"
PYTHON_S_VER_EXIST=$PYTHON_VER_EXIST_1.$PYTHON_VER_EXIST_2

python_version=$(python3 --version 2>&1)
echo "Current python version: $python_version"

echo "Configuring packages..."
sudo apt update && sudo apt upgrade
sudo apt install \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    wget -y

cd /tmp

if [[ $VER == *"a"* ]]; then
    PARTIAL="$(cut -d 'a' -f 1 <<< $VER)"
elif [[ $VER == *"b"* ]]; then
    PARTIAL="$(cut -d 'b' -f 1 <<< $VER)"
elif [[ $VER == *"rc"* ]]; then
    PARTIAL="$(cut -d 'r' -f 1 <<< $VER)"
else
    PARTIAL=$VER
fi

echo "Downloading Python $VER..."
wget https://www.python.org/ftp/python/$PARTIAL/Python-$VER.tgz

if [[ ! -f Python-$VER.tgz ]]; then
    echo "That Python version does not exist."
    exit 2
fi

# Unzip python
tar -xvf Python-$VER.tgz

# unpack python and install
echo "Building Python $VER..."
cd Python-$VER
./configure --enable-optimizations
make
# make -s -j $(nproc)

echo "Installing Python $VER..."
sudo make altinstall
# sudo make -s altinstall

echo "Update alternatives Python to $PYTHON_S_VER_EXIST"
sudo update-alternatives --install /usr/bin/python python /usr/local/bin/python$PYTHON_S_VER_EXIST 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python$PYTHON_S_VER_EXIST 1

sudo update-alternatives --config python

echo "$(python3 --version) installation done!"

echo "Installing vscode"
