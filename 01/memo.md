Try to deploy the prometheus in kubenetes.

Step 1:

create Namespace

`kubectl create namespace fpm`
create deploy image: prometheus

forward-node

try it out.



prom/prometheus

`kubectl create deployment prometheus --image=prom/prometheus -n fpm`

open the dashboard of the prometheus 9090

Create a service for the server

`kubectl expose deployment prometheus --type=NodePort -n fpm`


Store the ConfigMap in the kubenetes.



Scale the pods.



Rollout && Rollback the image version.



Tag the pods



Get the tags



Remove all the pods





