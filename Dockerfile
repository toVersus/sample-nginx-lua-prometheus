FROM alpine:3.13

COPY config/nginx.conf /etc/nginx/nginx.conf

RUN set -eux \
  # Installing OpenRestry to use OpenResty's LuaJIT2
  && wget 'http://openresty.org/package/admin@openresty.com-5ea678a6.rsa.pub' \
  && mv 'admin@openresty.com-5ea678a6.rsa.pub' /etc/apk/keys/ \
  && . /etc/os-release \
  && MAJOR_VER=`echo $VERSION_ID | sed 's/\.[0-9]\+$//'` \
  && echo "http://openresty.org/package/alpine/v$MAJOR_VER/main" | tee -a /etc/apk/repositories \
  && apk update \
  && apk add --no-cache \
  curl \
  openresty \
  && mkdir -p /run/nginx \
  # See https://github.com/knyar/nginx-lua-prometheus#try-using-an-older-version-of-the-library
  # && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20181120/prometheus.lua > /etc/nginx/prometheus.lua
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus.lua > /etc/nginx/prometheus.lua \
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus_keys.lua > /etc/nginx/prometheus_keys.lua \
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus_resty_counter.lua > /etc/nginx/prometheus_resty_counter.lua

ENTRYPOINT ["openresty", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
