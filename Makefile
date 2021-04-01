

dev:
	version=dev go run main.go

build:
	docker build --build-arg version=beta -t yfsoftcom/echo-go:$(tag) .

push:
	docker push yfsoftcom/echo-go:$(tag)

run-local:
	docker run -p 8080:8080 --rm --name=echo-go -d yfsoftcom/echo-go:$(tag)

apply:
	kubectl apply -f $(folder)/deploy.yaml

inspect-log:
	docker logs -f echo-go