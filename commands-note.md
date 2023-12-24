<center> <h2 style="color:Maroon;">Tips and Tricks</h2> </center>


<details>
<summary><b style="color:Maroon;">Windows Subsystem for Linux (WSL)</b></summary>

**Enable the Windows Subsystem for Linux:**
<sub>Open PowerShell as Administrator (Start menu > PowerShell > right-click > Run as Administrator) and enter this command or enable manually from Control Pannel:
<sub>

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

<sub>Install WSL command and set to WSL 2 by default<sub>

```powershell
wsl --install
wsl --set-default-version 2
```
<sub>Install Windows Subsystem for Linux (WSL) Distribution using Command<sub>

```powershell
wsl --list --online
# install distribution
wsl --install -d <distroName>
# list of distribution
wsl -l -v
# start distribution
wsl -d <distroName>
# logout distribution
wsl --terminate <distroName>
# uninstall distribution with below command and remove from app
wsl --unregister <distroName>
rm -rf <distro location>
```
**Enable same/different version multiple distribution in WSL**

```powershell
wsl -l -v
# export current distribution (Ubuntu-22.04)  
wsl --export Ubuntu-22.04 D:\Software\OS\wsl-distribution\ubuntu-empty.tar.gz
# import distribution (Ubuntu-test-base) from local
wsl --import Ubuntu-test-base D:\Software\OS\wsl-distribution\test-base D:\Software\OS\wsl-distribution\ubuntu-empty.tar.gz
wsl -d Ubuntu-test-base
# import distribution (Ubuntu-test-base-2) from local
wsl --import Ubuntu-test-base-2 D:\Software\OS\wsl-distribution\test-base-2 D:\Software\OS\wsl-distribution\ubuntu-empty.tar.gz
wsl -d Ubuntu-test-base-2
```
**or**
<sub>get distribution manually from below link<sub>

https://cloud-images.ubuntu.com/wsl/

<sub>Must use powershell and following command to download the Ubuntu WSL tarball<sub> 

```powershell
Remove-Item alias:curl
# cd to download location D:\Software\OS\wsl-distribution
curl (("https://cloud-images.ubuntu.com",
"wsl/jammy/current",
"ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz") -join "/") `
--output ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz 
# wsl --import <Distribution Name> <Installation Folder> <Ubuntu WSL2 Image Tarball path>
wsl --import Ubuntu-22.04-test D:\Software\OS\wsl-distribution\test-base-3 D:\Software\OS\wsl-distribution\ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz
wsl -l -v
wsl -d Ubuntu-22.04-test
```

<sub>or other version<sub>

```powershell
Remove-Item alias:curl
# cd to download location D:\Software\OS\wsl-distribution
curl (("https://cloud-images.ubuntu.com",
"wsl/lunar/20231219",
"ubuntu-lunar-wsl-amd64-wsl.rootfs.tar.gz") -join "/") `
--output ubuntu-lunar-wsl-amd64-wsl.rootfs.tar.gz
# wsl --import <Distribution Name> <Installation Folder> <Ubuntu WSL2 Image Tarball path>
wsl --import Ubuntu-23.04-test D:\Software\OS\wsl-distribution\test-base-3 D:\Software\OS\wsl-distribution\ubuntu-lunar-wsl-amd64-wsl.rootfs.tar.gz
wsl -l -v
wsl -d Ubuntu-23.04-test
```
<sub>the environment that it has logged in as the root user instead of a custom user that you set up as part of the "base" environment. The custom user exists, but is not configured as the default. You can either start the environment using:<sub>

<a style="color:Maroon;">sample user: u-2304-wsl-node-01</a>


```bash
# add a new user to system:
NEW_USER=<USERNAME>
# add the user to the sudo group and set password:
useradd -m -G sudo -s /bin/bash "$NEW_USER"
passwd "$NEW_USER"
# switch to default instead of root
tee /etc/wsl.conf <<_EOF
[user]
default=${NEW_USER}
_EOF
```
<sub>log out and log in again<sub>

```powershell
wsl --terminate <Distribution Name>
wsl -d <Distribution Name>
```

</details>


<details>
<summary><b style="color:Maroon;">git</b></summary>


</details>


<details>
<summary><b style="color:Maroon;">other</b></summary>

* **Uninstall / Remove python3 package**
```bash
sudo apt remove python3
sudo apt autoclean && sudo apt autoremove
```
* **Install python3 package**

https://github.com/parafoxia/python-scripts/tree/main

https://vegastack.com/tutorials/how-to-install-python-3-11-on-ubuntu-22-04/

https://phoenixnap.com/kb/how-to-install-python-3-ubuntu
</details>