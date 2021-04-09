# k3d-setup-external-ip
K3D clusters run in MacOS or Linux with External IP

## Communicate with k3d
By default, k3d sets up the Kubernetes API server IP to be the local loopback address (127.0.0.1).  
Configure the k3d cluster to use an IP address that is already resolvable from your local machine.

So, You can test a scenario k3d cluster to use an externel IP.  

## Requirements
* docker
* bash, curl

## Related Projects
* k3d : k3s in Docker

## Create Cluster
```sh
# ./create.sh
Downloading & Installing k3d
Preparing to install k3d into /usr/local/bin
Password:
k3d installed into /usr/local/bin/k3d
Run 'k3d --help' to see what you can do with it.
INFO[0000] Using config file external_ip.yml
INFO[0000] Prep: Network
INFO[0000] Created network 'k3d-net'
INFO[0000] Created volume 'k3d-nexclipper-images'
INFO[0001] Creating node 'k3d-nexclipper-server-0'
INFO[0001] Creating node 'k3d-nexclipper-agent-0'
INFO[0002] Creating node 'k3d-nexclipper-agent-1'
INFO[0003] Creating LoadBalancer 'k3d-nexclipper-serverlb'
INFO[0003] Starting cluster 'nexclipper'
INFO[0003] Starting servers...
INFO[0003] Starting Node 'k3d-nexclipper-server-0'
INFO[0010] Starting agents...
INFO[0010] Starting Node 'k3d-nexclipper-agent-0'
INFO[0020] Starting Node 'k3d-nexclipper-agent-1'
INFO[0028] Starting helpers...
INFO[0028] Starting Node 'k3d-nexclipper-serverlb'
INFO[0030] (Optional) Trying to get IP of the docker host and inject it into the cluster as 'host.k3d.internal' for easy access
INFO[0041] Successfully added host record to /etc/hosts in 4/4 nodes and to the CoreDNS ConfigMap
INFO[0041] Cluster 'nexclipper' created successfully!
INFO[0041] --kubeconfig-update-default=false --> sets --kubeconfig-switch-context=false
INFO[0041] You can now use it like this:
kubectl config use-context k3d-nexclipper
kubectl cluster-info
Starting K3d Cluster
-
All Resources Ready State!
```


## Delete Cluster
```sh
$ k3d cluster delete --all
```