#######################################################################################################

# This powershell script will collect and display following information like the boot time, the CPU, the default gateway, the DHCP server, the DNS server, the amount of free space, 
# the host name, the Internet Explorer version, the IP address, the logon domain, the logon server, the MAC address, 
# the machine domain, the free memory, the network card, the network speed, the network type, the OS version, the service pack level, 
# the snapshot time, the subnet mask, the system type, the user name and some volume information.

# Cmdlets from CimCmdlets module are the most important cmdlets for general system management tasks. 
Get-CimInstance -ClassName Win32_Desktop -ComputerName .

Get-CimInstance -ClassName Win32_Desktop -ComputerName . | Select-Object -ExcludeProperty "CIM*"
# To filter out the metadata, use a pipeline operator (|) to send the results of the Get-CimInstance command to Select-Object -ExcludeProperty "CIM*".

# The WMI Win32_BIOS class returns information about the system BIOS on the local computer:
Get-CimInstance -ClassName Win32_BIOS -ComputerName .

# Listing Processor Information
Get-CimInstance -ClassName Win32_Processor -ComputerName . | Select-Object -ExcludeProperty "CIM*"

# Processor family
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName . | Select-Object -Property SystemType

################################################

# Get-CimInstance Win32_OperatingSystem | Select-Object  Caption | ForEach{ $_.Caption }

# OS Architecture
# Get-CimInstance Win32_OperatingSystem | Select-Object  OSArchitecture | ForEach{ $_.OSArchitecture }

# Boot Device
# Get-CimInstance Win32_OperatingSystem | Select-Object  BootDevice | ForEach{ $_.BootDevice }

# Host Name
# Get-CimInstance Win32_OperatingSystem | Select-Object  CSName | ForEach{ $_.CSName }
