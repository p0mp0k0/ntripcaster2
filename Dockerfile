FROM ubuntu:18.04

ENV ver=2.0

RUN apt-get update && apt-get install -y build-essential\
    wget\
    gcc\
    git

WORKDIR /home/$USER/work
ARG NTRIPCASTER_URL=https://github.com/jabastien/ntripcaster2.git
RUN git clone --depth 1 ${NTRIPCASTER_URL}
RUN cd ntripcaster2 && chmod +x ./configure && ./configure && make && make install
RUN cd /usr/local/ntripcaster/conf && cp clientmounts.aut.dist clientmounts.aut && cp groups.aut.dist groups.aut && cp ntripcaster.conf.dist ntripcaster.conf && cp sourcemounts.aut.dist sourcemounts.aut && cp sourcetable.dat.dist sourcetable.dat && cp users.aut.dist users.aut
RUN cd /usr/local/ntripcaster/bin && sudo ./ntripcaster start
    
EXPOSE 2101 8001 8002
CMD ["bash"]



