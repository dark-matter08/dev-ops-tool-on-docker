# For Ansible to be able to create docker containers on a host system aand the ansible node


# On the docker host system we will need to

- Create ansadmin user
```bash 
    sudo useradd -m ansadmin
```
- Give new user a password
```bash 
    sudo passwd ansadmin
```
- Add admin to sudoers files
```bash 
    sudo usermod -aG sudo ansadmin
```

- Enable password based login - this is for connection and ssh from jenkins
```bash
    sudo nano /etc/ssh/sshd_config
```
- Set ```PasswordAuthentication``` from ```no``` to ```yes```

# On the ansible node, we will need to 

- Add host ip address to host file - content will be
```
    [server1]
    target-server-ip-address

    [server1:vars]
    ansible_user=ansadmin
    ansible_port= # user 22 or custom port
    host_key_checking=False
```
- Enter docker exec or from docker desktop go to the container and move to the exec tap
```bash
    docker exec -it container-id /bin/bash
```

- Generate public and private ssh keys
```bash 
    ssh-keygen -t rsa -b 4096
```
- Ensure to select the generated keys to be in the ```/home/ansadmin/.ssh/id_rsa``` folder for backup ability
- Secure the keys
```bash 
    chmod 400 /home/ansadmin/.ssh/id_rsa
```
- Add generate ssh keys to ssh agent
```bash
    ssh-agent bash
```
```bash
    ssh-add /home/ansadmin/.ssh/id_rsa
```
- Copy ssh keys to target server
```bash 
    ssh-copy-id -p port ansadmin@target-host-ip
```
- Test connection 
```bash 
    ansible all -m ping
```
```bash
    ansible all -m command -a uptime
```
- Configure password for the ansible user
```bash 
    passwd ansadmin
```

<!-- - Enable password based login - this is for connection and ssh from jenkins
```bash
    sudo nano /etc/ssh/sshd_config
```
- Set ```PasswordAuthentication``` from ```no``` to ```yes```


- Switch to ansible user
```bash 
    su - ansadmin
``` -->



# For a new project
- create the project folder in the root directory
- mount it as a volume to the container
- add the project name to gitignore as you probably do not need it to sync to your github

# On the ansible node, we will need to 

- Create an ssh server into the host of the ansible docker
- create a project and use this path for the destination of the project ```/path-to-ansible-files-on-host/project-name``` eg. ```/dev-ops-tool-on-docker/project-name```