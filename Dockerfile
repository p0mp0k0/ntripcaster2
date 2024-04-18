FROM ubuntu:latest

ENV ver=2.0

RUN apt-get update && apt-get install -y build-essential\
    wget\
    gcc\
    curl \
    sudo \
    git 

WORKDIR /home/$USER/work
ARG NTRIPCASTER_URL=https://github.com/nyanyaon/ntripcaster2.git
ARG CONF_URL=https://github.com/nyanyaon/TabananConfNtripCaster.git

RUN git clone --depth 1 ${NTRIPCASTER_URL}

RUN cd ntripcaster2 \
&& chmod 777 configure \
&& sudo ./configure --enable-fsstd \
&& sudo make \
&& sudo make install

WORKDIR /etc/ntripcaster
RUN git clone ${CONF_URL} gitconf
RUN cp gitconf/* .
    
EXPOSE 2101 8001 8002
ENTRYPOINT ["sudo", "/usr/local/ntripcaster/bin/ntripcaster", "start"]




