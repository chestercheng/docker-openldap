NAME = chestercheng/docker-openldap
VERSION = latest

.PHONY: build build-nocache runtest

build:
	docker build -t $(NAME):$(VERSION) --rm image

build-nocache:
	docker build -t $(NAME):$(VERSION) --no-cache --rm image

runtest:
	docker run --rm -p 389:389 -p 636:636 $(NAME):$(VERSION)
