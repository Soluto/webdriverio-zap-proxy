FROM node:latest

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Install Zap Cli
RUN pip install --upgrade zapcli

COPY package.json /tmp
COPY yarn.lock /tmp
RUN cd /tmp && yarn install
# Create app directory
WORKDIR /usr/src/app

RUN cp -a /tmp/node_modules /usr/src/app/

COPY . /usr/src/app
RUN chmod +x test.sh

CMD [ "./test.sh" ]
