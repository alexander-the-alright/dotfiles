# ========================================================================
# Auth:dodd
# File: setup.sh
# Revn: 01-04-2025  1.0
# Func: automate pi setup
#
# TODO
# [X]   get link to newer version of go
# [X]   make useful directories
# [ ]   build TDM
# [ ]   build ekho
# [ ]   make symlinks to executables to ~/bin
# [ ]   make symlinks to source in ~/src
# [X]   make symlinks to .bashrc + friends
# [ ]   connect to internet
# [ ]   test?
# ========================================================================
# CHANGE LOG
# ------------------------------------------------------------------------
# 07-05-2023:  added apt installs for vim, neofetch, tmux
# 07-06-2023:  install stuffs for golang, rust, github
# 07-10-2023:  added apt install for tshark
# 07-11-2023:  mv calls for github/bash and github/TDM
#              building TDM
#              sudo echo calls for /etc/dhcpcd.conf for static ip
#              empty and refill /etc/motd
#              enabled ssh?
#              fixed typo in golang download, had one, wanted L
# 10-07-2024:  updated git clone commands
#              symlink command for bashrc + friends
#              added big todo list
#              made bin/src directories
# 12-14-2024:  updated golang version number
#*01-04-2025:  added command to install nmap
#              uncommented building TDM and mv'ing binary to ~/bin
#              built ekho, moved to ~/bin/
#              copied, built, and moved donut/boot to ~/src/ and ~/bin/
#
# ========================================================================

# update apt
sudo apt update && sudo apt upgrade

# install vim
sudo apt install -y vim

# install neofetch
sudo apt install -y neofetch

# install tmux
sudo apt install -y tmux

# install tshark
sudo apt install -y tshark

# install nmap
sudo apt install -y nmap

# TODO get newer version of Go
# install golang
wget https://dl.google.com/go/go1.21.1.linux-armv6l.tar.gz
sudo tar -C /usr/local -xzf go1.21.1.linux-armv6l.tar.gz
rm go1.21.1.linux-armv6l.tar.gz
echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
echo "GOPATH=$HOME/go" >> ~/.profile

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# create the directory "Documents" if it doesn't exist
# if it does exist, who cares TODO test
cd ~
mkdir bin
mkdir src
mkdir Documents 2> /dev/null
cd Documents

# github treats
# lol good luck, without a PAT, this shit BREAKS
# start with my stuff
git clone https://github.com/alexander-the-alright/dotfiles
git clone https://github.com/alexander-the-alright/TDM
git clone https://github.com/alexander-the-alright/soary
git clone https://github.com/alexander-the-alright/ekho

# TODO make go
# build todo manager
go build TDM/tdm.go
mv tdm ~/bin/tdm

# make ekho
go build ekho/client
mv client ~/bin/client.o

# TODO symlinks
cd ~
ln -sf ~/Documents/dotfiles/pi/.vim ~/.vim
ln -sf ~/Documents/dotfiles/.vimrc ~/.vimrc
ln -sf ~/Documents/dotfiles/pi/.bash_profile ~/.bashrc

# copy and build binaries
cp ~/Documents/dotfiles/pi/donut.c ~/src
cp ~/Documents/dotfiles/pi/boot.go ~/src
gcc -o donut.o src/donut.c
gcc -o boot src/boot.go
mv boot ~/bin/
mv donut.o ~/bin/

# elsewhere
git clone https://github.com/stianeikeland/go-rpio
git clone https://github.com/golemparts/rppal


# TODO internet

# XXX this dumb router breaks this
# create static local ip address
#sudo echo "" >> /etc/dhcpcd.conf
#sudo echo "" >> /etc/dhcpcd.conf
#sudo echo "interface wlan0" >> /etc/dhcpcd.conf
#sudo echo "static ip_address=192.168.1.160/24" >> /etc/dhcpcd.conf
#sudo echo "static routers=192.168.1.1" >> /etc/dhcpcd.conf
#sudo echo "static domain_name_servers=192.168.1.1" >> /etc/dhcpcd.conf

# enable ssh?
sudo touch /boot/ssh

