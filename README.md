Description
====================
An example project of integrating [zap](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) into existing automation tests that are developed with [Webdriver.io](http://webdriver.io/) framework.
Zap is a great tool and can be used to spider your webapp and report security vulnerabilities it found.
By integrating it into the automation test, you gain better coverage of your webapp, as every page that is covered with your tests will be also scanned with Zap.
In this example I used [OWASP Mutillidae](https://github.com/citizen-stig/dockermutillidae) for demonstration purpose - the test simply try to open of the pages so we can see Zap alerts.
I used `docker` and `docker-compose` to make this setup easy by using the following services:
* Selenium hub and chrome [official images](https://github.com/SeleniumHQ/docker-selenium) - to run the tests.
* [Zap weekly](https://hub.docker.com/r/owasp/zap2docker-weekly/)
* [OWASP Mutillidae](https://github.com/citizen-stig/dockermutillidae)
* Test - A service that actually run your automation tests

Running
=========
* clone this repo and browse to the checkout folder
* run `docker-compose build`
* run `docker-compose up -abort-on-container-exit`
* open the `report.html` file in any browser and see the alerts found by Zap!

Behind the scene
=========================
The magic is done by requesting the `proxy capabiltiy` in webdriver.io config (see the whole file under `app/wdio.conf.js`, I used the basic file from the documentation and changed it a bit):
````Javascript
var proxy = "http://zap:8090";
...
capabilities: [{
        browserName: 'chrome',
        proxy: {
                httpProxy: proxy,
                sslProxy: proxy,
                ftpProxy: proxy,
                proxyType: "MANUAL",
                autodetect: false
            },
        'chrome.switches': [
          '--ignore-certificate-errors'
        ]
    }],
````
where `http://zap:8090` is the Zap container address (see [networking](https://docs.docker.com/compose/networking/) documentation).

The test script (`app/test.sh`) is what actually run zap.
Currently it contains the following commands:
* `zap-cli --zap-url http://zap status -t 120` wait until zap complete loading
* `zap-cli --zap-url http://zap open-url http://nowasp` which initiate zap and start a new session
* `npm test` to run the test
* `zap-cli --zap-url http://zap report -o /usr/src/wrk/report.html -f html` to export the report in HTML format.
I am using [Zap cli](https://github.com/Grunny/zap-cli) to interact with zap. 
It is installed on the docker image (see the docker file at `app\Dockerfile`).

Please notice that you can exclude certain urls from zap scanning by using the following command `zap-cli --zap-url http://zap exclude "<url-regex>"`.