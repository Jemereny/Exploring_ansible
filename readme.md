# Introduction

Learning to use ansible

There is a master control service which will control the other services

# Docker-compose

The docker compose file creates the services so that we can use the services for ssh.

entrypoint.sh file is to start ssh service and run an infinite while loop to ensure the container does not exit

# Master Service Setup commands
First, exec into master service with `docker-compose exec master /bin/bash`.

For ease of access to ssh into other services,

    ssh-keygen # To create ssh key
    ssh-copy-id appserver
    ssh-copy-id webserver
    ssh-copy-id dbserver

Password is `docker` as stated in the [Dockerfile](./Dockerfile) by the line `RUN echo "root:docker" | chpasswd`

    apt-get install software-properties-common
    add-apt-repository ppa:ansible/ansible
    apt-get update
    apt-get install ansible
    ansible --version # To check the version of installed ansible

After installation, the configurations for ansible would be in /etc/ansible. For the control or master machine to work for multiple platforms, copy /etc/ansible to a local directory and work on the copy instead.

    cp -R /etc/ansible platform

The folder would contain
- ansible.cfg
- hosts
- roles

ansible.cfg contains options for ansible and there is a need to change the path of the inventory file

Modify the ansible.cfg from `#inventory = /etc/ansible/hosts` to `inventory = hosts`

Add the names of the services of the slave hosts to the `hosts` file

    webserver
    appserver
    dbserver

And use the command `ansible -m ping all` to test if the connection works.

# Simple Directory structure

    ansible
    |-- hosts
    |-- ansible.cfg
    |-- roles
    |   |--tasks
    |       |--basic
    |           `-- main.yml

hosts - Hosts of services; ip addresses or host names
ansible.cfg - configuration for ansible
roles - groups of tasks to be run by playbook which is reusable

# Other commands

Ansible can use other commands with ansible command modules

https://docs.ansible.com/ansible/latest/modules/list_of_commands_modules.html

e.g. `ansible -m shell -a 'whoami' all`
- Will use the shell command 'whoami' on all services

# Roles

Roles will be executed by playbooks after they are defined.

# Notes

- Ansible assumes that user that it uses is able to run `sudo` without specifying any password