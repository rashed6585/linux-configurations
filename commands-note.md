<center> <h2 style="color:Maroon;">Tips and Tricks</h2> </center>


<!-- <details> -->
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
wsl -l -v
```
<sub>Install Windows Subsystem for Linux (WSL) Distribution using Command<sub>

```powershell
wsl --list --online
# install distribution
wsl --install -d <distroName>
# uninstall distribution with below command and remove from app
wsl --unregister <distroName>
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

https://cloud-images.ubuntu.com/releases/22.04/release-20231211/

<sub>Must use powershell and following command to download the Ubuntu WSL tarball<sub> 

```powershell
# cd to download location
curl (("https://cloud-images.ubuntu.com",
"releases/22.04/release-20231130",
"ubuntu-22.04-server-cloudimg-amd64-root.tar.xz") -join "/") `
--output ubuntu-22.04-wsl-root-tar.xz
# wsl --import <Distribution Name> <Installation Folder> <Ubuntu WSL2 Image Tarball path>
wsl --import Ubuntu-test-base-3 D:\Software\OS\wsl-distribution\test-base-3 D:\Software\OS\wsl-distribution\ubuntu-22.04-wsl-root-tar.gz
wsl -l -v

```
<sub>or other version<sub>
```powershell
# cd to download location
curl (("https://cloud-images.ubuntu.com",
"releases/23.04/release-20231129",
"ubuntu-23.04-server-cloudimg-amd64-root.tar.xz") -join "/") `
--output ubuntu-23.04-wsl-root-tar.xz
# wsl --import <Distribution Name> <Installation Folder> <Ubuntu WSL2 Image Tarball path>
wsl --import Ubuntu-23.04 D:\Software\OS\wsl-distribution\test-base-3 D:\Software\OS\wsl-distribution\ubuntu-23.04-wsl-root-tar.gz
wsl -l -v
```
<!-- </details> -->


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