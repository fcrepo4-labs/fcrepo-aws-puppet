#!/bin/bash
cd $(dirname $0)
puppet apply --modulepath $PWD/modules -v "$@" $PWD/modules/tomcat7/tests/init.pp
