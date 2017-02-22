Description
====================
Security tests made easy - just run your existing automation tests (powered by [Webdriver.io](http://webdriver.io/)), and let [zap](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project) do the rest.
How? pretty easy:
* Run zap
* Configure webdriver.io to use zap as proxy
* Run your tests
* Export the report from zap 

And now wrap all this with docker containers...

Running
=========
* clone this repo and browse to the checkout folder
* run `docker-compose build`
* run `docker-compose up -abort-on-container-exit`
* open the `report.html` file in any browser

For the demonstration of this project, I am testing the [OWASP Mutillidae](https://sourceforge.net/projects/mutillidae/) - a super vulnerable app, created by [OWASP](https://www.owasp.org/index.php/Main_Page) - to make sure zap will have something to report.

Docker Compose Services
=========================
As you noticed, all the magic happens with docker-compose. I am running the following services:
* Selenium hub and chrome [official images](https://github.com/SeleniumHQ/docker-selenium) - to run the tests.
* [Zap weekly](https://hub.docker.com/r/owasp/zap2docker-weekly/)
* [OWASP Mutillidae](https://github.com/citizen-stig/dockermutillidae)
* The service that actually running the tests
