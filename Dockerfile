FROM ubuntu:18.04

ENV ver=2.0

RUN apt-get update && apt-get install -y build-essential\
    wget\
    gcc\
    git 

WORKDIR /home/$USER/work
ARG NTRIPCASTER_URL=https://github.com/nyanyaon/ntripcaster2.git
ARG CONF_URL=https://github.com/nyanyaon/TabananConfNtripCaster.git

RUN git clone --depth 1 ${NTRIPCASTER_URL}

RUN cd ntripcaster2 && chmod +x ./configure && ./configure && make && make install

WORKDIR /usr/local/ntripcaster/conf
RUN git clone ${CONF_URL} gitconf
RUN mv gitconf/* .
RUN rm -rf gitconf
    
EXPOSE 2101 8001 8002
ENTRYPOINT ["/usr/local/ntripcaster/bin/ntripcaster", "start"]



