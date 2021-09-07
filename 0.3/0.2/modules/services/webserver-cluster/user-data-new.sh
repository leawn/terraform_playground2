#!/bin/bash

echo "${server.text}" > index.html
nohup busybox httpd -f -p ${server_port} &