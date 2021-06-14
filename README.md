# sample-nginx-lua-prometheus

To reproduce the Lua runtime error, building image locally

```bash
make build
```

And running Nginx process

```bash
❯ make run
docker run -it --rm -p 8080:80 sample-nginx-lua-prometheus:0.1.0
nginx: [alert] detected a LuaJIT version which is not OpenResty's; many optimizations will be disabled and performance will be compromised (see https://github.com/openresty/luajit2 for OpenResty's LuaJIT or, even better, consider using the OpenResty releases from https://openresty.org/en/download.html)
```

Nginx Lua module seems to work fine,

```bash
❯ curl http://localhost:8080/lua_content
Hello,world!
```

But the runtime error has been triggered by `nginx-lua-prometheus` library:

```bash
2021/06/14 13:15:52 [error] 7#7: *3 failed to run log_by_lua*: /usr/share/lua/common/resty/core/var.lua:71: no request found
stack traceback:
	[C]: in function 'error'
	/usr/share/lua/common/resty/core/var.lua:71: in function '__index'
	log_by_lua(nginx.conf:34):2: in function <log_by_lua(nginx.conf:34):1> while logging request, client: 172.17.0.1, server: _, request: "GET /lua_content HTTP/1.1", host: "localhost:8080"
```
