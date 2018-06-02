#!/bin/bash

#git remote
#git remote -v

#git status

#git diff

#git log

git add --all .

git commit -am "$1"

#git tag -a $2 -m "$1"
#git tag -d $2
#git tag
#git tag -l
#git tag -l "v_1.0*" #　显示指定模式的tag
#git tag -v tagname
#git rev-parse $2

#git clone url
#git clone url local_directory
#git checkout -b localname indexstring　＃取出指定版本为localname分支（如果不存在则创建）
#git checkout -b localname origin/name　＃取出指定分支为localname分支（如果不存在则创建）
#git checkout name ＃从本地仓库取出指定分支

#git branch -a #查看都有那些分支
#git branch -r #查看远程都有那些分支
#git branch #查看本地都有那些分支
#git branch name
#git branch -d name
#git checkout name

#git push
#git push origin
git push origin master
#git push origin tag $2 #提交指定tag
#git push origin --tags #提交所有tag
#git push origin :refs/tags/$2　＃删除tag
#git push origin master --force #强制本地上传

#git fetch
#git fetch origin
#git fetch origin master
#git fetch origin tag $2 #取指定tag
#git fetch --all

#git reset --hard origin/master #强制覆盖本地

#git pull #取最新版本,并合并到本地
#git pull origin #取最新版本,并合并到本地
#git pull origin master #取最新版本,并合并到本地
#git pull origin --tags #获取所有tags

#取代git pull的更好方法
#git fetch origin master
#git log -p master..origin/master
#git merge origin/master

#比上面的方法更清晰的方法
#git fetch origin master:tmp
#git diff tmp 
#git merge tmp
