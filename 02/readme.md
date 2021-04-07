## Multi containers in same pod

like a web container and a service container with a database.

So, this might should be complicated.

Just try.

redis: alpine3.11

port: 6379

yfsoftcom/echo-go:2.x can aceess the redis

just set the env redis_url=xxx:6379 and redis_pass=admin123 to connect

but how to connect in the kubernetes cluster? what's the url ? must not be the localhost!!!

actually, the host should be the service name, and the kubernetes will resolve the server name to the specific ip address
via the k8s DNS service.

so, just feel free to use the service name.

let k8s to do the rest job.

