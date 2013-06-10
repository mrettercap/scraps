#!/bin/sh


UNDERLINE=$( tput smul )
BOLD=$( tput bold )
RESET=$( tput sgr0 )

heading() {
   echo "${UNDERLINE}${BOLD}$*${RESET}"
}

item() {
   echo -n "$1\t--\t$2\n"
}
#clear
#heading "File Commands"
#item "ls" "directory listing"
#item "ls -al" "formatted listing with hidden files"
#item "cd dir" "change directory to dir"
#echo

search() {
   local result="$( sqlite3 commands.db "select name from sqlite_master where type='table' and name LIKE '%${1}%';" )" 
   local cat="$( sqlite3 commands.db "select category from $result GROUP BY category;" )"

   sqlite3 commands.db "select category from $result GROUP BY category;" | while read category;
   do
      heading "$category"
      IFS="\|"
      sqlite3 commands.db "select command, action from $result WHERE category='$category';" | while read command action;
      do
         item "$command" "$action"
      done | column -ts "--"
      echo
  done 
set +x
exit 1
 
}

usage() {
   echo "WIP"
}

while getopts "hs:c:" Option
do
   case $Option in
      "s" ) search "$OPTARG" ;;
      "h" ) usage && exit 0 ;;
       ?  ) usage && exit 0 ;;
   esac
done

shift $(( OPTIND-1 ))
echo "Commands yo"
