#!/bin/bash
STATUS=$1
DATE=$(date | cut -d ' ' -f2-4)
TIMESTAMP_KOMMT=$(date +%s)
TIMESTAMP_GEHT=$(date +%s)
TAGE_ARBEIT=$(grep HEUTE /home/bl/zeit | wc -l)
#SOLL=$(echo "$TAGE_ARBEIT * 510" | bc )
if [ $STATUS = "k" ]
then
  echo "kommt $TIMESTAMP_KOMMT $DATE"  >> /home/bl/zeit
fi

if [ $STATUS = "g" ]
then
echo "geht $TIMESTAMP_GEHT $DATE"  >> /home/bl/zeit
fi

if [ $STATUS = "g" ]
then
  HEUTE=$(tail -2 /home/bl/zeit | grep kommt | awk '{print $2}')
  TOTAL=$(echo "($TIMESTAMP_GEHT - $HEUTE) / 60" | bc)
  echo "TOTAL_HEUTE: $TOTAL Minuten" >> /home/bl/zeit
  echo "TOTAL_HEUTE: $TOTAL Minuten"
  TOTAL_GESAMT=$(grep HEUTE /home/bl/zeit |  awk '{s+=$2} END {print s}')
  echo "TOTAL_GESAMT: $TOTAL_GESAMT Minuten " >> /home/bl/zeit
  echo "TOTAL_GESAMT: $TOTAL_GESAMT Minuten" 
  echo "Tage gearbeitet: $((TAGE_ARBEIT + 1))" 
  foobar=$(($TAGE_ARBEIT + 1)) 
  SOLL=$(($foobar * 510)) 
  echo "SOLL: $SOLL"

  DIFFERENZ=$(($TOTAL_GESAMT - $SOLL)) 
  echo "DIFFERENZ= $DIFFERENZ"
fi
