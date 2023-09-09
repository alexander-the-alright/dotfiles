# ==============================================================================
# Auth: dodd
# File: .zshrc
# Revn: 09-06-2023  0.1
# Func: Define user-made aliases and functions to make using the terminal easier
#
# TODO: come up with new things to change
# ==============================================================================
# CHANGE LOG
# ------------------------------------------------------------------------------
# 09-06-2023:  init
#              copied over useful aliases from ocelot
#              wrote function to ssh into ocelot remotely, ip robust
# 09-09-2023:  added aliases to gcc and g++
#
# ==============================================================================


# User specific aliases and functions
## Aliases

### Shows everything in detail, except . and ..
alias ll="ls -AFGhl"
alias  l="ls -AFGhl"

### Go home
alias home="cd ~"

### mac gcc is an alias for clang
### after downloading gcc, it's not in the global bin, it's local
alias gcc="/usr/local/bin/gcc-13"
alias g++="/usr/local/bin/g++-13"

### donut
alias donut="~/donut"

### load changes to .zshrc
alias src="source ~/.zshrc"

### ssh into ocelot
alias ocelot="ssh ocelot@192.168.1.120"

### ssh into sentinel
alias sentinel="ssh pi@192.168.1.169"

## Aliases

## Functions
### ssh into ocelot remotely
rocelot() {
    # grab ip from ip repo
    ip=$( cat ~/Documents/work/tax-returns-1997/data )
    # ssh into ip from repo
    ssh ocelot@$ip
}

### ssh into ocelot remotely
rsentinel() {
    # grab ip from ip repo
    ip=$( cat ~/Documents/work/tax-returns-1997/data )
    # ssh into ip from repo
    # specify port 23, according to router settings, ssh port was
    # moved from 22 to 23, to avoid collision with ocelot
    ssh -p 23 pi@$ip
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

