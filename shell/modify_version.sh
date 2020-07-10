#!/bin/bash
for i in `ls /ddhome/k8s/ |grep huayun-lab` 
do
   sed -i s/v1.3.4.6/v1.3.4.8/  $i
done
       
