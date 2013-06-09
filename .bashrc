export TERM=xterm-256color

# When we're not in a git dir:

#╭─ [color=magenta]dir[/color]
#╰ $ echo blah


# When we're in a git dir without changes:

#╭─ [color=blue]dir[/color]
#╰ $ echo blah

# When we're in a git dir with changes:
# nb. the ┅ will be blue

#╭┅ [color=blue]dir[/color]
#╰ $ echo blah


export PS1="╭─ \u@\h \W
╰ \$ "
