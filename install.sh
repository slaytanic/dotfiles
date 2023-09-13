#!/bin/sh

SOURCE=$(dirname "$0")
DEST=$HOME

if [ "$(uname)" == "Darwin" ]; then
    if [ ! -f /opt/homebrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if [ -f /etc/debian_version ]; then
        if sudo -n true 2>/dev/null; then
            sudo apt install zsh curl git
        fi
    fi
else
    echo "This is neither a Mac OS X nor a Linux system."
    exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cp $SOURCE/.zshrc $DEST
cp $SOURCE/.p10k.zsh $DEST
