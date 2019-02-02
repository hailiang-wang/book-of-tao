#! /bin/bash 
###########################################
#
###########################################

# constants
baseDir=$(cd `dirname "$0"`;pwd)
# functions

# main 
[ -z "${BASH_SOURCE[0]}" -o "${BASH_SOURCE[0]}" = "$0" ] || return
cd /tmp
for x in `ps -ef|grep AdobeReader|awk '{ print $2 }'`; do
    ps -p $x 2>&1 >>/dev/null
    if [ $? == 0 ];then
        sudo kill -9 $x 2>&1 >>/dev/null ;
    fi
done

cd $baseDir/..
scripts/build.sh && open dist/main.pdf