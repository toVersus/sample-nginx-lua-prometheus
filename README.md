# sample-nginx-lua-prometheus

To reproduce the Lua runtime error, building image locally

```bash
make build
```

And running Nginx process

```bash
❯ make run
docker run -it --rm -p 8080:80 sample-nginx-lua-prometheus:0.1.0
```

Nginx Lua module seems to work fine,

```bash
❯ curl http://localhost:8080/lua_content
Hello,world!
```

And prometheus metrics are exported by `nginx-lua-prometheus` library without any errors:

```bash
❯ curl http://localhost:8080/metrics
# HELP nginx_http_connections Number of HTTP connections
# TYPE nginx_http_connections gauge
nginx_http_connections{state="reading"} 0
nginx_http_connections{state="waiting"} 0
nginx_http_connections{state="writing"} 1
# HELP nginx_http_request_duration_seconds HTTP request latency
# TYPE nginx_http_request_duration_seconds histogram
nginx_http_request_duration_seconds_bucket{host="_",le="0.005"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.01"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.02"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.03"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.05"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.075"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.1"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.2"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.3"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.4"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.5"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="0.75"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="1"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="1.5"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="2"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="3"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="4"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="5"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="10"} 1
nginx_http_request_duration_seconds_bucket{host="_",le="+Inf"} 1
nginx_http_request_duration_seconds_count{host="_"} 1
nginx_http_request_duration_seconds_sum{host="_"} 0
# HELP nginx_http_requests_total Number of HTTP requests
# TYPE nginx_http_requests_total counter
nginx_http_requests_total{host="_",status="200"} 1
# HELP nginx_metric_errors_total Number of nginx-lua-prometheus errors
# TYPE nginx_metric_errors_total counter
nginx_metric_errors_total 0
```
