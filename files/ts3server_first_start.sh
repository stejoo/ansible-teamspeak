#!/bin/bash

export LD_LIBRARY_PATH=".:$LD_LIBRARY_PATH"

D1=$(readlink -f "$0")
D2=$(dirname "${D1}")
cd "${D2}"

echo $D2

PARMS=`echo $@ | sed 's/:/=/g'`
./ts3server $@ &

TS3_PID=$!
sleep 2
kill $TS3_PID



