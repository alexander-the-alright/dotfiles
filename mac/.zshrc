# ==============================================================================
# Auth: dodd
# File: .zshrc
# Revn: 01-02-2025  2.0
# Func: Define user-made aliases and functions to make using the terminal easier
#
# TODO: make bt functions to check for connection before dc/connecting
#       research git command stuff
# ==============================================================================
# CHANGE LOG
# ------------------------------------------------------------------------------
# 09-06-2023:  init
#              copied over useful aliases from ocelot
#              wrote function to ssh into ocelot remotely, ip robust
# 09-09-2023:  added aliases to gcc and g++
# 09-10-2023:  added moved tdm and donut to ~/bin/, changed alias accordingly
# 09-15-2023:  made ocelot and sentinel try local ssh before using $ip
# 09-18-2023:  added vim alias to correct vim loading shitty colors
# 12-28-2023:  added blueutil aliases to connect/dc from M50x's
# 01-18-2024:  converted btutil aliases into functions
#              added power on/off to btfunctions
#*04-11-2024:  removed constant ip call, because of ddns (thanks luke)
#              added o and p flags to ls alias
#              gutted remote ssh calls, replaced with ddns
# 05-11-2024:  added git branch recognition of some sort
# 05-16-2024:  updated pi static IP's ( fuck speccy )
#              fixed accidental yank and place of "-p 23" in sentinel
# 06-07-2024:  updated pi public IP's ( fuck speccy again )
#              fixed accidental renaming ofrsentinel as rocelot
# 10-22-2024:  updated prompt, moving git branch to beginning
#               placed branch inside double brackets, [[ ]] ( vcs_git )
# 12-20-2024:  added -p flag to vim alias
#*01-02-2025:  wrote and commented oops()
#
# ==============================================================================


# User specific aliases and functions
## Aliases

### Shows everything in detail, except . and ..
# A - list ALL ( except for . and .. )
# F - put symbols behind items in list
# G - force color
# h - human readable file sizes
# l - long, list long
# o - list long, omit group 
alias ll="ls -AFGhlo"
alias  l="ls -AFGhlo"

### Go home
alias home="cd ~"

### local ssh
alias ocelot="ssh ocelot@192.168.1.152"
alias sentinel="ssh pi@192.168.1.139"
alias rocelot="ssh ocelot@97.70.74.80"
alias rsentinel="ssh -p 23 pi@97.70.74.80"


### mac gcc is an alias for clang
### after downloading gcc, it's not in the global bin, it's local
alias gcc="/usr/local/bin/gcc-13"
alias g++="/usr/local/bin/g++-13"

### donut
alias donut="~/bin/donut"

### tdm
alias tdm="~/bin/tdm"

### vim
alias vim="vim +\"colo real_def\" -p"

### load changes to .zshrc
alias src="source ~/.zshrc"

## Aliases


## Functions
### turn on bluetooth and connect to m50x-bt
### TODO make more robust? how does btutil react when bt is on
### btutil -p 1 is run?
bt() {
    blueutil -p 1
    blueutil --connect 00-0a-45-19-a0-4e    
}


### turn off bluetooth and dc from m50x-bt
btdc() {
    blueutil --disconnect 00-0a-45-19-a0-4e    
    blueutil -p 0
}


### correct mistaken commands
oops() {
    # not exactly sure this works on zsh
    # but in *bash*
    # $1 is the argument given to the function
    # and $_ is the arguments from the previous command
    # so the idea is that if you do like 
    # ls ~/.vim/syntax/commentS.txt
    # and you wanna do vim ~/.vim/syntax/commentS.txt
    # but don't wanna type it all out again
    # you do can just do 
    # ls ~/.vim/syntax/commentS.txt
    # oops vim
    # and it works
    $1 $_
    # TODO improve with bangs, so the correct command is stored in
    # history
}

## Functions


autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%F{white}<<%f%F{red}[[%b]]%f'

# zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
setopt PROMPT_SUBST
# %F{color}...%f colors the encompassed text /color/
# %m    -   shows the short machine name
# %1d  -    current working directory
PROMPT='%F{green}%m%f%B%F{red}${vcs_info_msg_0_}%b%f::%F{blue}%1~%f ⇌ '
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg0}%f$ '

