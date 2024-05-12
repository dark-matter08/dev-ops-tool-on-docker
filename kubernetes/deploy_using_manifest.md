# Deploy a service on kubernetes with mainifest

## 1. Create a pod

- See example in pods folder

## 2. Create service

- See example in services folder

## 3. Apply Pod
```bash
    kubectl apply -f pod.yml
```

## 3. Apply Service
```bash
    kubectl apply -f service.yml
```

### Note: In the pod and service file make sure that the pod label matches the service selector. this is such that when requests comes to the service, it knows which pod to direct the requests to

## 4. Inspect changes
```bash
    kubectl describe services/demo-service
```
- Example Result
```
    Name:                     demo-service
    Namespace:                default
    Labels:                   <none>
    Annotations:              <none>
    Selector:                 app=demo-app
    Type:                     LoadBalancer
    IP Family Policy:         SingleStack
    IP Families:              IPv4
    IP:                       10.100.102.102
    IPs:                      10.100.102.102
    LoadBalancer Ingress:     localhost
    Port:                     nginx-port  80/TCP
    TargetPort:               80/TCP
    NodePort:                 nginx-port  30761/TCP
    Endpoints:                10.1.0.34:80
    Session Affinity:         None
    External Traffic Policy:  Cluster
    Events:                   <none>
```

```bash
    kubectl get pod -o wide
```
- Example Result
```
    NAME       READY   STATUS    RESTARTS   AGE    IP          NODE             NOMINATED NODE   READINESS GATES
    demo-pod   1/1     Running   0          119s   10.1.0.34   docker-desktop   <none>           <none>
```

#### Note: The value of `Endpoints` of the command `kubectl describe services/demo-service` and `IP` of the command `kubectl get pod -o wide` must match


# Creating Deployment file

## 1. create a deployment file 

- check example in manifests folder

#### Note that in the deployment file, configurations for ports are already included so when writting deployments file, there is no need to write a pod file

## 2. create a service file

- as mentioned above check example in services folder

#### Note: the labels in the deployment file and the service file must match and also the `containerPort` on the deployment file must match the `port` and `targetPort` in the service file


## 3. Run deployment
```bash
    kubectl apply -f service.yml
```