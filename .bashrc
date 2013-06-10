# Make for pretty colours
export TERM=xterm-256color

# Colors
FIRST="$( tput setaf 67 )"
SECOND="$( tput setaf 153 )"
THIRD="$( tput setaf 248 )"
FOURTH="$( tput setaf 45 )"
FIFTH="$( tput setaf 39 )"
SIXTH="$( tput setaf 227 )"
RESET="$( tput sgr0 )"

declare global branchname

# Git-related tasks
prefix_git() {
   # Here we're checking if the dir is clean.
   [[ -n $( git remote update 2> /dev/null | git status -suno 2> /dev/null | grep 'behind' ) ]] && echo "⇂" && return 
   [[ -n $( git status -s 2> /dev/null ) ]] && echo -e "↾ " || echo "↝ "
}

branch_git() {
   # Set the branchname; if it's not a git dir, redirect errors to null
   branchname=$( git rev-parse --abbrev-ref HEAD 2> /dev/null )
   # Print branchname assuming the last command worked.
   [ $? -eq 0 ] && echo "${SECOND}[${SIXTH}${branchname}${SECOND}]" || echo " "
}

#tput setaf 41; echo -n "$( date +%H:%M )"; tput setaf 0; tput setaf 39; echo -n " $USER"; tput setaf 248; echo -n "@"; tput setaf 85; echo -n "$HOSTNAME"; tput setaf 39; echo -n " ${PWD##*/}"; tput setaf 208; echo -n " $"; echo

# Export it.
export PS1='\[$FIRST\]\[$( date +%H:%M )\] \[$SECOND\]\u\[$FIRST\]@\[$SECOND\]\h \[$FIFTH\]\W\[$( branch_git )\]\[$RESET\]\[$SIXTH\]\[$(prefix_git)\]\[$RESET\] '

