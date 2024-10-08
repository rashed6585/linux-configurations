### user creation for non-root

- `cat /etc/passwd`: check user list.
- `cut -d: -f1 /etc/passwd`: check user list in short.

- `cat /etc/group`: check user list.
- `cut -d: -f1 /etc/group`: check user list in short.

- `sudo useradd -m appuser`: add user "appuser" with home directory .
- `sudo passwd appuser`: add user "appuser" password.

- `sudo addgroup limit-power`: create a user group "limit-power".
- `sudo usermod -aG limit-power appuser`: add "appuser" to group "limit-power".
- `getent group limit-power`: user list added to this group "limit-power".
- `sudo deluser appuser sudo`: Remove appuser from the sudo group.
- `groups appuser`: Verify the removal.

- `sudo visudo -f /etc/sudoers.d/appuser`: Grant limited privileges
- `appuser ALL=(ALL) NOPASSWD: /usr/bin/apt update, /usr/bin/docker, /usr/bin/vim, /usr/bin/vi, /usr/bin/nano, /bin/cat`: only this can allow.
- `sudo usermod -aG docker appuser`: add "appuser" to group "docker".


- `sudo chown appuser:appuser /home/log/`: Change the ownership of the directory to "appuser".
- `sudo chmod 700 /home/log/`: have read, write, and execute permissions
- `sudo chmod 755 /home/log/`: have read and execute permissions only

- `sudo -u appuser python3 -m venv /home/appuser/.venv`: Create a virtual environment for "appuser".
- `sudo -u appuser /home/appuser/.venv/bin/pip install --upgrade pip`: Ensure pip is available within the virtual environment.
- `sudo visudo -f /etc/sudoers.d/appuser`: Edit the sudoers file to allow appuser to use pip only within the virtual environment.
- `appuser ALL=(ALL) NOPASSWD: /home/appuser/.venv/bin/python3, /home/appuser/.venv/bin/pip`: allow appuser to use Python and pip within the virtual environment.