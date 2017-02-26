FROM arhea/yarn:6

# Install Python.
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv && \
  rm -rf /var/lib/apt/lists/*

# Install Zap Cli
RUN pip install --upgrade zapcli

# Create app directory
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN yarn install

RUN chmod +x test.sh

CMD [ "./test.sh" ]
