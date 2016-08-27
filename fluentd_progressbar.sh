#!/bin/bash

if [[ -z ${1+x} || -z ${2+x} ]]; then
    echo "Usage: $0 file.log file.pos";
    exit;
fi

if [[ -f $1 ]]; then
    LOGFILE=$1;
else
    echo "Log file \"$1\" does not exist.";
    echo "Usage: $0 file.log file.pos";
    exit;
fi

if [[ -f $2 ]]; then
    POSFILE=$2;
else
    echo "Position file \"$2\" does not exist.";
    echo "Usage: $0 file.log file.pos";
    exit;
fi

BARWIDTH="50"

TOTAL=$(ls -l $LOGFILE | awk {'print(strtonum($5))'});
PREVCUR=$(cat $POSFILE | awk {'print((strtonum("0x"$2)))'});
COUNTER="0"


while [[ true ]]; do
    CUR=$(cat $POSFILE | awk {'print((strtonum("0x"$2)))'});
    PROGRESS=$(($CUR/$TOTAL));
    PROGRESSBARCOUNT=$(($CUR*$BARWIDTH/$TOTAL));
    PROGRESSFLOAT=$(echo "scale=2;"$CUR*100/$TOTAL | bc);
    
    PROGRESSBAR=" [";
    for (( i = 0; i < $PROGRESSBARCOUNT; i++ )); do
        PROGRESSBAR=$PROGRESSBAR#;
    done

    for (( i = $PROGRESSBARCOUNT; i < $BARWIDTH; i++ )); do
        PROGRESSBAR=$PROGRESSBAR"_";
    done
    PROGRESSBAR=$PROGRESSBAR"] ";

    if [[ $PROGRESS -ge "1" ]]; then
        break;
    else
        if [[ $COUNTER == 79 ]]; then
            if [[ $(($CUR-$PREVCUR)) -ne 0 ]]; then
                ETATIME=$((($TOTAL-$CUR)/(($CUR-$PREVCUR)/8)));
                ETA=$(date -u -d @$ETATIME +"%T");
                COUNTER="0";
                PREVCUR=$CUR;
            else
                ETA=" inf";
            fi
        else
            COUNTER=$(($COUNTER+1));
        fi
        echo -ne "Progress: "$PROGRESSBAR$PROGRESSFLOAT"% ETA: "$ETA"   \r";
        sleep 0.1s;
    fi
done

echo "Done!"
