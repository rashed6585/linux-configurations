## User creation for non-root

- `sudo apt update`: update the apt
- `cat /etc/passwd`: check user list.
- `cut -d: -f1 /etc/passwd`: check user list in short.

- `cat /etc/group`: check user list.
- `cut -d: -f1 /etc/group`: check user list in short.

- `sudo useradd -m -s /bin/bash -c "islam.rashidul@robi.com.bd;01833182184" appdev`: add user "appdev" with home directory and specify the shell to "bash".
- `sudo passwd appdev`: add user "appdev" password.

- `sudo addgroup limit-power`: create a user group "limit-power" (optional).
- `sudo usermod -aG limit-power appdev`: add "appdev" to group "limit-power".
- `getent group limit-power`: user list added to this group "limit-power".
- `sudo deluser appdev sudo`: Remove appdev from the sudo group.
- `groups appdev`: Verify the removal.

- `sudo nano /etc/sudoers.d/appdev`: Grant limited privileges
    Add the below line in sudoers file (specify the commands to provide)
    ```bash
    appdev ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/ls, /usr/bin/vim.basic, /usr/bin/nano
    
    #if need to remove python 
    appdev ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/ls, /usr/bin/vim.basic, /usr/bin/nano, !/usr/bin/python3
    ```

- `sudo nano /etc/ssh/sshd_config`: Allow group and user section
    ```bash
    AllowUsers appadmin appdev
    AllowGroups appadmin appdev
    ```
- `sudo sshd -t`: Check syntax
- `sudo systemctl restart ssh`: Restart SSH service
- `sudo systemctl restart sshd`: Restart SSHD service (any one)

- `sudo systemctl reload ssh`: safer to reload the configuration
- `sudo systemctl status ssh`: Verify service status


- `sudo usermod -aG docker appdev`: add "appdev" to group "docker".
- `sudo -l -U appdev`: Check sudo permission

- `sudo chown -R appdev:appdev /home/appdev/`: Change the ownership of the directory to "appdev".
- `ls -ld /home/appdev/`: Verify
---

- `sudo chown appdev:appdev /home/log/`: Change the ownership of the directory to "appdev".
- `sudo chmod 700 /home/log/`: have read, write, and execute permissions
- `sudo chmod 755 /home/log/`: have read and execute permissions only

- `sudo -u appdev python3 -m venv /home/appdev/.venv`: Create a virtual environment for "appdev".
- `sudo -u appdev /home/appdev/.venv/bin/pip install --upgrade pip`: Ensure pip is available within the virtual environment.
- `sudo nano -f /etc/sudoers.d/appdev`: Edit the sudoers file to allow appdev to use pip only within the virtual environment.
- `appdev ALL=(ALL) NOPASSWD: /home/appdev/.venv/bin/python3, /home/appdev/.venv/bin/pip`: allow appdev to use Python and pip within the virtual environment.

---

### Delete user

- `id appdev`: Check if the user exists.
- `sudo pkill -u appdev`: Stop any processes owned by the user.
- `sudo deluser --remove-home appdev`: Delete the user and home directory.
- `getent group appadev`: shows all users in the appdev group.
- `sudo groupdel appadev`: Delete the user group (if applicable).
- `sudo visudo -f /etc/sudoers.d/appadev`: Remove from sudoers (if applicable).
    Remove the line:
    ```bash
    appdev ALL=(ALL) NOPASSWD: /usr/bin/docker, /usr/bin/ls, /usr/bin/vim.basic, /usr/bin/nano
    ```
- `sudo -l -U appdev`: Verify
---
### Add ssh

If re-use existing ssh of appadmin 
```bash
sudo mkdir -p /home/appdev/.ssh && sudo cp /home/appadmin/.ssh/authorized_keys /home/appdev/.ssh/authorized_keys
sudo chmod 700 /home/appdev/.ssh
sudo chmod 600 /home/appdev/.ssh/authorized_keys
```
---
### Give permission through ACL (Access Control Lists)

/home/appadmin/code/temp access permit to appdev
```bash
# Allow traversal on parent directories
sudo setfacl -m u:appdev:x /home/appadmin
sudo setfacl -m u:appdev:x /home/appadmin/code

# Give full access to temp directory
sudo setfacl -m u:appdev:rwx /home/appadmin/code/temp
# Give full access to temp directory and all its subfolders/files recursively
sudo setfacl -R -d -m u:appdev:rwx /home/appadmin/code/temp
# Verify ACL
getfacl /home/appadmin/code/temp
# Remove All ACL Entries (Reset to normal permissions)
sudo setfacl -bR /home/appadmin/code/temp

# Create the Symlink
sudo ln -s /home/appadmin/code/temp /home/appdev/temp

# remove link
sudo rm /home/appdev/temp
# Check Before Removing
ls -l /home/appdev/temp

```
<!-- sudo setfacl -m u:appuser:x /home/appadmin
sudo setfacl -m u:appuser:x /home/appadmin/r-flow #no access till this path or V
sudo setfacl -m u:appuser:rwx /home/appadmin/r-flow #can access from this path
sudo setfacl -m u:appuser:rwx /home/appadmin/r-flow/config
sudo setfacl -m u:appuser:rwx /home/appadmin/r-flow/dags
sudo setfacl -m u:appuser:rwx /home/appadmin/r-flow/logs
sudo setfacl -m u:appuser:rwx /home/appadmin/r-flow/docker-compose.yaml -->