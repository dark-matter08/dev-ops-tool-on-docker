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
- Create backup ssh dir
```bash 
    mkdir /home/ansible/.ssh
```
- Generate public and private ssh keys
```bash 
    ssh-keygen -t rsa -b 4096
```
- Ensure to select the generated keys to be in the ```/home/ansible/.ssh/id_rsa``` folder for backup ability
- Add generate ssh keys to ssh agent
```bash
    ssh-add /home/ansible/.ssh/id_rsa
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