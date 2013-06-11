#!/bin/bash

set -ex

cd $(dirname $0)

./create-user-data.sh tmp/user-data.gz

[ -f tmp/aws ] || curl https://raw.github.com/timkay/aws/master/aws --output tmp/aws

export conffile=./$(basename $0 .sh).conf
. $conffile
sed -e '/^aws_/!d;s/^aws_/--/;/--ami=/d;s/=/ /' $conffile | \
    xargs -t perl tmp/aws run $aws_ami --xml --user-data-file tmp/user-data.gz "$@"
