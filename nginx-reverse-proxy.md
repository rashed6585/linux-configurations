<summary><b style="color:Maroon;">Reverse proxy with nginx docker</b></summary>

<sub>need to pull docker image of nginx<sub>


```bash
# make directories
mkdir nginx-reverse-proxy
cd nginx-reverse-proxy
```

<sub>Lets Create a Dummy Flask Application<sub>

```bash
# make directories and file
mkdir app_01
touch app.py Dockerfile requirements.txt
```

<sub>Code in `app.py`<sub>

```python
from flask import Flask
import socket

app = Flask(__name__)

@app.route('/')
def index():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return f"<h1>IP Address: {ip_address}</h1><h2>Hostname: {hostname}</h2>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
```

<sub>Lines `requirements.txt`<sub>

```bash
Flask==2.2.2
Werkzeug==2.2.2
```

<sub>Create `Dockerfile`<sub>

```dockerfile
# Use the official Python image based on Alpine
FROM python:3.11-alpine

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY app.py app.py

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["python", "app.py"]
```

<sub>Now time to build the docker image and run the container<sub>

```bash
# go to project directory: app_01
docker build -t dummy_app_server .
# run the container from image appserver
docker run -d -p 8010:8080 --hostname app_server_01 --name appserver_01 dummy_app_server
# run another container from image appserver
docker run -d -p 8020:8080 --hostname app_server_02 --name appserver_02 dummy_app_server 
```