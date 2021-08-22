# DockerizedWorkspace

## Purpose
This project allows to work in containerized environment (in Ubuntu for now).
What I needed was to access to my workspace separatly to the server system in order to avoid doing bad stuff on my entire server system.
This workspace will also be accessible from anywhere and only my ssh key (which can be customized to fit to your ssh key) will be authorized to access

## Prerequisites
Just Install Docker

## Installation via Github
1. Clone 'git clone git@github.com:Gamma-Software/DockerizedWorkspace.git'
2. Build Dockerfile 'docker build . --tag visualstudio-in-docker'
3. Run container 'docker run -p <ssh_port>:22 -it --restart unless-stopped -v <path_to_workspace>:/home/visualstudio/workspace -v <path_to_ssh_authorized_keys>:/home/visualstudio/.ssh/authorized_keys --name visualstudio visualstudio-in-docker:latest' \
Where *<ssh_port>* is the port you want to use to access to the containerized workspace (prefered port would be > 1024 if 22 is already used); *<path_to_workspace>* is the path to the workspace; *<path_to_ssh_authorized_keys>* is the path to the ssh authorized keys to which should contain your ssh key