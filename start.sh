#!/bin/bash

consul-template -consul=$CONSUL -log-level debug --once -template "/etc/consul-templates/app.conf.tmpl:/usr/local/apache2/conf/extra/app.conf:apachectl -k restart"
