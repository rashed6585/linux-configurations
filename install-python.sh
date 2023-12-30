#!/bin/bash

BIN_PATH=/usr/local/bin
LIB_PATH=/usr/local/lib

# check arguments 
if [[ $# -eq 0 ]]; then
    echo "You must provide at least one Python version."
    exit 2
fi

# store argument in VER
VER=$1

# uninstall current version
PYTHON_F_VER_EXIST="$(cut -d ' ' -f2 <<< $(python3 --version))"
PYTHON_VER_EXIST_1="$(cut -d . -f1 <<< $PYTHON_F_VER_EXIST)"
PYTHON_VER_EXIST_2="$(cut -d . -f2 <<< $PYTHON_F_VER_EXIST)"
PYTHON_S_VER_EXIST=$PYTHON_VER_EXIST_1.$PYTHON_VER_EXIST_2

echo "removing existing python3 version $PYTHON_F_VER_EXIST"

read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    sudo apt remove python3.11
    sudo apt autoclean && sudo apt autoremove

    # Remove files.
    sudo rm -rf "${BIN_PATH}/2to3-${PYTHON_S_VER_EXIST}" \
        "${BIN_PATH}/idle${PYTHON_S_VER_EXIST}" \
        "${BIN_PATH}/pip${PYTHON_S_VER_EXIST}" \
        "${BIN_PATH}/pydoc${PYTHON_S_VER_EXIST}" \
        "${BIN_PATH}/python${PYTHON_S_VER_EXIST}" \
        "${BIN_PATH}/python${PYTHON_S_VER_EXIST}-config" \
        "${LIB_PATH}/libpython${PYTHON_S_VER_EXIST}.a" \
        "${LIB_PATH}/python${PYTHON_S_VER_EXIST}" \
        "${LIB_PATH}/python${PYTHON_S_VER_EXIST}-embed.pc" \
        "${LIB_PATH}/python${PYTHON_S_VER_EXIST}.pc"
fi

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

echo "$(python3 --version) installation done!"  