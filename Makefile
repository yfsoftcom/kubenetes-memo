

dev:
	version=dev redis_url=localhost:6379 redis_pass=admin123 go run main.go

build:
	docker build --build-arg version=beta -t yfsoftcom/echo-go:$(tag) .

push:
	docker push yfsoftcom/echo-go:$(tag)

run-local:
	docker run -p 8080:8080 --rm --name=echo-go -d yfsoftcom/echo-go:$(tag)

apply:
	sudo mkdir -p /home/k8s_vol
	kubectl apply -f $(folder)/deploy.yaml

clean:
	kubectl delete namespace fpm

switch-ns:
	kubectl config set-context --current --namespace=$(ns)

inspect-log:
	docker logs -f echo-go