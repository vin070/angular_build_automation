#!/bin/bash
program_dir="Absolute project path directory"

server_details=("Server ip or domain name used in ssh config file" "Upload path on server" "Extract path on server");

function check_error(){
  if [[ $? != 0 ]]
   then
     echo "ERROR $1"
     exit
   fi
}

function upload_build(){
    build_flag=$1;
    server_domain_name=$2;
    upload_path=$3;
    update_path=$4;

    cd $program_dir
    ng build ${build_flag} 
    check_error "ng build ${build_flag}"
    echo "---BUILD GENERATED FOR ${server_domain_name}---"
    rm dist.tar.xz 
    echo "---PREVIOUS dist.tar.xz REMOVED SUBJECT TO AVAILABILITY--- "
    tar -cJf dist.tar.xz dist  
    check_error "tar -cJf dist.tar.xz dist"
    echo "---dist.tar.xz file CREATED---"
    cd 
    scp ${program_dir}/dist.tar.xz  ${server_domain_name}:${upload_path}
    check_error "scp ${program_dir}/dist.tar.xz  ${server_domain_name}:${upload_path}"
    echo "---dist.tar.xz uploaded to ${server_domain_name} at ${upload_path} path---"
    ssh ${server_domain_name} "bash -s" < ${program_dir}/updateBuild.bash ${update_path} ${upload_path}
}

upload_build "--prod" ${server_details[0]} ${server_details[1]} ${server_details[2]};

