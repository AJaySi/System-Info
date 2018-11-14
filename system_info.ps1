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

# Listing Computer Manufacturer and Model
Get-CimInstance -ClassName Win32_ComputerSystem

# Listing Installed Hotfixes : 	Win32_QuickFixEngineering
Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName .
# Get-CimInstance -ClassName Win32_QuickFixEngineering -ComputerName . -Property HotFixID

# Listing Operating System Version Information
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property Build*,OSType,ServicePack*

# Listing Local Users and Owner
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName . | Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser

# Getting Available Disk Space
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName .
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName . | Measure-Object -Property FreeSpace,Size -Sum | Select-Object -Property Property,Sum

# Getting Logon Session Information
Get-CimInstance -ClassName Win32_LogonSession -ComputerName .

# Getting the User Logged on to a Computer
Get-CimInstance -ClassName Win32_ComputerSystem -Property UserName -ComputerName .

# Getting Local Time from a Computer
Get-CimInstance -ClassName Win32_LocalTime -ComputerName .

# Displaying Service Status
Get-CimInstance -ClassName Win32_Service -ComputerName . | Select-Object -Property Status,Name,DisplayName
Get-CimInstance -ClassName Win32_Service -ComputerName . | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap


################################################

# Get-CimInstance Win32_OperatingSystem | Select-Object  Caption | ForEach{ $_.Caption }

# OS Architecture
Get-CimInstance Win32_OperatingSystem | Select-Object  OSArchitecture | ForEach{ $_.OSArchitecture }

# Boot Device
Get-CimInstance Win32_OperatingSystem | Select-Object  BootDevice | ForEach{ $_.BootDevice }

# Host Name
Get-CimInstance Win32_OperatingSystem | Select-Object  CSName | ForEach{ $_.CSName }
