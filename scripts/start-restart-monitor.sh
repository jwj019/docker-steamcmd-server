#!/bin/bash
$PID=$1
IP='127.0.0.1:25575'
COUNTDOWN_TIMER=$KILL_TIMER
COUNTDOWN_IN_MINUTES=$((COUNTDOWN_TIMER/60))

post_broadcast() {
    message=${1// /_}
    broadcast $message | rcon -a $IP -p $ADMIN_PASSWORD
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
                echo "10 minutes remaining..."
            elif [ $COUNTDOWN_TIMER -eq 300 ]; then
                echo "5 minutes remaining..."
            elif [ $COUNTDOWN_TIMER -eq 60 ]; then
                echo "1 minute remaining..."
            elif [ $COUNTDOWN_TIMER -le 30 ]; then
                echo "$COUNTDOWN_TIMER seconds remaining..."
            fi
            ((COUNTDOWN_TIMER-=5))
            sleep 5
        done
        kill $PID
    fi
    sleep 60
done