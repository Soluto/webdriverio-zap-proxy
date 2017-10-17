#!/bin/bash

# Abort script on error
set -e

zap-cli --zap-url http://zap status -t 400
zap-cli --zap-url http://zap open-url http://juice-shop

# exclude urls you want to ignore here
zap-cli --zap-url http://zap exclude ".*bower_components.*"

npm test
zap-cli --zap-url http://zap report -o /usr/src/wrk/report.html -f html

zap-cli --zap-url http://zap alerts --alert-level Low
