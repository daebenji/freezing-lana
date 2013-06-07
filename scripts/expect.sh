#!/bin/bash

SCRIPT=/usr/local/bin/fan-monitoring/fan.sh
EXPECT=$(which expect)

while getopts h: OPTNAME; do
        case "$OPTNAME" in
        h)
                HOSTNAME="$OPTARG"
                ;;
        esac
done

if [ ! -x "$EXPECT" ]
then
        echo "EXPECT nicht gefunden: '$EXPECT'"
        exit 3
fi

if [ ! -x "$SCRIPT" ]
then
        echo "Script nicht gefunden oder nicht ausfuehbar: '$SCRIPT'"
        exit 3
fi

$EXPECT $SCRIPT $HOSTNAME > /tmp/$HOSTNAME

if grep --quiet -i "error" /tmp/$HOSTNAME 
then
	echo Fehler: $(cat /tmp/$HOSTNAME| grep -i "error")
	exit 2
else 
	echo "OK - keine Fehler"
	exit 0
fi


