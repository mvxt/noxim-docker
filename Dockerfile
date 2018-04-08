# ADAPTED FROM ubuntu.sh installation file in Noxim repository.
# @see https://github.com/davidepatti/noxim/blob/master/other/setup/ubuntu.sh
# Version 1.0.0
FROM alpine

LABEL maintainer="Michael Vinh Xuan Thanh<meta.orphic@gmail.com>"

# Update pkg manager and install deps
RUN apk update && \
    apk add ca-certificates

# Install deps
RUN apk add --update --no-cache \
    ca-certificates \
    wget \
    build-base \
    sudo \
    tar \
    boost-dev \
    cmake \
    bash \
  && rm -rf /var/cache/apk/*

# Install in /opt
WORKDIR /opt/

# Get noxim source
RUN wget https://github.com/davidepatti/noxim/archive/master.zip -O master.zip && \
    unzip master.zip && \
    mv noxim-master noxim

# Get & install yaml-cpp, v0.5.3
RUN mkdir -p noxim/bin/libs && \
    cd noxim/bin/libs && \
    wget https://github.com/jbeder/yaml-cpp/archive/yaml-cpp-0.5.3.tar.gz && \
    tar -xzf yaml-cpp-0.5.3.tar.gz && \
    mv yaml-cpp-yaml-cpp-0.5.3 yaml-cpp && \
    cd yaml-cpp && \
    mkdir -p lib && \
    cd lib && \
    cmake .. && \
    make

# Shared Library Path ENV Export
ENV LD_LIBRARY_PATH=/opt/noxim/bin/libs/systemc-2.3.1/lib-linux64 \
    CXX=g++ \
    CC=gcc

# Get & install SystemC source
RUN cd noxim/bin/libs && \
    wget http://www.accellera.org/images/downloads/standards/systemc/systemc-2.3.1.tgz && \
    tar -xzf systemc-2.3.1.tgz && \
    cd systemc-2.3.1 && \
    mkdir -p objdir && \
    cd objdir && \
    ../configure && \
    make && \
    make install && \
    cd .. && \
    echo `pwd`/lib-* > systemc.conf && \
    ldconfig systemc.conf

# Compile Noxim and add executable to path
RUN cd /opt/noxim/bin && \
    make && \
    ln -s /opt/noxim/bin/noxim /usr/local/bin/noxim

# Entrypoint script
ENTRYPOINT ["noxim"]
