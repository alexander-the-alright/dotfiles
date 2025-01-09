# ==============================================================================
# Auth: dodd
# File: .bashrc
# Revn: 01-04-2025  1.0
# Func: Define user-made aliases and functions to make using the terminal easier
#
# TODO: break down PS1 stuff
#       color files in ls, and color different file differently
#       pick a new color and prompt scheme
# ==============================================================================
# CHANGE LOG
# ------------------------------------------------------------------------------
# 07-12-2023: init
#             cleaned it up a little
# 08-24-2023: updated some PS1 stuff, added documentation
# 08-30-2023: added link to color resource
# 05-16-2024: updated exe name for ekho, changed call
# 06-07-2024: added "if not running interactively" line to make scp
#               work
# 06-09-2024: updated ekho exe to ekho-cli-sen
#*01-04-2025: added vim -p alias
#
# ==============================================================================

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# User specific aliases and functions
## Aliases

### Shows everything in detail, except . and ..
alias ll="ls -AFGhl"
alias  l="ls -AFGhl"
alias lr="ls -AFGhlR"

### Go home
alias home="cd ~"

### TDM stuff
alias todo="~/bin/todo"
alias mark="~/bin/todo mark"
alias delete="~/bin/todo delete"
alias show="~/bin/todo show"

### MOTD stuff
alias ekho="~/bin/ekho-cli-sen"

### vim default to tabs
alias vim="vim -p"

## Aliases

## Exports

# Holy shit, export PS1 kept failing, so I had to make it reload every
# time a command is run. Hacky and probably really slow, but it works
# PROMPT_COMMAND is a command run before it prints the prompt
# export PS1 is the command prompt, won't run in this file, only runs
#   in actual terminal, or here apparently
# \e[0;31m is red
# \W is the current folder
# \e[0;34m is blue
# ' -> ' is a space and then an arrow, and then a space
# \e0;31m is red again
# \e[m is no color
#export PROMPT_COMMAND="export PS1='\[\e[0;32m\]\W\[\e[1;31m\] -> \[\e[0;32m\]'"
#export PROMPT_COMMAND="export PS1='\e[0;31m$(parse_git_branch) \e[m\W -> '"
#export PROMPT_COMMAND="export PS1='\W -> '"
#export LSCOLORS=exfxcxdxbxegabagacad
export PATH=$PATH:/usr/local/go/bin

. "$HOME/.cargo/env"



# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#TODO come back and break each of these down
if [ "$color_prompt" = yes ]; then
    # PS1 documentation
    # https://misc.flogisoft.com/bash/tip_colors_and_formatting

    # color resource - https://misc.flogisoft.com/bash/tip_colors_and_formatting
    e="\e"          # escape character
    # background types
    rst="[0m"
    bold="[1m"
    ul="[4m"
    blink="[5m"
    # colors
    red="[31m"
    green="[32m"
    yellow="[33m"
    blue="[34m"
    magenta="[35m"
    cyan="[36m"
    lred="[91m"
    lgreen="[92m"
    lblue="[94m"
    lmag="[95m"
    lcyan="[96m"
    white="[97m"
    # background colors
    bred="[40m"
    bgreen="[42m"
    bblue="[44m"

    # use different PS1 for each user, while maintaining one bashfile
    if [ "${USER}" = "venom" ]; then
        # venom gets diamond dogs
        #PS1='\[\033[01;34m\]DIAMOND DOGS\[\033[00m\]:\[\033[01;32m\]\W\[\033[00m\] ♢  '
        PS1="$e$blue""DIAMOND"" "DOGS"$e$rst":"$e$green""\W""$e$rst ♢  "
        # kaz might get it too
    elif [ "${USER}" = "ocelot" ]; then
        # pi/ocelot gets OUTER-HEAVEN
        # this makes some sense for ocelot, but itd make more sense
        # for venom or kaz. But still
        # or something
        #PS1='\[\033[01;32m\]\h\[\033[00m\]/\[\033[01;37m\]\[\033[07;37m\]XOF\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] ⇌  '
        PS1="$e$bold$e$green""\h""$e$rst"::"$e$blue""\W""$e$rst ⇌ "
    else 
        # use the standard prompt if we don't know the user
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# run quick and dirty program to flash an LED
~/bin/boot

# call motd
#~/bin/ekho-cli-sen
~/bin/client.o
