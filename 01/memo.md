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

`kubectl create configmap echo-go-version --from-literal=version=v2 -n fpm`

Attach the configmap into the deployment.

Set env for the deployment

`kubectl set env deployment echo-go version=2.1 -n fpm`


Scale the pods.

`kubectl scale deployment echo-go --replicas=3 -n fpm`

``



Rollout && Rollback the image version.



Tag the pods
`kubectl label po echo-go-75f76c6b78-8smjk env=qa -n fpm`


Get the tags
`kubectl get po --show-labels -n fpm`


Remove all the pods

`kubectl delete namespace fpm`


### Volume

Create a hosted local filesystem, and mounted it to the pod.

simple way is define a `hostPath` volume.

but as you know, this just can be apply the single node. coz it just share the host filesystem.



