#!/usr/bin/env bash
# Installation from go/installdocker#installation

# Remove old docker-* packages (if installed)
sudo apt remove docker-engine docker-runc docker-containerd docker-cli

sudo glinux-add-repo docker-ce-"$(lsb_release -cs)"
sudo apt update -y
sudo apt install docker-ce -y

# If the previous command fails, you may need to clear your
# docker lib (rm -rf /var/lib/docker) as well. Doing this will delete
# all images on disk. Ensure that they are backed up somewhere
# if you don't want this to happen.

# If you receive an error about 'docker-ce' has no installation
# candidate see https://yaqs.corp.google.com/eng/q/5559586039922688#a2


sudo systemctl stop docker
sudo ip link set docker0 down
sudo ip link del docker0

# * move Docker's storage location for more space.
# * avoid conflicts between the Docker bridge and Corp IPs
# * turn on the debug mode, if you don't want that you could set that to false
sudo tee /etc/docker/daemon.json <<EOF
{
  "data-root": "/usr/local/google/docker",
  "bip": "192.168.9.1/24",
  "default-address-pools": [
    {
      "base": "192.168.11.0/22",
      "size": 24
    }
  ],
  "storage-driver": "overlay2",
  "debug": true,
  "registry-mirrors": ["https://mirror.gcr.io"]
}
EOF



# Create the JSON content as a string variable
set docker_config '{
    "data-root": "/usr/local/google/docker",
    "bip": "192.168.9.1/24",
    "default-address-pools": [
    {
      "base": "192.168.11.0/22",
      "size": 24
    }
    ],
    "storage-driver": "overlay2",
    "debug": true,
    "registry-mirrors": ["https://mirror.gcr.io"]
}'

# Use sudo and redirection to write the content to the file
echo $docker_config | sudo tee /etc/docker/daemon.json


# Start docker and test your new docker installation using sudo

sudo systemctl start docker
sudo docker run hello-world

# Sudoless docker go/installdocker#sudoless-docker

# Group already exists on new gLinux
sudo addgroup docker
sudo usermod -aG docker $USER

# Start docker and test your new docker installation using sudo

sudo systemctl start docker
docker run hello-world
