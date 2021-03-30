Try to deploy the prometheus in kubenetes.

Step 1:

create Namespace

create deploy image: prometheus

forward-node

try it out.



prom/prometheus



open the dashboard of the prometheus 9090

Create a service for the server



`kubectl create service nodeport fpm-svc --tcp=9090:9090 -n fpm`



Store the ConfigMap in the kubenetes.





Scale the pods.



Rollout && Rollback the image version.



Tag the pods



Get the tags



Remove all the pods





