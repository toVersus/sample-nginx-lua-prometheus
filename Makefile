TAG=0.1.0

.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker build --no-cache --progress=plain -t sample-nginx-lua-prometheus:${TAG} .

.PHONY: run
run:
	docker run -it --rm -p 8080:80 sample-nginx-lua-prometheus:${TAG}
