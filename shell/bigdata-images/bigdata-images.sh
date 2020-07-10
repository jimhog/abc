#!/bin/bash
hversion=1594121906
nversion=1.3.4.9

#下载docker镜像到本地
#for i in `cat services.list`
#do

#    docker pull  reg.k8s.com/bigdata-prod/$i:$hversion

#done

#上传镜像到华为云镜像仓库

#登陆华为云镜像仓库
#docker login -u cn-east-2@4QGCEZXEZPXY1TNEPUTF -p 3a0cadfa9f5984a699690b7ebfc15f536c323c70062202eb843073381f3acb63 swr.cn-east-2.myhuaweicloud.com

#for i in `cat services.list`
#do
    #镜像tag
#    docker tag reg.k8s.com/bigdata-prod/$i:$hversion   swr.cn-east-2.myhuaweicloud.com/bigdata-prod/$i:$nversion
    #上传
#    docker push swr.cn-east-2.myhuaweicloud.com/bigdata-prod/$i:$nversion
#done

#docker镜像打包

for i in `cat services.list`
do
    #镜像tag
    docker tag reg.k8s.com/bigdata-prod/$i:$hversion   reg.ops.com/bigdata-prod/$i:$nversion
    #打包
    echo -------正在打包 $i -----------
    docker save reg.ops.com/bigdata-prod/$i:$nversion -o $i.tar 
done

