#!/bin/bash
关停大数据平台微服务
for srv in `ls /ddhome/k8s/yml |grep huayun` 
do
   kubectl delete -f $srv
done


#启动大数据平台微服务
for lab in `ls /ddhome/k8s/yml |grep huayun-lab`
do
    kubectl apply -f huayun-common-eureka.yml
    sleep  60
    kubectl apply -f huayun-common-config.yml
    sleep  60
    kubectl apply -f huayun-common-zuul.yml
    sleep  30
    kubectl apply -f huayun-lab-redis.yml
    sleep  30
    kubectl apply -f huayun-lab-auth.yml
    sleep  30
    kubectl apply -f $lab
done
