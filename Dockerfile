FROM ubuntu:bionic
MAINTAINER Kokulapalan Wimalanathan <kokulapalan@gmail.com>
ENV REFRESHED_AT 2018-05-16


RUN apt-get update && apt-get install -y \
		build-essential \
		nginx \
		python3 \
		git \
		python3-pip \
		vim \
		wget


RUN git clone https://github.com/vollbrechtlab/primerDAFT.git /opt/primerDAFT
RUN pip3 install -r /opt/primerDAFT/requirements.txt

RUN git clone -b docker https://github.com/vollbrechtlab/primer-server.git /opt/primer-server
RUN pip3 install -r /opt/primer-server/rest-api/requirements.txt

RUN	ln -s /opt/primer-server/ui /var/www/html/primer-server
#RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
