#!/bin/bash

user_entries=$#
user_entry_array="${@}"

if [ $user_entries -eq 0 ]
	then
		echo "No argument given"
        exit 1
fi

for user_name in "${user_entry_array[@]}"; do
    echo "Username: $user_name"

	if [[ "$(grep -c "^$user_name" goodies.txt)" -gt 0 ]]
        then
            ./welcome.sh $user_name

    elif [[ "$(grep -c "^$user_name" baddies.txt)" -gt 0 ]]
        then
            ./goodbye.sh $user_name

    else
            ./unknown.sh $user_name

    fi
        
done

exit 0