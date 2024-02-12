#!/bin/bash
IP='127.0.0.1'
PORT='25575'
COUNTDOWN_TIMER=$KILL_TIMER
COUNTDOWN_IN_MINUTES=$((COUNTDOWN_TIMER/60))

post_broadcast() {
    message=${1// /_}
    nohup rcon -H $IP -p $PORT -P $ADMIN_PASSWORD broadcast $message & > /dev/null 2>&1
}

term_handler() {
	kill -SIGTERM $(pidof PalServer-Linux-Test)
	tail --pid=$(pidof PalServer-Linux-Test) -f 2>/dev/null
	exit 143;
}

cd ${SERVER_DIR}

while true
do
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "$(date): Memory usage is at $MEMORY_USAGE%.." >> mem.log

    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
        
        post_broadcast "Getting close to memory threshold! Restarting in $COUNTDOWN_IN_MINUTES minutes."  
        while [ $COUNTDOWN_TIMER -gt 0 ]; do
            # Check for specific times and echo messages accordingly
            if [ $COUNTDOWN_TIMER -eq 600 ]; then
                post_broadcast "10 minutes remaining..."
            elif [ $COUNTDOWN_TIMER -eq 300 ]; then
                post_broadcast "5 minutes remaining..."
            elif [ $COUNTDOWN_TIMER -eq 60 ]; then
                post_broadcast "1 minute remaining..."
            elif [ $COUNTDOWN_TIMER -le 30 ]; then
                post_broadcast "$COUNTDOWN_TIMER seconds remaining..."
            fi
            ((COUNTDOWN_TIMER-=5))
            sleep 5
        done
        post_broadcast "!!!! NUKING SERVER !!!!"
        term_handler
    fi
    sleep 60
done