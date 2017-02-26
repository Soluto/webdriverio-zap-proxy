#!/bin/bash
zap-cli --zap-url http://zap status -t 120
zap-cli --zap-url http://zap open-url http://nowasp
npm test
zap-cli --zap-url http://zap report -o /usr/src/wrk/report.html -f html