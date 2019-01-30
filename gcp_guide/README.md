## Deep Learning Sessions

Steps to execute the notebooks on Google Cloud Platform
 - Sign up for Google Cloud Platform. If you are a first time user you will receive $300 free credit after setting up the payment info.
- Create a Google Compute Engine instance using the guide provided
- Start the instance and open the terminal for the same
- Clone this repository into the home directory
- Navigate to the folder gcp_guide within this repository in the terminal
- Execute the command `bash install.sh`
- The entire installation would take about 10-15 minutes to complete.
- This installation will provide you with a docker container where all the required libraries are installed and data is store in data folder
- Once the installation is complete go to the browser and navigate to http://<external ip>:8888 
- Enter the alphanumeric authorisation token displayed on the terminal and log-in
- Open the terminal from within Jupyter Notebook and clone this repository again to get access to the notebooks within docker container
- You may have to change the paths to data files in the notebook depending on the directory in which you clone the repository

** Note: install.sh need to be executed only once. Every time after the installation to start the notebook run the following command on the terminal

`
sudo nvidia-docker run -itd -p 8888:8888 --volume=/home/$USER/notebooks:/home/jovyan/notebooks --name=ga-dl --ipc=host saiprasadb/ga-dl-workshop:latest jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token= --notebook-dir='/home/jovyan/'
`


## Do not forget to stop the instance after completing the tasks to avoid recurring costs.
