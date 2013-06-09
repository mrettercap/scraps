export TERM=xterm-256color

# Colors

# Reset
creset="\e[0m"       # Text Reset

# Regular Colors
black="\e[0;30m"        # Black
red="\e[0;31m"          # Red
green="\e[0;32m"        # Green
yellow="\e[0;33m"       # Yellow
blue="\e[0;34m"         # Blue
purple="\e[0;35m"       # Purple
cyan="\e[0;36m"         # Cyan
white="\e[0;37m"        # White

# Git-related tasks
prefix_git() {
   # Here we're checking if the dir is clean.
   [[ -n $( git status -s 2> /dev/null ) ]] && echo -e "$blue┅$creset" || echo -e "─"
}

dircol_git() {
   # Check the status of the dir. If it doesn't exist, we'll get an error.
   git status -s &> /dev/null
   [ $? -gt 0 ] && echo -e "$purple" || echo -e "$blue"
}


#╭─ [color=magenta]dir[/color]
#╰ $ echo blah


# When we're in a git dir without changes:

#╭─ [color=blue]dir[/color]
#╰ $ echo blah

# When we're in a git dir with changes:
# nb. the ┅ will be blue

#╭┅ [color=blue]dir[/color]
#╰ $ echo blah

export PS1="\n╭\$(prefix_git) \u@\h \$(dircol_git)\w$creset
╰ \$ "

