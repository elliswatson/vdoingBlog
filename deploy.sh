#!/usr/bin/env sh

git pull -r

# 确保脚本抛出遇到的错误
if [  $(git branch -r | grep origin/gh-pages)=="origin/gh-pages" ];
then 
      git push origin --delete gh-pages
else
    echo "no branch gh-pages"   
fi


set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github
#echo 'b.miluluyo.github.io' > CNAME
if [ -z "$VDOING" ]; then
   msg='deploy'
   githubUrl=git@github.com:elliswatson/vdoingBlog.git
else
  msg='来自 github actions的自动部署'
  githubUrl=https://elliswatson:${VDOING}github.com:elliswatson/vdoingBlog.git
  git config --global user.name "elliswatson"
  git config --global user.email "528827908@qq.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github


cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist

