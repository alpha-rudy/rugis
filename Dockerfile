FROM ubuntu:disco
MAINTAINER Rudy Chung <rudy.chung@liteon.com>

RUN sed -i 's/archive.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y --no-install-recommends software-properties-common

ENV TZ=Asia/Taipei
RUN echo $TZ > /etc/timezone && apt-get install -y --no-install-recommends tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN echo "dash dash/sh boolean false" | debconf-set-selections; dpkg-reconfigure -f noninteractive dash
RUN apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        bash-completion \
        build-essential \
        curl \
        gawk \
        gdal-bin \
        git \
        iputils-ping \
        less \
        libgdal-dev \
        locales \
        net-tools \
        osmctools \
        osmium-tool \
        p7zip-full \
        perl \
        python-gdal \
        python3 \
        python3-dev \
        python3-pip \
        python3-pkg-resources \
        python3-setuptools \
        ssh \
        sudo \
        vim \
        wget \
    && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade bs4 matplotlib numpy setuptools
RUN pip3 install wheel
RUN pip3 install pygdal=="`gdal-config --version`.*"
RUN pip3 install osmium
RUN locale-gen en_US.UTF-8
RUN adduser --disabled-password --gecos '' builder && adduser builder sudo
ADD ./rootfs /
RUN chown -R builder:builder /home/builder
RUN cd /home/builder/packages/phyghtmap-2.20/ && python3 setup.py install

USER builder
RUN mkdir /home/builder/workspace
WORKDIR /home/builder

CMD ["/bin/bash"]
