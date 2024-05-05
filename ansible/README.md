# For Ansible to be able to create docker containers on a host system aand the ansible node


## On the docker host system we will need to

### 1. Create ansadmin user
```bash 
    sudo useradd -m ansadmin
```
### 2. Give new user a password
```bash 
    sudo passwd ansadmin
```
### 3. Add admin to sudoers files
```bash 
    sudo usermod -aG sudo ansadmin
```

### 4. Grant admin priviledges to the user
```bash
    echo "ansadmin ALL=(root) NOPASSWD:ALL" >/etc/sudoers.d/ansadmin \
    && echo "ansadmin ALL=(ALL:ALL) NOPASSWD:ALL" >/etc/sudoers.d/ansadmin \
    && chmod 0440 /etc/sudoers.d/ansadmin

```

### 4. Enable password based login - this is for connection and ssh from jenkins
```bash
    sudo nano /etc/ssh/sshd_config
```
### 5. Set ```PasswordAuthentication``` from ```no``` to ```yes```

## On the ansible node, we will need to 

### 1. Add host ip address to host file - content will be
```
    [server1]
    target-server-ip-address

    [server1:vars]
    ansible_user=ansadmin
    ansible_port= # user 22 or custom port
    host_key_checking=False
```
### 2. Enter docker exec or from docker desktop go to the container and move to the exec tap
```bash
    docker exec -it Ansible /bin/bash
```

### 3. Create ssh directory for user
```bash 
    sudo mkdir /home/ansadmin/.ssh
```
```bash 
    sudo chmod -R 777 /home/ansadmin
```

### 4. Generate public and private ssh keys
```bash 
    ssh-keygen -t rsa -b 4096
```
### 5. Ensure to select the generated keys to be in the ```/home/ansadmin/.ssh/id_rsa``` folder for backup ability

### 6. Secure the keys
```bash 
    chmod 400 /home/ansadmin/.ssh/id_rsa
```

### 7. Add generate ssh keys to ssh agent
```bash
    ssh-agent bash
```
```bash
    ssh-add /home/ansadmin/.ssh/id_rsa
```


### 9. Copy ssh keys to target server
```bash 
    ssh-copy-id -p port ansadmin@target-host-ip
```
### 10. Test connection 
```bash 
    ansible all -m ping
```
```bash
    ansible all -m command -a uptime
```





## For a new project
- create the project folder in the ansible directory
- mount it as a volume to the container in the docker compose
- add the project name to gitignore as you probably do not need it to sync to your github

## On the ansible node, we will need to 

- Create an ssh server into the host of the ansible docker
- create a project and use this path for the destination of the project ```/path-to-ansible-files-on-host/project-name``` eg. ```/dev-ops-tool-on-docker/project-name```