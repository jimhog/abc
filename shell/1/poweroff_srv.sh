#!/bin/bash
s_list=/ddhome/control/1/server_list.txt
file2=/ddhome/control/1/file2
logger_name=$0
logger_lineno=$LINENO


#宿主机关机
for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do
     ansible $host -a "poweroff"
done

sleep 120

cat /dev/null  > $file2
for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do  ping -c 5 -i 0.1 $i >/dev/null 2>&1
    if  [ $? -eq 0 ]; then
       echo  $i 未关机 && echo $i >> $file2
    else
       echo  -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} $i 已关机
    fi
done

if test -z `cat $file2`; then
    exit 0
else
    for i in `cat $file2`
    do
        echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} 服务器 $i 未关机
    done
    exit 1
fi

#关停操作主机

#poweroff


