#!/bin/bash

#This little shell script will sync code from A repo, then push a new branch/patch to B repo

# =======Flow======
#1.Check all the projects' name and its path by command "repo list"
#2.And also get to the project's path to check its branch name and copy a new branch name with "_sync" in the tail.
#3.add the remote which you want to push the patches in
#4.repo start a new branch and git push

main_path=/home/leon/src
rtk_path=/home/leon/src/mac6p_outside
origin_path=/home/leon/src/mac6p_P
project_num=56
new_branch_name=$(date +%D)

#PROJECT_PATH=()
#PROJECT_NAME=()
#PROJECT_BRANCH=()

cd $rtk_path
repo sync

for ((i=1; i<= $project_num ; i++))
do
    path_tmp=$(repo list | sed -n "$i p" | awk -F':' '{print $1}')
    project_tmp=$(repo list | sed -n "$i p" | awk -F': ' '{print $2}')
    cd $path_tmp
    branch_tmp=$(git branch -a | sed -n 2p | awk -F'rtk/' '{print $2}')_sync
    echo $path_tmp
    #PROJECT_PATH+=("$path_tmp")
    #PROJECT_NAME+=("$project_tmp")
    #PROJECT_BRANCH+=("$branch_tmp")

    #git remote add rtk-pi ssh://172.22.54.219:29418/$project_tmp
    #repo start $branch_tmp

    git push rtk-pi $branch_tmp
    cd $rtk_path
done


#cd $origin_path


#length=${#PROJECT_PATH[@]}
#for ((i=0; i < $length; i++))
#do
    #echo checkout to ${PROJECT_PATH[$i]} and branch ${PROJECT_BRANCH[$i]}
#    cd ${PROJECT_PATH[$i]}
    #repo start $new_branch_name
    #git pull ssh://leon5209@code.realtek.com.tw:20001/${PROJECT_NAME[$i]}
#    cd $origin_path
#done
cd $main_path
