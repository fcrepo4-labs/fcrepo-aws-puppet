#!/bin/bash
set -ex

cd $(dirname $0)

output=${1:-tmp/user-data.gz}

mkdir -p tmp

tar --directory .. --create --file tmp/puppet.tar --exclude '*/tests' modules site

write-mime-multipart --gzip --output=$output \
  src/config.yaml:text/cloud-config \
  src/tarhandler.py:text/part-handler \
  tmp/puppet.tar:application/tar \
  src/bootstrap.sh:text/x-shellscript
  
