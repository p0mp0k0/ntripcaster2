FROM ubuntu:18.04

ENV ver=2.0

RUN apt-get update && apt-get install -y build-essential\
    wget\
    gcc\
    git \
    sudo

WORKDIR /home/$USER/work
ARG NTRIPCASTER_URL=https://github.com/jabastien/ntripcaster2.git

RUN git clone --depth 1 ${NTRIPCASTER_URL}

RUN cd ntripcaster2 && chmod +x ./configure && sudo ./configure && sudo make && sudo make install

RUN cd /etc/ntripcaster \
&& sudo cp clientmounts.aut.dist clientmounts.aut \
&& sudo cp groups.aut.dist groups.aut \
&& sudo cp ntripcaster.conf.dist ntripcaster.conf \
&& sudo cp sourcemounts.aut.dist sourcemounts.aut \
&& sudo cp sourcetable.dat.dist sourcetable.dat \
&& sudo cp users.aut.dist users.aut

RUN cd /usr/local/ntripcaster/bin && sudo ./ntripcaster start
    
EXPOSE 2101 8001 8002
CMD ["bash"]



