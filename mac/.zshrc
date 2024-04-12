# ==============================================================================
# Auth: dodd
# File: .zshrc
# Revn: 04-11-2024  1.0
# Func: Define user-made aliases and functions to make using the terminal easier
#
# TODO: make bt functions to check for connection before dc/connecting
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
# 04-11-2024:  removed constant ip call, because of ddns (thanks luke)
#              added o and p flags to ls alias
#              gutted remote ssh calls, replaced with ddns
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
alias ocelot="ssh ocelot@192.168.1.120"
alias sentinel="ssh -p 23 pi@192.168.1.169"
alias rocelot="ssh ocelot@kaer-morhen.kozow.com"
alias rocelot="ssh -p 23 pi@kaer-morhen.kozow.com"


### mac gcc is an alias for clang
### after downloading gcc, it's not in the global bin, it's local
alias gcc="/usr/local/bin/gcc-13"
alias g++="/usr/local/bin/g++-13"

### donut
alias donut="~/bin/donut"

### tdm
alias tdm="~/bin/tdm"
alias vim="vim +\"colo real_def\""

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

## Functions


autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

# zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
setopt PROMPT_SUBST
# %F{color}...%f colors the encompassed text /color/
# %m    -   shows the short machine name
# %1d  -    current working directory
PROMPT='%F{green}%m%f:%F{blue}%1~%f ⇌ '
#PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg0}%f$ '

