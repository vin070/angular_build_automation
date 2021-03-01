#!/bin/bash
buildUploadPath='/var/www/html'
function checkError(){
  if [[ $? != 0 ]]
   then
     echo 'ERROR'
     exit
   fi 
} 
echo '---SSH done to server---'
tar -xJf dist.tar.xz --directory=${buildUploadPath}
echo "--- build extracted at ${buildUploadPath}---"
checkError
cd ${buildUploadPath}
checkError
sudo rm -rf  *.js *.svg *.png *.woff *.eot *.ttf *.png *.css  assets *.html *.ico *.txt
echo "---previous build removed from ${buildUploadPath} path---"
checkError
sudo cp -r dist/* .
echo "---new build copied at ${buildUploadPath} path---"
checkError
sudo rm -rf dist
checkError
echo "---extracted dist folder removed---"