#simply revising bash scripting:
echo  "This script will help you flash Linux for Tegra on Jetson"
tar -xvf Tegra124_Linux_R21.2.0_armhf.tbz2
cd Linux_for_Tegra/rootfs
tar xpf ../../Tegra_Linux_Sample-Root-Filesystem_R21.2.0_armhf.tbz2

#Apply binaries:
cd ..
./apply_binaries.sh

#Flashing OS on Jetson please check if you have put the board in forced recovery mode
#Recovery Check:

echo "
    Put your system into “reset recovery mode” by holding down the “RECOVERY” button and press “RESET” button once on the main board.
    Ensure your Linux host system is connected to the target device through the USB cable for flashing.
    Verify that board was connected by running:
    lsusb | grep -i nvidia
    You should see the following:
    Bus 002 Device 004: ID 0955:7140 NVidia Corp."

read -p "Have you put Jetson in recovery mode?  " answer
if [[ $answer = y || $answer = yes ]] ; then
  # run the command
  echo "So lets flash jetson now !"
else
    echo "please put jetson in recovery mode and run the script again."
fi

#Final flash

cd Linux_for_Tegra
sudo ./flash.sh -S 8GiB jetson-tk1 mmcblk0p1

