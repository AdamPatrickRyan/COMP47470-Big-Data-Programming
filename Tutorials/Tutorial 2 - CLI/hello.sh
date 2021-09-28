#!/bin/bash

user_entries=$#
user_entry_array=${@}

if [ $user_entries -gt 0 ]
	then
		for user_name in ${user_entry_array[@]}; do
			echo "Hello $user_name"
	done
else
	echo "Hello Sith Lord"
fi

exit