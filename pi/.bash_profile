# ==============================================================================
# Auth: Alex Celani
# File: .bash_profile
# Revn: 03-06-2022  2.3
# Func: Define user-made aliases and functions to make using the terminal easier
#
# TODO: fix alias to cd
#       color files in ls, and color different file differently
#       pick a new color and prompt scheme
#       rename mkcd()
# ==============================================================================
# CHANGE LOG
# ------------------------------------------------------------------------------
# ??-??-2018:  init
# 05-31-2019:  added header comment block
# 06-01-2019:  fixed newcd, added alias of cc to newcd
#              commented functions
#              removed mkcd
#              made hide, ssy, and SSY aliases instead of functions
# 06-21-2019:  finally wrote Func field in header
# 03-25-2020:  copied from .bashrc
#              removed school-based functions to go to directories that do not
#                 exist on boofnet
# 05-11-2020:  added control structure to detect architecure and make decisions
#                 about directories for grad() and src()
# 09-29-2020:  wrote gitMake()
#              renamed newcd() to mkcd()
# 10-07-2020:  fixed src() and grad() not working on colossus by changing call
#                 to arch from "arch" to "$(arch)"
#              added call to src() at the beginning of the file
# 10-12-2020:  added -F to ll and l aliases
# 10-21-2020:  added alias to spotify to make it work globally to
#                 avoid setting PATH
#              added alias for neofetch
#              finally made PS1 work with PROMPT_COMMAND
#              made short function for showing short now playing
# 10-24-2020:  deleted .bashrc; call to static .bashrc on colossus
#                 will change source to .bash_profile
#              changed alias for spotify to sp
#              added parse_git_branch() to get branch name for PS1
#              changed grad() to work without probing the architecture
#              removed colors from PS1, got obnoxious
#              added mkcd() again
# 01-18-2021:  added alias for 'remake'
# 03-06-2022:  added alias for donut, and wordle executables
#
# ==============================================================================


# User specific aliases and functions
## Aliases

### Shows everything in detail, except . and ..
alias ll="ls -AFGhl"
alias  l="ls -AFGhl"

### Used for login
alias s="ssh sacelani@colossus.it.mtu.edu"

### Move to desktop fast
alias desk="cd ~/Desktop"

### Move to desktop fast, verbose
alias DESK="CD ~/Desktop"

### Go home
alias home="cd ~"

### Go home, verbose
alias HOME="CD ~"

### Control Spotify with command line
alias sp="~/spotify"

### neofetch
alias neofetch="~/neofetch"

### donut
alias donut="~/donut"

### wordle
alias wordle="~/wordle"
alias worlde="~/wordle"

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
export PROMPT_COMMAND="export PS1='\W -> '"
#export LSCOLORS=exfxcxdxbxegabagacad

## Functions

### LaTeX make function
tecc() {
    pdflatex $1 >> /dev/null    # compile tex file, output dies
    rm $1.log                   # get rid of trash files
    rm $1.aux
}

### Print name of git branch
parse_git_branch() {
    # call git branch to return list of all branches
    # redirect output from 2 (error) to null
    # pipe standard output to grep, get line with *
    # pipe THAT to function that removes the leading space and *
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}

### Print Now Playing, short
playing() {
    echo -n $(~/spotify status artist)  # Print the artist, no newline
    echo -n " - "                       # Print delimiter
    echo    $(~/spotify status track)   # Print track, with newline
}

### Change branch name on Github to daddy
daddy() {
    if [ "$#" -eq 1 ]; then
        git branch -m master $1
        git push -u origin $1
    else
        git branch -m master daddy
        git push -u origin daddy
    fi

    echo "Log in to GitHub and change the default branch"
    echo "Then call 'daddy2'"

}

daddy2() {
    git push origin --delete master
    git remote set-head origin -a
}

### Detect architecture and load correct source file
src() {
   if [ arch == "x86_64" ]; then    # Check to see if using colossus
      source ~/.bashrc              # Reload colossus bash profile
   else                             # If not colossus, boofnet
      source ~/.bash_profile        # Reload boofnet bash profile
   fi
}


### Change directory and show contents
CD() {
   cd $1    # Move
   clear    # Clear screen
   ll       # Print directory
}

### If cd fails, make the new directory and cd in
mkcd() {
   oldD=$(pwd)                   # Snag the current directory
   cd $1 >/dev/null 2>/dev/null  # cd, direct error output to null
   newD=$(pwd)                   # Snag current directory again

   if [ $oldD == $newD ]; then   # If new is same as old, didn't move
      mkdir $1                   # Make the new directory
      cd $1                      # cd in
   fi
}

### Jump to grad school directory, user specified semester if possible
grad() {
    old=$(pwd);
    cd ~/Desktop/grad 2>/dev/null
    if [ $old == $(pwd) ]; then
        cd ~/Documents/everything 2>/dev/null
    fi
#    if [ arch == "x86_64" ]; then    # Check to see using colossus
#      cd ~/Desktop/grad/            # Jump to grad directory, colossus
#   else                             # If not colossus, boofnet
#      cd ~/Documents/everything     # Jump to grad directory, boofnet
#   fi

   if [ "$#" -eq 1 ]; then          # See if user entered a semester argument
      cd "semester-$1" 2>/dev/null  # Go to semester, error silently
   fi
}

### Take new repository and connect it to a Github repository
gitMake() {
    if [ "$#" -eq 1 ]; then
        # These three lines were given by github.com
        git remote add origin https://github.com/sacelani/$1.git
        git branch -M master
        git push -u origin master
    else                # If the user doesn't give a name for the repo
        echo -e "Usage:: gitMake REPO"          # Print usage
        echo -e "\tConnect local repo REPO to Github repo"
    fi
}

## Functions

. "$HOME/.cargo/env"
