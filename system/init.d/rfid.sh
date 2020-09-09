### BEGIN INIT INFO
# Provides:          rfid listener
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO

#! /bin/bash
# /etc/init.d/rfid

INPUT=/dev/input/event2
OUTPUT=/home/mtb/checkpoint/checkpoint.csv
RFID_PATH=/home/mtb/24hMTB_rfid
PID=0

start() {
    echo -n "Starting RFID listener: "
    chmod 777 $INPUT
    chmod 777 $OUTPUT
    cd $RFID_PATH && sudo -u mtb ruby rfid.rb $INPUT $OUTPUT &
    PID=$!
    echo $PID
}

stop() {
    echo -n "Stopping RFID listener: "
    kill -TERM $(cat $RFID_PATH/rfid.pid)
}

### main logic ###
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart|reload|condrestart)
        stop
        start
        ;;
    *)
        echo $"Usage: $0 {start|stop|restart|reload|status}"
        exit 1
esac
exit 0
