#!/usr/bin/env sh

# abort on errors
set -e

# build
npm run build

# navigate into the build output directory
cd dist

git init
git add -A
git commit -m 'deploy'
git branch -M main
git push -f git@github.com:fumi23/devil-chess.git main:gh-pages

cd -
