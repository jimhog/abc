#!/bin/bash
s_list=/ddhome/control/1/server_list.txt
file3=/ddhome/control/1/file3
logger_name=$0
logger_lineno=$LINENO

#启动虛擬機
for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do
    for vm3 in `ansible $host -a 'virsh list --all' |awk 'NR>3{print $2}'`
    do
       ansible $host -a "virsh start $vm3"
       echo  -e " $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} 正在启动服务器 $host 上的虚拟机 $vm3" 
    done
done

sleep 30

cat /dev/null  > $file3
for i in `awk 'NR>9{print $2}' $s_list`
do  ping -c 5 -i 0.1 $i >/dev/null 2>&1
    if  [ $? -eq 0 ]; then
       echo  $i 已启动
    else
       echo  $i 未开启 && echo $i >> $file3
    fi
done

if test -z `cat $file3`; then
    exit 0
else
    for i in `cat $file3` 
    do 
        echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} 虚拟机 $i 未启动
    done
    exit 1
fi
