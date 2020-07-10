#!/bin/bash
s_list=/ddhome/control/1/server_list.txt
file1=/ddhome/control/1/file1
logger_name=$0
logger_lineno=$LINENO


#關閉虛擬機
for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do
    for vm1 in `ansible $host -a 'virsh list' |awk 'NR>3{print $2}'`
    do 
       ansible $host -a "virsh shutdown $vm1"
       echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno}  "正在停止服务器 $host 上的虚拟机 $vm1" 
    done
done

sleep  180

#检查虛擬機状态,停止仍未关机的虚拟机
for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do
    for vm2 in `ansible $host -a 'virsh list' |awk 'NR>3{print $2}'`
    do 
       ansible $host -a "virsh destroy $vm2"
       echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno}  "强制停止 $host 上的虚拟机 $vm2"
    done
done

#确认虚拟机关机

for host in `awk 'NR>1&&NR<7 {print $2}' $s_list`
do
    cat /dev/null  > $file1
    ansible $host -a 'virsh list' |awk 'NR>3{print $2}'  >>  $file1
done

if  test -z `cat $file1`; then
         echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} "虚拟机已全部关机"
         exit 0
else
    for i in `cat $file1`
    do
        echo -e  $(date +%Y-%m-%d\ %H:%M:%S) $logger_name ${logger_lineno} 虚拟机 $i 未关闭
    done
         exit 1
fi 



