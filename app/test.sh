#!/bin/bash
zap-cli --zap-url http://zap status -t 120
zap-cli --zap-url http://zap open-url http://nowasp

# exclude urls you want to ignore here
# zap-cli --zap-url http://zap exclude ".*.ttf"

npm test
zap-cli --zap-url http://zap report -o /usr/src/wrk/report.html -f html