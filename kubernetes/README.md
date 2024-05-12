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
- Check version
```bash
    minikube version
```

## 4. Start a cluster 
```bash
    minikube start
```


