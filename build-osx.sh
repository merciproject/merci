#!/bin/sh -xe
make clean
./configure
make deploy
aws s3 sync . s3://mercibq/wallet/ --exclude '*' --include 'Merci-*.dmg' --acl public-read
