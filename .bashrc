# Make for pretty colours
export TERM=xterm-256color

# Colors
## Reset
creset="\e[0m"       # Text Reset

## Regular Colors
black="\e[0;30m"        # Black
red="\e[0;31m"          # Red
green="\e[0;32m"        # Green
yellow="\e[0;33m"       # Yellow
blue="\e[0;34m"         # Blue
purple="\e[0;35m"       # Purple
cyan="\e[0;36m"         # Cyan
white="\e[0;37m"        # White


# User-settable variables
## Git prompt
GIT_PROMPT_PREFIX="$blue"
GIT_PROMPT="┅"
GIT_PROMPT_SUFFIX="$creset"

## Directory
GIT_DIR_PREFIX="$blue"
GIT_DIR_SUFFIX="$creset"

# Git-related tasks
prefix_git() {
   # Here we're checking if the dir is clean.
   [[ -n $( git status -s 2> /dev/null ) ]] && echo -e "$blue┅$creset" || echo -e "─"
}

dircol_git() {
   # Check the status of the dir. If it doesn't exist, we'll get an error.
   git status -s &> /dev/null

   # Assuming the last command (ie. checking status) wasn't an error (ie. it's a git dir), color output.
   [ $? -eq 0 ] && echo -e "$blue" || echo -e "$purple"
}

branch_git() {
   # Set the branchname; if it's not a git dir, redirect errors to null
   branchname=$( git rev-parse --abbrev-ref HEAD 2> /dev/null )
   # Print branchname assuming the last command worked.
   [ $? -eq 0 ] && echo "[$branchname]"
}

# Export it.
export PS1="\n┌\$(prefix_git) \e[38;05;208m\u@\h \$(dircol_git)\w$creset \e[38;05;66m\$(branch_git)\e[00m
└ \$ "

