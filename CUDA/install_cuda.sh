# Install the CUDA repo metadata that you downloaded manually for L4T
sudo dpkg -i cuda-repo-l4t-r21.2-6-5-prod_6.5-34_armhf.deb
sudo apt-get update
# Install "cuda-toolkit-6-5"
sudo apt-get install cuda-toolkit-6-5
# Add yourself to the "video" group to allow access to the GPU
sudo usermod -a -G video $USER



#Print path to samples:
echo "You can find the CUDA samples in /usr/local/cuda-6.5/samples"
echo


#Make device query sample and check the result
echo "We will build the simple deviceQuery sample and run it to check the results"

cd /usr/local/cuda-6.5/samples/1_Utilities/deviceQuery
sudo make 
./deviceQuery

echo "# Add CUDA bin & library paths:" >> ~/.bashrc
echo "export PATH=/usr/local/cuda/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/lib:" >> ~/.bashrc 
source ~/.bashrc
#check if CUDA is installed 
echo "nvcc has been added to your bashrc and will take effect after restarting the shell. You can use nvcc -V to check the version of CUDA installed on Jetson after restarting the shell"
echo

