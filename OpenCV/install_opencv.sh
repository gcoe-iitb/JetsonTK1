sudo apt-add-repository universe
sudo apt-get update
sudo dpkg -i libopencv4tegra-repo_l4t-r21_2.4.10.1_armhf.deb
sudo apt-get update
sudo apt-get install libopencv4tegra libopencv4tegra-dev

echo "OpenCV has been successfully installed and we will know run a simple edge detection sample program to test it"
#testing simple opencv application:
cd /home/ubuntu/Downloads/OpenCV/cpp/
g++ edge.cpp -lopencv_core -lopencv_imgproc -lopencv_highgui -o edge
./edge

