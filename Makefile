IMAGE_TAG=armcanada/php7-mssql:latest

.PHONY: build
build:
	docker build -t $(IMAGE_TAG) .

.PHONY: tag
tag:
	docker tag $(IMAGE_TAG) $(IMAGE_TAG)

.PHONY: push
push: build tag
	docker push $(IMAGE_TAG)



