curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

apt-cache policy docker-ce

apt-cache policy docker-ce

sudo apt-get install -y docker-ce

echo "###################################"

echo "Installed Docker Successfully"

echo "###################################"

wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64

sudo dpkg -i cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64

sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub

sudo apt-get update

sudo apt-get install -y cuda

echo "###################################"

echo "Installed CUDA Drivers Successfully"

echo "###################################"

rm -r cuda-repo-ubuntu1604-10-0-local-10.0.130-410.48_1.0-1_amd64

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \sudo apt-key add -

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update

sudo apt-get install -y nvidia-docker2

sudo pkill -SIGHUP dockerd

echo "###################################"

echo "Installed nvidia-docker package Successfully"

echo "###################################"

sudo docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi

echo "###################################"

echo "Oh yeah! GPU works Successfully"

echo "###################################"

sudo docker pull saiprasadb/ga-dl-workshop:latest

sudo nvidia-docker run -itd -p 8888:8888 --volume=/home/$USER/notebooks:/home/jovyan/notebooks --name=ga-dl --ipc=host saiprasadb/ga-dl-workshop:latest jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/home/jovyan/'
