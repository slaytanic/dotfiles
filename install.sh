#!/bin/sh

SOURCE=$(dirname "$0")
DEST=$HOME

if [ "$(uname)" = "Darwin" ]; then
    if [ ! -f /opt/homebrew/bin/brew ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        brew tap homebrew/command-not-found
    fi
elif [ "$(uname -s)" = "Linux" ]; then
    if [ -f /etc/debian_version ]; then
        if sudo -n true 2>/dev/null; then
            sudo apt install zsh curl git command-not-found
        fi
    fi
else
    echo "This is neither a macOS nor a GNU/Linux system."
    exit 1
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    omz update
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

cp "$SOURCE/.zshrc" "$DEST"
cp "$SOURCE/.p10k.zsh" "$DEST"
