# Setup for Day 3 && 4 of DL Workshop

## Installation

### Docker

First, in order to ensure the downloads are valid, add the GPG key for the official Docker repository to your system:

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`

Add the Docker repository to APT sources:

`sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`

Next, update the package database with the Docker packages from the newly added repo:

`sudo apt-get update`

Make sure you are about to install from the Docker repo instead of the default Ubuntu 16.04 repo:

`apt-cache policy docker-ce`

You should see output similar to the follow:

    docker-ce:
    Installed: (none)
    Candidate: 18.06.1~ce~3-0~ubuntu
    Version table:
        18.06.1~ce~3-0~ubuntu 500
            500 https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages

Notice that docker-ce is not installed, but the candidate for installation is from the Docker repository for Ubuntu 16.04 (xenial).

Finally, install Docker:

`sudo apt-get install -y docker-ce`

Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running:

`sudo systemctl status docker`

The output should be similar to the following, showing that the service is active and running:

    Output
    ● docker.service - Docker Application Container Engine
    Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
    Active: active (running) since Thu 2018-10-18 20:28:23 UTC; 35s ago
        Docs: https://docs.docker.com
    Main PID: 13412 (dockerd)
    CGroup: /system.slice/docker.service
            ├─13412 /usr/bin/dockerd -H fd://
            └─13421 docker-containerd --config /var/run/docker/containerd/containerd.toml

Congrats! You've just installed Docker

---

Let's get started with installing CUDA

Download CUDA Drivers from here 

`wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64`

Installation Instructions:
`sudo dpkg -i cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64`

`sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub`

`sudo apt-get update`

`sudo apt-get install -y cuda`

If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers

`sudo docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f`

`sudo apt-get purge -y nvidia-docker`


Add the package repositories

`curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \sudo apt-key add -`
  
`distribution=$(. /etc/os-release;echo $ID$VERSION_ID)`

`curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \sudo tee /etc/apt/sources.list.d/nvidia-docker.list`

`sudo apt-get update`

Install nvidia-docker2 and reload the Docker daemon configuration

`sudo apt-get install -y nvidia-docker2`

`sudo pkill -SIGHUP dockerd`

Test nvidia-smi with the latest official CUDA image

`sudo docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi`


It should show something like this

    Thu Oct 25 09:09:57 2018       
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 410.48                 Driver Version: 410.48                    |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |===============================+======================+======================|
    |   0  Tesla P100-PCIE...  Off  | 00000000:00:04.0 Off |                    0 |
    | N/A   36C    P0    31W / 250W |  15489MiB / 16280MiB |      0%      Default |
    +-------------------------------+----------------------+----------------------+
                                                                                
    +-----------------------------------------------------------------------------+
    | Processes:                                                       GPU Memory |
    |  GPU       PID   Type   Process name                             Usage      |
    |=============================================================================|
    +-----------------------------------------------------------------------------+

# The following steps are to performed on Saturday Nov 3, 2018 morning only

Download GreyAtom's DL Docker Image
`sudo docker pull saiprasadb/ga-dl-workshop:latest`

Run the DL Docker Image
`sudo nvidia-docker run -itd -p 8888 --volume=/home/$USER/notebooks:/home/jovyan/notebooks --name=ga-dl --ipc=host saiprasadb/ga-dl-workshop:latest jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/home/jovyan/'`


