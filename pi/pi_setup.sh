# ========================================================================
# Auth: alex
# File: setup.sh
# Revn: 09-23-2023  1.0
# Func: automate pi setup
#
# TODO: get addnet/pipe to bash stuff to work
#       test?
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
#*09-23-2023:  added command to install nmap
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

# install golang
wget https://dl.google.com/go/go1.14.4.linux-armv6l.tar.gz
sudo tar -C /usr/local -xzf go1.14.4.linux-armv6l.tar.gz
rm go1.14.4.linux-armv6l.tar.gz
echo "PATH=$PATH:/usr/local/go/bin" >> ~/.profile
echo "GOPATH=$HOME/go" >> ~/.profile

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# github treats
# lol good luck, without a PAT, this shit BREAKS
# start with my stuff
git clone https://github.com/alexander-the-alright/bash
git clone https://github.com/alexander-the-alright/TDM
# elsewhere
git clone https://github.com/stianeikeland/go-rpio
git clone https://github.com/golemparts/rppal

# enable vim and bash settings
mv ~/bash/.bashrc ~/.bashrc
mv ~/bash/.vimrc ~/.vimrc
mv ~/bash/.vim ~/.vim

# build todo manager
go build TDM/tdm.go

# create static local ip address
sudo echo "" >> /etc/dhcpcd.conf
sudo echo "" >> /etc/dhcpcd.conf
sudo echo "interface wlan0" >> /etc/dhcpcd.conf
sudo echo "static ip_address=192.168.1.160/24" >> /etc/dhcpcd.conf
sudo echo "static routers=192.168.1.1" >> /etc/dhcpcd.conf
sudo echo "static domain_name_servers=192.168.1.1" >> /etc/dhcpcd.conf

# enable ssh?
sudo touch /boot/ssh

