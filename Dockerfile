FROM httpd

RUN apt-get update -y && apt-get install -y vim httpie unzip curl wget

RUN wget -P /tmp https://releases.hashicorp.com/consul-template/0.16.0/consul-template_0.16.0_linux_386.zip && \
    unzip /tmp/consul-template_0.16.0_linux_386.zip -d /usr/local/bin/

RUN mkdir /etc/consul-templates
COPY app.conf.tmpl /etc/consul-templates/
COPY httpd.conf /usr/local/apache2/conf/
ENV CT_FILE /etc/consul-templates/app.conf.tmpl
ENV HTTPD_FILE /usr/local/apache2/conf/extra/app.conf

COPY app.conf /usr/local/apache2/conf/extra/
COPY httpd.conf /usr/local/apache2/conf/
COPY start.sh /usr/local/apache2/
