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
- add admin to sudoers files
```bash 
    sudo usermod -aG sudo ansadmin
```

- enable password based login - this is for connection and ssh from jenkins
```bash
    sudo nano /etc/ssh/sshd_config
```
- set ```PasswordAuthentication``` from ```no``` to ```yes```

# On the ansible node, we will need to 

- add host ip address to host file - content will be
```
    [server1]
    target-server-ip-address

    [server1:vars]
    ansible_user=ansadmin
    ansible_port= # user 22 or custom port
    host_key_checking=False
```
- create backup ssh dir
```bash 
    mkdir /home/ansible/.ssh
```
- generate public and private ssh keys
```bash 
    ssh-keygen -t rsa -b 4096
```
- ensure to select the generated keys to be in the ```/home/ansible/.ssh/id_rsa``` folder for backup ability
- add generate ssh keys to ssh agent
```bash
    ssh-add /home/ansible/.ssh/id_rsa
```
- copy ssh keys to target server
```bash 
    ssh-copy-id -p port ansadmin@target-host-ip
```
- test connection 
```bash 
    ansible all -m ping
```