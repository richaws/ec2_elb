#!/bin/bash
set -o xtrace
amazon-linux-extras install nginx
echo "<h1> Hello World!! </h1>" > /usr/share/nginx/index.html