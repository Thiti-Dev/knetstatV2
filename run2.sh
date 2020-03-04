variable=$(lsmod | grep knetstat)
#echo "$variable"
if [[ $variable == "" ]]; then
	echo "you didn't load the module to the kernel module yet"
	printf "want to load now ? [ y or n ] :"
	read -r choice
	if [[ $choice == "y" ]]; then
		clear
		#echo "loading module"
		echo "want to specific state option?"
		echo "1: TCP_LISTEN"
		echo "2: TCP_ESTABLISHED"
		echo "3: TCP_TIME_WAIT"
		echo "4: TCP_FIN_WAIT1"
		echo "5: TCP_FIN_WAIT2"
		echo "6: TCP_SYN_SENT"
		echo "7: TCP_SYN_RECV"
		echo "8: TCP_NEW_SYN_RECV"
		echo "9: TCP_CLOSE"
		echo "10: TCP_CLOSE_WAIT"
		echo "11: TCP_CLOSING"
		echo "12: TCP_LAST_ACK"
		echo "0: for inspect all states"
		read options
		printf "want to specific the port? [ ENTER PORT NUMBER | OR BLANK TO IGNORE ] : "
		read -r port

		echo "LOADING MODULE . . ."
		if [ "$port" == "" ]; then
			if [ $options -ge 0 ] && [ $options -le 12 ]; then
				insmod knetstat.ko inspectOnly=$options
			fi
		else
                        if [ $options -ge 0 ] && [ $options -le 12 ]; then
                                insmod knetstat.ko inspectOnly=$options portOnly=$port
                        fi
		fi
		#echo "- - MODULE LOADED - -"
		check=$(lsmod | grep knetstat)
		while [[ $check == "" ]]; do
			sleep 1
		done
		echo "- - MODULE LOADED - -"
		echo "- - Start performing exclusive task to check for update - -"
		bash run.sh
	fi
else
	echo " -- MODULE ALREADY LOADED -- "
	printf "Want to unload? or perform exclusive task ? [ (0) for unload , (1) for task update ] : "
	read -r existChoice
	if [ $existChoice == 0 ]; then
		rmmod knetstat
	elif [ $existChoice == 1 ]; then
		bash run.sh
	fi
	echo "Module unloaded"
fi

