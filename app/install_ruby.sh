#!/bin/bash

# Source: oficial ruby docker image

set -ex 
mkdir -p /usr/local/etc \
	&& { \
		echo 'install: --no-document'; \
		echo 'update: --no-document'; \
	} >> /usr/local/etc/gemrc

buildDeps=' \
    bison \
    dpkg-dev \
    libgdbm-dev \
    ruby \
' \
apt-get update 
apt-get install -y --no-install-recommends $buildDeps 
rm -rf /var/lib/apt/lists/* 

wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" 
echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum -c - 

mkdir -p /usr/src/ruby 
tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 
rm ruby.tar.xz 

cd /usr/src/ruby 

# hack in "ENABLE_PATH_CHECK" disabling to suppress:
#   warning: Insecure world writable dir
{ \
    echo '#define ENABLE_PATH_CHECK 0'; \
    echo; \
    cat file.c; \
} > file.c.new 
mv file.c.new file.c 

autoconf 
gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" 
./configure \
    --build="$gnuArch" \
    --disable-install-doc \
    --enable-shared 
make -j "$(nproc)" 
make install 

apt-get purge -y --auto-remove $buildDeps 
cd / 
rm -r /usr/src/ruby 

gem update --system "$RUBYGEMS_VERSION"

gem install bundler --version "$BUNDLER_VERSION"