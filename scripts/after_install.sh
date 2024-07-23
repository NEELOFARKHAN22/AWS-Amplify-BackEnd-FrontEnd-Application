#!/bin/bash
# after install file

cd /home/ubuntu

# remove old build and node modules folders

rm -rf node_modules
rm -rf build

# install the dependancies and create build folder

npm install
npm run build
