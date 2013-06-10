# Make for pretty colours
export TERM=xterm-256color

# Colors
FIRST=$( tput setaf 67 )
SECOND=$( tput setaf 153 )
THIRD=$( tput setaf 248 )
FOURTH=$( tput setaf 45 )
FIFTH=$( tput setaf 39 )
SIXTH=$( tput setaf 227 ) 
RESET=$( tput sgr0 ) 

GIT=0

declare global branchname

# Check git
chkgit() {
   branchname=$( git rev-parse --abbrev-ref HEAD 2> /dev/null )
   [ $? -eq 0 ] && GIT=1 || GIT=0
}

# Git-related tasks
prefix_git() {
   # Here we're checking if the dir is clean.
   [[ -n $( git remote update 2> /dev/null | git status -suno 2> /dev/null | grep 'behind' ) ]] && echo "⇂" && return 
   [[ -n $( git status -s 2> /dev/null ) ]] && echo -e "↾ " || echo "↝ "
}

# Export it.
PROMPT_COMMAND='chkgit'
export PS1='\[$FIRST\]$( date +%H:%M )\[$RESET\] \[$SECOND\]\u\[$RESET\]\[$THIRD\]@\[$RESET\]\[$SECOND\]\h\[$RESET\] \[$FOURTH\]\W\[$RESET\] $( [ $GIT -eq 1 ] && echo "\[$SECOND\][\[$SIXTH\]$branchname\[$SECOND\]]\[$RESET\]" )\[$SIXTH\]$(prefix_git)\[$RESET\] '

