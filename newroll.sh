#!/bin/bash 

########################################
#                                      # 
#   ROLL.SH // Dice Roll Script.       #
#   --------------------------------   #
#   For DMs. Part of dm-tools suite.   #
#        by Benjamin M. Ford           #
#                                      #
#   + Jun 2013                         #
#                                      #
########################################

# Syntax: roll [options] {die modifier} {sides to die}  
#     eg: roll -v 3d20 

# How do we use this?
usage() {
	 # Embolden and underline this bit!
	 tput bold && tput smul
    echo -e "Example Usage"
	 # Reset the text
	 tput sgr0
	 echo -e "\t $0 [options] 3d20"
    echo
	 tput bold && tput smul
    echo -e "Options"
	 tput sgr0 
    echo -e "\t-v\tShow individual results when rolling multiples."
    echo -e "\t-h\tGet this help message."
}

# This function calculates our rolls.
roll() {
	# Starting a for loop that goes from 1 to however many dice are specified in the roll modifier
	for index in $(eval echo {1..$1})
 	do
 		# For each number of dice, generate a random number between 1 and the number of sides to the die, then add to an array.
 		ROLLS[$index]=$[ ( $RANDOM % $2 ) +1 ]
	done

	# Then, unpack the array.
	for rnum in "${ROLLS[@]}"
	do
		# We want to make our overall roll the sum of each of the rolls.
		let ROLL=$[ $ROLL + $rnum ]
	done

	# Print the first bit of the output.
	echo -ne "* $1d$2:"
	echo -ne " $( tput smul )$ROLL$( tput sgr0 )."

	# If the verbose flag was set and we're multirolling, show our working.
	[[ -n $verbose ]] && [[ $1 -gt 1 ]] && echo -ne " (${ROLLS[*]})"

	echo # Newline for prettiness.

}	

# Check if input is sane.
check() {
	# Is our input correctly formatted?
	if [[ $1 =~ ^[1-9][0-9]{0,2}d[1-9][0-9]{0,2}$|^d[1-9][0-9]{0,2} ]]; then
		# This is specified so we can roll d20 if we want a single roll.
		if [[ "${1:0:1}" -ne "d" ]]; then
			# Separate the first arg into 2 arguments either side of the 'd'.
			roll "${1%d*}" "${1##*d}"
		else
			# Since we don't have a roll modifier (nothing left of d), set it to 1 and roll.
			roll 1 "${1##*d}"
		fi
	else
		# If we get some weird unexpected input, RTFM and GTFO.
	   usage && exit 0
	fi
}

# Check for options
while getopts "hv" Option
do
   case $Option in
     "v" ) verbose=1 ;;
     "h" ) usage && exit 0 ;;
      ?  ) usage && exit 0 ;;
   esac
done

# Move options along so we can check for args
shift $(( OPTIND-1 ))

# As long as we have input, check the format.
if [ "$#" > 1 ]; then
	check "$1"
else
	usage && exit 0
fi

# That's all, folks.
