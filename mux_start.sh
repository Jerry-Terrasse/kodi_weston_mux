#!/bin/bash

KODI="kodi-standalone --windowing=gbm"
WESTON="weston"

cur_app=0 # 0: kodi, 1: weston

kill_both() {
    echo "killing both"
    pkill kodi.bin
    echo $?
    pkill weston
    echo $?
}

check_alive() {
    if pgrep -x "kodi.bin" > /dev/null; then
        echo "kodi is running"
        return 1
    elif pgrep -x "weston" > /dev/null; then
        echo "weston is running"
        return 2
    else
        echo "No app is running"
        return 0
    fi
}

handle_usr1() {
    echo "Received USR1"
    cur_app=0
    kill_both
}

handle_usr2() {
    echo "Received USR2"
    cur_app=1
    kill_both
}

handle_term() {
    echo "Received TERM"
    kill_both
    sleep 1
    exit 0
}

trap handle_usr1 USR1 # Switch to kodi
trap handle_usr2 USR2 # Switch to weston
trap handle_term TERM # Exit

while true; do
    if [ $cur_app -eq 0 ]; then
        $KODI &
        sleep 5
    else
        $WESTON &
        sleep 5
    fi
    while true; do
        if check_alive; then
            echo "No app is running"
            break
        fi
        echo "Running"
        sleep 1
    done
done
