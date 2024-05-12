# Deploying Nginx pods on Kubernetes

## 1. Create a new deployment

```bash
    kubectl create deployment demo-nginx --image=nginx --replicas=2 --port=80
```
- Check deployment
```bash
    kubectl get all
    kubectl get pod
    kubectl get deployments
    kubectl get replicaset
```

## 2. Expose the deployment as a service

```bash
    kubectl expose deployment demo-nginx --port=80 --type=LoadBalancer
```
- Check deployment
```bash
    kubectl get services -o wide
```