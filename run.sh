first_token=1
old_txt=""

while true;do
	#clear #not needed yet
	value=$(</proc/net/tcpstat)
	if [ $first_token == 1 ]; then
                DATE=`date '+%Y-%m-%d %H:%M:%S'`
                figlet -f digital -w 1000 "                                     STARTED AT : [$DATE]"
		first_token=0
		old_txt=$value
		echo "$old_txt"
		figlet -f digital -w 1000 "                                               Waiting For new  Change"
	else
		if [[ $value != $old_txt ]]; then
                        DATE=`date '+%Y-%m-%d %H:%M:%S'`
                        figlet -f digital -w 1000 "                             FOUND NEW CHANGED AT [$DATE]"
			echo "$value"
			old_txt=$value
			figlet -f digital -w 1000 "                                               Waiting For new  Change"
		fi
	fi
	sleep 2
done
