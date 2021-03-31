Try to deploy the prometheus in kubenetes.

Step 1:

create Namespace

`kubectl create namespace fpm`
create deploy image: prometheus

forward-node

try it out.



yfsoftcom/echo-go

`kubectl create deployment echo-go --image=yfsoftcom/echo-go -n fpm`

unfortunately, in this case, echo-go has no latest tag, so the container cant run properly.

```
wangfan@WangdeMacBook-Pro kubenetes-memo % kubectl get po
NAME                      READY   STATUS         RESTARTS   AGE
echo-go-767868db5-9tjl2   0/1     ErrImagePull   0          16m
```
so, we need update the image tag manually via the command.

`kubectl set image deployment echo-go echo-go=yfsoftcom/echo-go:1.0 --record`


Create a service for the server

`kubectl expose deployment echo-go --type=NodePort --port=8080 --target-port=8080 --protocol=TCP -n fpm`


get the response of the `/foo` api

`curl localhost:8080/foo`

you should get the `Hello, my host is xxxxxxx, version: beta`


Store the ConfigMap in the kubenetes.


Scale the pods.

``



Rollout && Rollback the image version.



Tag the pods



Get the tags



Remove all the pods





