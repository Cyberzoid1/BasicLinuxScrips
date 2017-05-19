#!/bin/bash

NOW=`date "+%Y-%m-%d_%Hh%M"`
#COMMAND=openhabExecuteTest
COMMAND=MCstartscript_3301 #the script called on the host server

mc_start() {
	echo "starting $NOW" #>> MCRemote.log
	echo `ssh minecraft@192.168.2.210 ./$COMMAND start` #>> MCRemote.log
}

mc_stop() {
	echo "stopping $NOW" #>> MCRemote.log
	#echo `sshpass -p MCfriends ssh minecraft@192.168.2.210 ./$COMMAND stop $NOW`
	echo `ssh minecraft@192.168.2.210 ./$COMMAND stop` #>> MCRemote.log
}
mc_status() {
	echo "starting $NOW" #>> MCRemote.log
	echo `ssh minecraft@192.168.2.210 ./$COMMAND status` #>> MCRemote.log
}
mc_list() {
	echo "starting $NOW" #>> MCRemote.log
	echo `ssh minecraft@192.168.2.210 ./$COMMAND command "/list"` #>> MCRemote.log
}



#Start-Stop here
case "$1" in
  start)
    mc_start
    ;;
  stop)
    mc_stop
    ;;
  restart)
    mc_stop
    mc_start
    ;;
  status)
	mc_status
    ;;
  list)
	mc_list
	;;
  *)
  echo "Usage: $0 {start|stop|status|restart}"
  exit 1
  ;;
esac

exit 0