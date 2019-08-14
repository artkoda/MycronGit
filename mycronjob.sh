#!/bin/sh

source /yours.sh
cd /mycronlog
git add .
git commit --allow-empty-message --allow-empty -m ""
git push

