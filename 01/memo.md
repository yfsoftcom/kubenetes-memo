Try to deploy the prometheus in kubenetes.

Step 1:

create Namespace

`kubectl create namespace fpm`
create deploy image: prometheus

forward-node

try it out.



yfsoftcom/echo-go

`kubectl create deployment echo-go --image=yfsoftcom/echo-go -n fpm`


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





