FROM alpine:3.13

RUN set -eux \
  && apk add --no-cache \
  nginx \
  nginx-mod-http-lua \
  curl \
  && mkdir -p /run/nginx \
  # See https://github.com/knyar/nginx-lua-prometheus#try-using-an-older-version-of-the-library
  # && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20181120/prometheus.lua > /etc/nginx/prometheus.lua
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus.lua > /etc/nginx/prometheus.lua \
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus_keys.lua > /etc/nginx/prometheus_keys.lua \
  && curl -s https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/0.20210206/prometheus_resty_counter.lua > /etc/nginx/prometheus_resty_counter.lua

COPY config/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
