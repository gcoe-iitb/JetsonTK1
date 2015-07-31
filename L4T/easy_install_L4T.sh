Linux_image="http://developer.download.nvidia.com/mobile/tegra/l4t/r21.2.0/pm375_release_armhf/Tegra124_Linux_R21.2.0_armhf.tbz2"
Linux_file_system="http://developer.download.nvidia.com/mobile/tegra/l4t/r21.2.0/pm375_release_armhf/Tegra_Linux_Sample-Root-Filesystem_R21.2.0_armhf.tbz2"

echo  "This script will help you flash Linux for Tegra on Jetson"
#Download options  
read -p "Do you wish to download the OS files for jetson ?(y/n)" answer
if [ "$answer" = "y" ]; then
	wget $Linux_image
	wget $Linux_file_system
else
	echo "make sure the OS image and sample root file system file is placed in the current working directory "

	#check if files are in the same directory:
	if [ -f ${Linux_image##*/}  -a -f ${Linux_file_system##*/} ]; then
		echo "files found to be in the same directory"
	else
		echo "Required files arent int the same directory... stopping the script."
		exit 0
	fi
fi
tar -xvf  ${Linux_image##*/}
cd Linux_for_Tegra/rootfs
sudo tar xvpf ../../${Linux_file_system##*/}

#Apply binaries:
cd ..
sudo ./apply_binaries.sh

#Flashing OS on Jetson please check if you have put the board in forced recovery mode
#Cheking if the board has been put in forced recovery mode:
echo "Checking if Jetson board is in forced recovery mode.."
lsusb | grep -i nvidia

if [ "$?" = "0" ]; then
	echo "Jetson already in recovery mode and now we will start flashing the OS"
else
	echo "Put your Jetson into “ force recovery mode” by holding down the “FORCE RECOVERY” button and press “RESET” button once on the main board.
    	      Ensure your Linux host system is connected to the target device through the USB cable for flashing.
              Verify that board was connected by running:
              lsusb | grep -i nvidia
              You should see the following:
              Bus 002 Device 004: ID 0955:7140 NVidia Corp."
	
	read -p "Have you put Jetson in recovery mode?(y/n)" answer
	if [ "$answer" = "y" ]; then
		echo "Jetson is ready now we will start flashing the OS"
	else
		echo " Jetson still not put in recovery mode .... stopping the script"
		exit 0
	fi
fi

#Final flash
sudo ./flash.sh -S 8GiB jetson-tk1 mmcblk0p1

