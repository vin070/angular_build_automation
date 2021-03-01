#!/bin/bash
programDir="${HOME}/program/ayrix/"
serverHostname="ubuntu"
serverAddress="ayrix.telemo.io"
serverUploadPath="/home/ubuntu/"
pemfilePath="${HOME}/Documents/api_server_gateway.pem"
function checkError(){
  if [[ $? != 0 ]]
   then
     echo 'ERROR'
     exit
   fi
}
cd $programDir
ng build --prod 
checkError
echo "---BUILD GENERATED---"
 rm dist.tar.xz 
checkError
echo "---PREVIOUS dist.tar.xz REMOVED--- "
tar -cJf dist.tar.xz dist  
checkError
echo "---dist.tar.xz file CREATED---"
cd 
scp -i  ${pemfilePath} ${programDir}dist.tar.xz  ${serverHostname}@${serverAddress}:${serverUploadPath}
checkError
echo "---dist.tar.xz uploaded to server---"
ssh -i  Documents/api_server_gateway.pem ubuntu@ayrix.telemo.io "bash -s" < ${HOME}/program/updateBuild.bash

