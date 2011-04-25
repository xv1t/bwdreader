#!/bin/sh

testing="yes"

BYSOFT_ROOT="/var/samba/shares/KB-Kanov/Lt_base/Bysoft6"

BWD_DEST="/var/samba/shares/320G/temp/bwddata"
JAR_PATH="/usr/local/lib/java/bwdreader.jar"

if [[ $testing == "yes" ]]; then
    BYSOFT_ROOT="/home/xvit/lservice/Bysoft6"
    BWD_DEST="$BYSOFT_ROOT/bwddata"    
fi

BWD_ROOT="$BYSOFT_ROOT/workroot"
ERROR_DIR="$BWD_DEST/error"

mkdir -p $BWD_DEST
mkdir -p $ERROR_DIR
rm -f $ERROR_DIR/*


cd $BWD_ROOT
NOT_FOUND=0
COUNTER="0"
#for bwd in `find 000044/*.BWD` `find 000045/*.BWD` `find 000046/*.BWD` `find 000047/*.BWD` ;
for bwd in `find 000058/ |grep BWD` ;
#for bwd in `find |grep BTW` ;
 do
 COUNTER=$[COUNTER+1]
 echo -n "$COUNTER.  "
    DIR=`dirname $bwd`
    mkdir -p $BWD_DEST/$DIR
    echo -n  "WORK: $bwd "
    
    if [[ ! -f "$BWD_DEST/$bwd.ini.OK"  ]]; then
	echo -n " SCAN... "
        java -jar $JAR_PATH $BWD_ROOT/$bwd > \
	    $BWD_DEST/$bwd.ini
	    
	    (
	    if [[ `grep "NOT_FOUND" $BWD_DEST/$bwd.ini` != "" ]]; then
    		echo -n " dumping... "
		
		#cp $BWD_DEST/$bwd.ini $ERROR_DIR/`basename $bwd`.dump
		java -jar $JAR_PATH $BWD_ROOT/$bwd -htmldump > $ERROR_DIR/`basename $bwd`.dump.html
		    
		    
		NOT_FOUND=$[$NOT_FOUND+1];
		errors=`ls $ERROR_DIR/ |wc -w`
		echo "  ERROR $errors FOUND"
		else
		    mv $BWD_DEST/$bwd.ini $BWD_DEST/$bwd.ini.OK
		    echo " OK"
	    fi
	    )
    else
	echo " OK"

    fi
	    
	    
done

echo "TOTAL: $COUNTER, errors=$errors"