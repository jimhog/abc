#!/bin/bash
oldversion=
newversion=v1.3.4.8
#for i in `ls /ddhome/tools/1 |grep huayun |awk -F_ '{print $1}'`
#     do  
#        cd $i\_docker
#        #修改Dockerfile中基础镜像
#        sed -i s/jre8-alpine:latest/jre8-alpine-arm64:latest/ Dockerfile
#        #构建docker镜像
#        docker build  -f Dockerfile  -t reg.ops.com/bigdata-arm/$i:$new_version . 
#        #上传镜像到镜像仓库
#        docker push reg.ops.com/bigdata-arm/$i:$new_version
#        cd ..
#done

for i in `ls /ddhome/tools/1 |grep huayun |awk -F_ '{print $1}'`
     do
        #tag华为云docker镜像
        docker tag reg.ops.com/bigdata-arm/$i:$newversion  swr.cn-east-2.myhuaweicloud.com/bigdata-prod-arm/$i:$newversion
        #上传镜像到华为云镜像仓库
        docker push swr.cn-east-2.myhuaweicloud.com/bigdata-prod-arm/$i:$newversion
done

