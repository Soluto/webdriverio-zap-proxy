#!/bin/bash

# Abort script on error
set -e

./wait-for-it.sh zap:8090 -t 4000

npm test
#give Zap some time to complete processing
sleep 3
ruby /usr/bin/glue/bin/glue -t zap --zap-host http://zap --zap-port 8090 --zap-passive-mode -f text --exit-on-warn 0 http://juice-shop --finding-file-path /usr/src/wrk/glue.json 

