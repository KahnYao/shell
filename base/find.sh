#!/bin/bash

function fun(){
    cd $1
    for f in `ls $1`
    do
        if test -d $f
        then
	    echo $f
            fun $1"/"$f
        else
            echo "file:$f"
	    #t=`stat $f|Modify|awk -F"[-:. ]+" '{print $2$3$4}'`
	    t=`stat $f|awk -F"[-:. ]+" '/Change/{print $2$3$4}'`
	    #echo `expr $t + 1`
	    if [ $t -gt 20171226 ];then
		#echo $t
		echo $1"/"$f
		if [ ! -d /root/bak$1"/" ]; then
		    mkdir -p /root/bak$1"/"
		fi
		cp -r $1"/"$f /root/bak$1"/"
	    fi	
        fi
    done
    cd ../ 
}
echo "......Start......"
fun $1
echo "......End......"
