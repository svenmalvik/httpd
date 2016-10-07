#!/bin/bash

consul-template -consul=$CONSUL -log-level debug -template "$CT_FILE:$HTTPD_FILE:apachectl -k graceful"
