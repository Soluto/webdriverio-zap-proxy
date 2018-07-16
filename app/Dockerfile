FROM node:9

WORKDIR /usr/src/app

COPY install_dependencies.sh ./
RUN ./install_dependencies.sh

COPY package.json /tmp
COPY yarn.lock /tmp
RUN cd /tmp && yarn install

RUN cp -a /tmp/node_modules /usr/src/app/

COPY . /usr/src/app

CMD [ "./run_test.sh" ]
