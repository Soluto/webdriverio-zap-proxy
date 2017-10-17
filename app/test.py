from urllib.request import urlopen
import six

response = urlopen('http://zap:8090/OTHER/core/other/htmlreport/formMethod=GET')
report = response.read()
with open('/usr/src/wrk/zap.html', 'wb') as f:
    if not isinstance(report, six.binary_type):
        report = report.encode('utf-8')
    f.write(report)