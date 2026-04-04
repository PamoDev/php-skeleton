#!/bin/sh

git remote set-url --add --push origin git@github.com:PamoDev/php-skeleton.git
git remote set-url --add --push origin git@gitlab.com:DeinUser/php-skeleton.git
echo "Pushing Git Commits & Tags to all Remotes..."
for remote in $(git remote); do
    echo "-> Pushing to $remote..."
    git push "$remote" HEAD
    git push "$remote" --tags
done
