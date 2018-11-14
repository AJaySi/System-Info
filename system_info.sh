#!/bin/bash

##############################################################################
#
# Tool Name   : system_info.sh
# Author Name : Ajay Singh
#
# Usage : ./system_info.sh [option]
#       -r | --report        [hardware] [software] [configs] [cluster] [disks] [network] [all]
#       -v | --verbose       Verbose output
#       -h | --help          This help or usage message.
#       -tbd | --whatsnext   To Be Done Features Or Enhancement for this script.
#
# Supported Platforms:
# 1). Red Hat Enterprise Linux
# 2). CentOS
# 3). SuSE
# 4). ubuntu
# 5). Windows (TBD)
#
# Techonology Stack:
# 1). Shell (AWK, Sed, commands, built-ins)
# 2). Electron Web framework (Javascript, HTML, CSS)
# 3). Powershell
#
##############################################################################
#
# Design Considerations : 
#
# Present Alternatives : 
#
# 1). Sysinfo Tool :
# https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel_SYSINFO_UserGuide.pdf
# The Intel® System Information Retrieval Utility (Sysinfo) is not intended for and should not be used on any
# non-Intel server products.
# 
# 2). Inxi is a 10K line bash script for hardware details from multiple different sources and commands on the system, 
# and generates a command line report for technical users. Lacks a GUI based reporting for non technical users.
# 
# 3). https://github.com/linuxhw/hw-probe 
# This utility dumps it on web page. It is better than others. Usuability and reporting can be improved.
# The report dumped are not really human readable or sysadmins and GUI users.
# 
# 4). hwlist is another script to probe and list hardware information. 
# It seems limited and dumps all information on CLI. It needs to extended for many more details.
#
# 5). cfg2html : A UNIX shell script (or collection of) to gather all kind of
# system information and combine these into one big ASCII and HTML file
# https://www.cfg2html.com/cfg2html-FOSDEM2014-rr.pdf
#
##############################################################################
#
# echo "This Computer Using `uname -m` architecture ;<br>"
# echo "The Linux Kernel Used on this computer `uname -r`<br>"
# echo -e "This Linux Distro. Used On this computer `head -n1 /etc/issue`<br>"
# echo "The Host Name Of this computer is `hostname`<br>"
# echo "The Name Of the user Of this computer is `whoami` <br>"
# echo "The Number Of The Users That Using This Computer `users | wc -w` Users <br>"
# echo "The System Uptime = `uptime | awk '{ gsub(/,/, ""); print $3 }'` (Hrs:Min)<br>"
# echo "The Run level Of Current OS is `runlevel`<br>"
# echo "The Number OF Running Process :`ps ax | wc -l`<br>"
# echo "Number of CPUs `grep -c 'processor' /proc/cpuinfo` CPU<br>"
# echo "CPU model name is `awk -F':' '/^model name/ { print $2 }' /proc/cpuinfo`<br>"
# echo "CPU vendor`awk -F':' '/^vendor_id/ { print $2 }' /proc/cpuinfo`<br>"
# echo "CPU Speed`awk -F':' '/^cpu MHz/ { print $2 }' /proc/cpuinfo`<br>"
# echo "CPU Cache Size`awk -F':' '/^cache size/ { print $2 }' /proc/cpuinfo`<br>"
#
##############################################################################

MYDATE="$(/bin/date +'%Y.%m.%d.%m.%H.%M')"
MYNAME=$(basename $0)
WHOAMI=$(/usr/bin/whoami)
MYHOSTNAME=$(/bin/uname -n)
MYSHORTNAME=$(echo $MYHOSTNAME | cut -f 1 -d'.')
#TMPFILE="/tmp/$(basename $0).$$"

find_sbin_cmd() {
    for base in / /usr/ /usr/local; do
        if [ -e $base/sbin/$1 ]; then
            echo $base/sbin/$1
            exit
        fi
    done
}
FDISK=`which fdisk 2>/dev/null`
LSUSB=`which lsusb 2>/dev/null`
LSPCI=`which lspci 2>/dev/null`
[ -z "$FDISK" ] && FDISK=`find_sbin_cmd fdisk`
[ -z "$LSUSB" ] && LSUSB=`find_sbin_cmd lsusb`
[ -z "$LSPCI" ] && LSPCI=`find_sbin_cmd lspci`

# Set the path for the script to run.
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:$PATH
export PATH

--------------------

# Function to list kernel information.
kernel_info()
{
	# lsb_release -a
	# cat /etc/*release*
	
	# Linux Kernel name 
	uname -s
	# Linux kernel release
	uname -r 
	#Linux kernel version
	uname -v
	# Network node name 
	uname -n

	# x86_64 signifies 64-bit architecture, i686 means 32-bit system. 
	# System hardware architecture
	uname -m
	# Get processor type and 
	#uname -p
	# Get OS Details
	uname -o
	
	# Getting h/w information like memory, CPU, disks, etc
	# lshw -short -C memory
	# sudo lshw -html > [filename.html]
	sudo lshw
	
	# Get CPU information like CPU architecture, number of CPUs, cores, CPU family model, threads, CPU caches
	# less /proc/cpuinfo
	lscpu
	# cat /proc/meminfo
	#cat /proc/cpuinfo
	# lsblk, lspci, lsscsi devices
	# lsdev
	
	# List all currently loaded kernel modules.
	# cat /proc/modules
}

---------------------

# Details of processes information
proc_info()
{
	# systemctl
	# meminfo
}

---------------------

# Function to get all the details of the user on the system.
# Following details will be listed : Show list of users.
# Show list of logged on users.
# Show last users logged in etc.
user_info()
{
	# getent passwd
	# id -u
	# who -a
	# last -a
	# cut -d : -f 1 /etc/passwd
	# cut -d : -f 1 /etc/group
}

--------------------

sw_installed()
{
	# which gcc g++ python perl nasm ruby gdb make java php 2>/dev/null

    ## Depending on the type of OS
    # dpkg -l 2>/dev/null
    # pacman -Qqen 2>/dev/null
    # rpm -qa 2>/dev/null
    # yum list installed 2>/dev/null
    # apt --installed list 2>/dev/null
    # aptitude search '~i' 2>/dev/null
    # dnf list installed 2>/dev/null

    ## Services running on the system
    # service --status-all 2>/dev/null
    # chkconfig --list 2>/dev/null
    # systemctl -t service -a
    # netstat -tulnpe

}

---------------------

# Function to collect firmware information.
firmware_info()
{

}

--------------------

# Number of RAM dimm slots, occupancy, speeds and availability.
# RAM speed and max supported ram by server
# dmidecode --type 17
ram_info()
{

}

---------------------

mem_info()
{
	# cat /proc/meminfo
	# free
	# free -m
	# free -mt
	# free -gt

	# Display installed hard disk and size
	# fdisk -l | grep '^Disk /dev/'
	
	# top/htop/atop commands to see used and free memory and cpu usage
	
	# cat /proc/partitions
	# fdisk -l will show you partition and disk structure
	
	# memory/ram information
	# sudo dmidecode -t memory
	
	# cat /proc/meminfo | head -2
	# egrep --color 'Mem|Cache|Swap' /proc/meminfo
	
	#for memoryid in `dmidecode -t17|awk '/Handle / {print $2}'|tr -d ','`; do 
	#	populated=`dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Size:/ {print $2, $3}'`; 
	#	if [[ "$populated" != "No Module" ]]; then echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Locator:/ {print $2}'|head -1`; 
	#		echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Size:/ {print $2, $3}'`; 
	#		echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Speed:/ {print $2, $3}'`; 
	#		echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Type:/ {print $2, $3}'`; 
	#		echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Serial Number:/ {print $3}'`; echo `dmidecode -t17|grep -A17 "Handle ${memoryid}"|awk '/Part Number:/ {print $3}'`; 
	#		echo `/n`; 
	#	fi 
	#done
}

---------------------

# Function to Display information about hardware RAID
raid_info()
{
	# mdadm
}

---------------------

# Function to collect all LVM information
lvm_info()
{

}

---------------------

# Display information about the processor/cpu
cpu_info()
{
	# sudo dmidecode -t processor
	# cat /proc/cpuinfo
	# dmidecode -t4|awk '/Handle / {print $2}' |sed 's/,//'
	
	# CPUS=`cat /proc/cpuinfo | grep processor | wc -l | awk '{print $1}'`
	# CPU_MHZ=`cat /proc/cpuinfo | grep MHz | tail -n1 | awk '{print $4}'`
	# CPU_TYPE=`cat /proc/cpuinfo | grep vendor_id | tail -n 1 | awk '{print $3}'`
	# CPU_TYPE2=`uname -m`
	
	# /bin/dmesg| grep CPU| awk -F: '{print $1}'| sort -u| wc -l
	#for cpus in `dmidecode -t4|awk '/Handle / {print $2}'`; do 
	#	echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Socket Designation"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
	#	echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Family"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
	#	echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Manufacturer"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
	#	echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Current Speed"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
	#	echo `dmidecode -t4|sed '/Flags/,/Version/d'|egrep -A20 "Handle ${cpus}"|grep -m 1 "Core Count"|grep -o '.\{0,0\}:.\{0,18\}'|tr -d '\:| '`; 
	#done
	
	# mpstat -a
	
	# Report CPU statistics and input/output statistics for devices and partitions.
	# iostat -a
}

--------------------

virtual_mem_info()
{
	# vmstat
}

--------------------

nfs_info()
{
	# nfsstat
	# nfsiostat
}

--------------------

# Function to gather and display all network related information.
network_info()
{
	# ifconfig -a
	# netstat -a
	
	# Network realted hardware
	# sudo lshw -class network
	
	# HOSTNAME=`hostname -s`
	# IP_ADDRS=`ifconfig | grep 'inet addr' | grep -v '255.0.0.0' | cut -f2 -d':' | awk '{print $1}'`
	# IP_ADDRS=`echo $IP_ADDRS | sed 's/\n//g'`
	# ifconfig eth0 |awk '/inet addr:/ {print $2}'|tr -d 'addr:'
	# ifconfig eth0 |awk '/HWaddr/ {print $5}'
	
	# dns name and aliases
	# nslookup `hostname`|grep Name; nslookup `hostname`|sed -n '/Alias/,$p'
	
	# Interfaces details
	# netstat -in|grep -v Kernel|grep -v Iface|grep -v lo|awk '{print $1}'|xargs -iboink cat /etc/sysconfig/network-scripts/ifcfg-boink|sed -n 1,2p
	
	# ifconfig -a 2>/dev/null
    # ip addr show 2>/dev/null
    # ip route show 2>/dev/null
    # netstat -nr 2>/dev/null
    # cat /etc/hosts
    # cat /etc/resolv.conf
    # cat /etc/nsswitch.conf
    # arp
}

--------------------

# Information regarding partitions something like used space, available space and file system type.
df_info()
{
	# df -ah
	# display mounted volumes and location
}
--------------------
kernel_mods()
{
	# lsmod
}
-------------------

os_info()
{
	# Cant rely on it.
	lsb_release -a
	# prints the name of the operation system, for example GNU/Linux or Msys.
	# uname -o	
	
	# OS_NAME=`uname -s`
	# OS_KERNEL=`uname -r`
	# BOOT=`procinfo | grep Bootup | sed 's/Bootup: //g' | cut -f1-6 -d' '`
	# UPTIME=`uptime | cut -f5-8 -d' '`
}

-------------------

# Function to list details on NVME SSD based flash devices.
flash_info()
{

}

-------------------

# SCSI/SATA devices information.
scsi_info()
{
	# cat /proc/scsi/scsi
	# sudo hdparm -i /dev/sda
}

-------------------
# Function to display BIOS information
bios_info()
{
	# bios details
	# sudo dmidecode -t bios
}
-------------------

# Function to display details of existing File systems.
fs_info()
{
	# df -H
	# mount | column -t | grep ext
	# sudo fdisk -l
	
	## This can be another function.
	# mount -l
    # cat /proc/mounts
    # cat /etc/mtab
}

-------------------

# Parent function for all the hardware details.
# BIOS version & modes, motherboard details. CPU and RAM details.
hw_info()
{
	# sudo dmidecode -q
	
	# RAM Details
	free -m

	# lshw - List Hardware
	# GPU info
	# sudo lshw -class video
	
	# Hwinfo : kyboard, mouse, sound, storage, network, disk, partitions, 
	
	# Network realted hardware
	# sudo lshw -class network
	
	# List device Driver information
}

------------------

# Function to find out if the underlying system is physical machine or virtual.
phy_virt_mc()
{
	# sudo dmidecode -s system-manufacturer
	# if manufacturer_name; then
		# physical machine
	# else
		# Virtual machine
			
	# sudo dmidecode | grep Product
	# Check the product name for ascertaining physical or virtual.
	# sudo dmidecode | egrep -i 'manufacturer|product'
	
	# sudo dmesg | grep "Hypervisor detected"
	# No output if no virtulization layer present.
}

-------------------

# Function to install tools required for gathering information.
# Need to figure out type of OS and install accordingly.
# TBD : Better to have a install.sh script.
install_tools()
{
	# In Debian, Ubuntu, Linux Mint
	# RHEL and derivatives like CentOS, scientific Linux:
	# SUSE/openSUSE:

	# sudo zypper in lshw
	# sudo yum install epel-release
	# sudo yum install lshw
	# sudo apt-get install dmidecode
	# sudo apt-get install lshw
	
	# facter is another option, but needs to installed.
	
	# hostnamectl command. It requires systemd to work.
	
	# http://people.redhat.com/~rjones/virt-what/
	# virt-what is packaged for all popular Linux distributions, 
	# such as RHEL, Fedora, CentOS, Debian, Ubuntu, Arch Linux (AUR).
	
	# install sysinfo for intel hardwares. 
	# It just dumps everything in log files and its ugly.
	
	# sudo apt-get install lsscsi        [on Debian derivatives]
	# yum install lsscsi                 [On RedHat based systems]
	# dnf install lsscsi                 [On Fedora 21+ Onwards]
	
	# sudo yum install hardinfo
	
	# apt-get install sysstat : mpstat -a

	# list NFS statistics : apt-get install nfs-common
	
	# network statistics tool : nstat
}
