#!/usr/bin/env bash

# Update the apt package index:

apt-get update

# Install packages to allow apt to use a repository over HTTPS:

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Add Docker’s official GPG key:

curl -fsSL https://download.docker.com/linux/debian/gpg |  apt-key add -

# Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.

apt-key fingerprint 0EBFCD88

# Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below. 

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"


## Install Docker CE

# Update the apt package index.

apt-get update

# Install the latest version of Docker CE and containerd, or go to the next step to install a specific version:

apt-get install docker-ce docker-ce-cli containerd.io



