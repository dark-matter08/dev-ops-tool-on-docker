# Kubernetes set up on linux server


## 1. Check server architecture type

```bash 
    uname -m
```

## 2. Go to Kubernetes website download for the corresponding architecture type

- Download Kubernetes at : [`https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/`](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

## 3. Download and set up minikube
```bash
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

```bash
    minikube version
```

## 4. Start a cluster 
```bash
    minikube start
```
- Check version

##############################################################################################################################################################################

# Examples

# Deploying Nginx pods on Kubernetes

## 1. Create a new deployment

```bash
    kubectl create deployment demo-nginx --image=nginx --replicas=2 --port=80
```
- Check deployment
```bash
    kubectl get all
    kubectl get pod
```

## 2. Expose the deployment as a service

```bash
    kubectl expose deployment demo-nginx --port-80 --type=LoadBalancer
```
- Check deployment
```bash
    kubectl get services -o wide
```