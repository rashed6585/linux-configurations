#!/bin/bash

# uninstall python if exist

BIN_PATH=/usr/local/bin
LIB_PATH=/usr/local/lib


if [[ $# -eq 0 ]]; then
    echo "You must provide at least one Python version."
    exit 2
fi

echo "You are about to uninstall the following Python versions:
"
for VER do
    echo " * ${VER}"
done
read -p "
THIS ACTION IS IRREVERSIBLE. Are you sure you want to continue? (y/N): " confirm && [[ $confirm == [yY] ]] || exit 1

for VER do
    echo "Uninstalling Python $VER..."

    # Check if Python version exists.
    if [[ ! -f "${BIN_PATH}/python${VER}" ]]; then
        echo "That Python version is not installed, or you have supplied a patch version."
        exit 2
    fi

    # Remove files.
    sudo rm -rf "${BIN_PATH}/2to3-${VER}" \
        "${BIN_PATH}/idle${VER}" \
        "${BIN_PATH}/pip${VER}" \
        "${BIN_PATH}/pydoc${VER}" \
        "${BIN_PATH}/python${VER}" \
        "${BIN_PATH}/python${VER}-config" \
        "${LIB_PATH}/libpython${VER}.a" \
        "${LIB_PATH}/python${VER}" \
        "${LIB_PATH}/python${VER}-embed.pc" \
        "${LIB_PATH}/python${VER}.pc"
done

echo "All done!"


# install python
if [[ $# -eq 0 ]]; then
    echo "You must provide at least one Python version."
    exit 2
fi

echo "Configuring packages..."
sudo apt-get update -qq && sudo apt-get upgrade -qq
sudo apt-get install -qq \
    build-essential \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    liblzma-dev \
    libncurses5-dev \
    libnss3-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    pkg-config \
    tk-dev \
    wget \
    zlib1g-dev

cd /tmp

for VER do
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
    wget -q https://www.python.org/ftp/python/$PARTIAL/Python-$VER.tgz

    if [[ ! -f Python-$VER.tgz ]]; then
        echo "That Python version does not exist."
        exit 2
    fi

    tar -xf Python-$VER.tgz

    echo "Building Python $VER..."
    cd Python-$VER
    ./configure -q --enable-optimizations --with-ensurepip=install --with-system-ffi
    make -s -j $(nproc)

    echo "Installing Python $VER..."
    sudo make -s altinstall
done

echo "All done!"