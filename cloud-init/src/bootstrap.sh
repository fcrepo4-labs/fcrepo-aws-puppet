#!/bin/bash
set -ex
CACHEDIR=/var/cache/cloud/puppet
puppet apply --modulepath $CACHEDIR/modules -v $CACHEDIR/site/site.pp
