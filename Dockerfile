FROM ubuntu:bionic
MAINTAINER Kokulapalan Wimalanathan <kokulapalan@gmail.com>
ENV REFRESHED_AT 2018-05-16


RUN apt-get update && apt-get install -y \
		build-essential \
		apache2 \
		python3 \
		git \
		python3-pip \
		systemd vim wget

RUN git clone https://github.com/vollbrechtlab/primerDAFT.git /opt/primerDAFT
RUN pip3 install -r /opt/primerDAFT/requirements.txt
RUN cd /opt/primerDAFT/ && python3 setup.py install

RUN pwd

RUN git clone  -b docker https://github.com/vollbrechtlab/primer-server.git /opt/primer-server
RUN mkdir -p /opt/primer-server/fa
RUN pip3 install -r /opt/primer-server/rest-api/requirements.txt

RUN	ln -s /opt/primer-server/ui /var/www/html/primer-server

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUN ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf 
RUN ln -s /etc/apache2/mods-available/proxy_html.conf /etc/apache2/mods-enabled/proxy_html.conf
RUN ln -s /etc/apache2/mods-available/proxy_html.load /etc/apache2/mods-enabled/proxy_html.load
RUN ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/proxy_http.load
RUN ln -s /etc/apache2/mods-available/proxy_http2.load /etc/apache2/mods-enabled/proxy_http2.load 
RUN ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load
RUN ln -s /etc/apache2/mods-available/xml2enc.load /etc/apache2/mods-enabled/xml2enc.load


COPY 000-default.conf /etc/apache2/sites-enabled/
COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-run.sh /usr/local/bin/
COPY gunicorn.conf /opt/primer-server/rest-api/
ENV GUNICORN_CMD_ARGS='--access-logfile="/opt/primer-server/rest-api/logs/gunicorn-access.log" --error-logfile = "/opt/primer-server/rest-api/logs/gunicorn-error.log"'

#RUN ln -s usr/local/bin/docker-entrypoint.sh /
#RUN touch /opt/primer-server/rest-api/logs/gunicorn-access.log
#RUN touch /opt/primer-server/rest-api/logs/gunicorn-error.log

# ENTRYPOINT ["/etc/init.d/apache2","start"]
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["docker-entrypoint.sh"]

EXPOSE 80
