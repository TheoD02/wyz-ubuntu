#!/bin/bash

echo "Check docker-desktop is running for this WSL 2 distro"
if [ ! -f /mnt/c/Program\ Files/Docker/Docker/Docker\ Desktop.exe ]; then
    echo "Docker Desktop is not installed on Windows, please install it and run it"
    exit 1
fi
# check docker is accessible from WSL 2
if [ ! -f /usr/bin/docker ]; then
    echo "Docker is not accessible from WSL 2, please check Docker Desktop is running and WSL 2 integration is enabled in Docker Desktop settings (see https://docs.docker.com/docker-for-windows/wsl-tech-preview/)"
    exit 1
fi

# Install task
if [ ! -f /home/theo/.local/bin/task ]; then
    echo "Installing taskfile from npm as global"
    sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin
else 
    echo "taskfile already installed"
fi

if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Creating SSH key"
    ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa -q
else
    echo "SSH key already created"
fi

echo "If not already done, add the following SSH key to your Bitbucket account:"
cat ~/.ssh/id_rsa.pub

# Press any key to continue
printf "%s " "Press enter to continue"
read ans

if [ ! -d ~/projects ]; then
    echo "Creating projects directory"
    mkdir ~/projects
else 
    echo "projects directory already exists"
fi
