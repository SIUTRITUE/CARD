#!/bin/sh
# Nếu Render đặt PORT, đổi cổng trong server.xml trước khi chạy
if [ -n "$PORT" ]; then
  sed -i "s/port=\"8080\"/port=\"$PORT\"/" /usr/local/tomcat/conf/server.xml
fi
exec catalina.sh run
