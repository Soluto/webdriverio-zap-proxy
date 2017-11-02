FROM node:latest

# Copied from oficial ruby image
ENV RUBY_MAJOR 2.4
ENV RUBY_VERSION 2.4.2
ENV RUBY_DOWNLOAD_SHA256 748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735
ENV RUBYGEMS_VERSION 2.6.14
ENV BUNDLER_VERSION 1.15.4

RUN cd /tmp && \
    wget https://gist.githubusercontent.com/omerlh/cfe6394754788b2b0b9f836c6c238be7/raw/ec496816307a39da5030412192fa9deda9476ea7/install_ruby.sh && \
    chmod +x install_ruby.sh && \
    /tmp/install_ruby.sh

RUN mkdir /tmp/glue && \
    cd /tmp/glue && \
    wget https://github.com/OWASP/glue/archive/master.tar.gz && \
    tar -zxvf master.tar.gz --strip-components=1 && \
    rm -rf master.tar.gz && \
    bundle install && \
    cd ../ && \
    mv glue /usr/bin/

COPY package.json /tmp
COPY yarn.lock /tmp
RUN cd /tmp && yarn install
# Create app directory
WORKDIR /usr/src/app

RUN cp -a /tmp/node_modules /usr/src/app/

COPY . /usr/src/app
RUN chmod +x test.sh && \
    wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x wait-for-it.sh

CMD [ "./test.sh" ]
