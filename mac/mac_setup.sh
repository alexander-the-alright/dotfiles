# ==============================================================================
# Auth: Alex Celani
# File: mac_setup.sh
# Revn: 09-09-2023  0.1
# Func: re-setup terminal tools in mac
#
# TODO: create
# ==============================================================================
# CHANGE LOG
# ------------------------------------------------------------------------------
# 09-09-2023: init
#
# ==============================================================================

brew help > out 2> errout
rm out

if [ -s errout ]; then
    rm errout
    echo "installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi


brew install gcc
brew install go
brew install htop
brew install neofetch
brew install onefetch
brew install rust
brew install tmux
brew install wireshark


echo "pull up the github PAT"

cd ~/Documents/
mkdir work
cd work

git clone https://github.com/alexander-the-alright/dotfiles
cp dotfiles/mac/.zshrc ~/
cp dotfiles/mac/.vimrc ~/
cp -r dotfiles/mac/.vim ~/

/usr/local/bin/gcc-13 -o donut dotfiles/mac/donut.c > /dev/null 2> errout

if [ -s errout ]; then
    rm errout
    echo "gcc failed"
else
    mv donut ~/
fi


git clone https://github.com/alexander-the-alright/TDM
go build TDM/tdm.go
mv tdm ~/

git clone https://github.com/alexander-the-alright/soary

