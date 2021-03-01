#!/bin/bash
programDir="${HOME}/program/ayrix/"
serverHostname="<hostname of server>"
serverAddress="<domain name of server>"
serverUploadPath="<server uploade path >"
pemfilePath="pem file absolute path"
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
ssh -i  <relative or absolute pem file path> ubuntu@ayrix.telemo.io "bash -s" < ${HOME}/program/updateBuild.bash

