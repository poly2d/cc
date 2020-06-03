#!/bin/sh
# From https://gohugo.io/hosting-and-deployment/hosting-on-github/

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

SHA="$(git rev-parse HEAD | head -c7)"

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating site"
hugo -D -v --theme er

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "update gh-pages (publish.sh @ $SHA)"

#echo "Pushing to github"
#git push --all
