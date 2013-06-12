#!/bin/bash

. ~/.awssecret

set -ex

cd $(dirname $0)

./create-user-data.sh tmp/user-data.gz


export conffile=./$(basename $0 .sh).conf
. $conffile

sed -e '/^aws_/!d;s/^aws_/--/;s/_/-/g;/--ami=/d;s/=/ /' $conffile | \
    xargs -t ec2run $aws_ami --user-data-file tmp/user-data.gz "$@"
