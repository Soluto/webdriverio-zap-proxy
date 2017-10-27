Description
====================
An example project of integrating [zap](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) into existing automation tests that are developed with [Webdriver.io](http://webdriver.io/) framework.
Zap is a great tool and can be used to spider your webapp and report security vulnerabilities it found.
By integrating it into the automation test, you gain better coverage of your webapp, as every page that is covered with your tests will be also scanned with Zap.
I presented this project at a Webinar, you can find the slidedeck [here](https://www.slideshare.net/SolutoTLV/all-you-need-is-zap).
In this example I used [OWASP Juice Shope](https://github.com/bkimminich/juice-shop) for demonstration purpose - the test simply try to open one of the pages so we can see Zap alerts.
I am also using [OWASP Glue](https://github.com/OWASP/glue) to process the alerts found by Zap.
I used `docker` and `docker-compose` to make this setup easy by using the following services:
* Selenium hub and chrome [official images](https://github.com/SeleniumHQ/docker-selenium) - to run the tests.
* [Zap stable](https://hub.docker.com/r/owasp/zap2docker-stable/)
* [OWASP Juice Shop](https://hub.docker.com/r/bkimminich/juice-shop/)
* Test - A service that actually run your automation tests

Running
=========
* Clone this repo and browse to the checkout folder
* Run `docker-compose pull --parallel`
* Run `docker-compose build`
* Run `docker-compose up --exit-code-from test`

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

The test script (`app/test.sh`) is what actually run Zap.
It is installed on the docker image (see the docker file at `app/Dockerfile`).
Currently it contains the following commands:
* `./wait-for-it.sh zap:8090 -t 40000` wait until zap complete loading
* `npm test` to run the test
* `ruby /usr/bin/glue/bin/glue -t zap --zap-host http://zap --zap-port 8090 --zap-passive-mode -f text --exit-on-warn 0 http://juice-shop --finding-file-path /usr/src/wrk/glue.json` to process Zap's alert using Glue.

Please notice that you can exclude certain urls from zap alerts by editing `glue.json`.
