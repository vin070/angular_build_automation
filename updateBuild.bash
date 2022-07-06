#!/bin/bash
build_update_path=$1;
build_upload_path=$2; 
function check_error(){
  if [[ $? != 0 ]]
   then
     echo 'ERROR'
     exit
   fi 
}
echo '---SSH done to server---'
cd ${build_upload_path}
tar -xJf dist.tar.xz --directory=.
echo "---build extracted at ${build_upload_path} directory"
check_error
cd ${build_update_path}
check_error
sudo rm -rf  *.js *.svg *.png *.woff *.eot *.ttf *.png *.css  assets *.html *.ico *.txt
echo "---previous build removed from ${build_update_path} path SUBJECT TO AVAILABILITY---"
check_error
sudo cp -r ${build_upload_path}/dist/* ${build_update_path}/
echo "---new build copied at ${build_update_path} path---"
check_error
cd ${build_upload_path}
sudo rm -rf dist dist.tar.xz
check_error
echo "---uploaded and extracted dist folder removed---"
