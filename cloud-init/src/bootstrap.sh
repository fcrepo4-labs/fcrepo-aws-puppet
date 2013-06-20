#!/bin/bash

set -ex

export CACHEDIR=/var/cache/cloud/puppet
puppet apply -l /tmp/puppet.log --debug --modulepath $CACHEDIR/modules -v $CACHEDIR/site/site.pp
