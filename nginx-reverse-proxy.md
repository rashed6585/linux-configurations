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
mkdir app
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
# go to project directory: app
docker build -t dummy_app_server .
# create a custom bridge network
docker network create -d bridge custom-bridge-net
# run the container from image appserver (it also not required to expose the port to docker host)
docker run -d -p 8010:8080 --network custom-bridge-net --hostname app_server_01 --name appserver_01 dummy_app_server
docker run -d --restart unless-stopped appserver_01
# run another container from image appserver
docker run -d -p 8020:8080 --network custom-bridge-net --hostname app_server_02 --name appserver_02 dummy_app_server
docker run -d --restart unless-stopped appserver_02 
```

<sub>pull nginx container and run<sub>


```bash
# download latest image 
docker pull nginx 
# create container and expose
sudo docker run -d --network custom-bridge-net --name nginx-base -p 80:80 nginx
docker run -d --restart unless-stopped nginx-base
# copy config file to local
sudo docker cp nginx-base:/etc/nginx/conf.d/default.conf /default.conf
# after modify cp to configuration location
sudo docker cp default.conf nginx-base:/etc/nginx/conf.d/
# validate and reload the Docker Nginx reverse proxy configuration
sudo docker exec nginx-base nginx -t
sudo docker exec nginx-base nginx -s reload
```


<sub>Create `Dockerfile` in nginx-reverse-proxy dir<sub>

```dockerfile
# Use the official Nginx image
FROM nginx:latest

# Copy the Nginx configuration file into the container
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 8080
EXPOSE 8080

server {
    listen 8080;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html index.htm;
    }

    location /app_01 {
        proxy_pass http://172.17.0.3:8010;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /app_02 {
        proxy_pass http://172.17.0.4:8020;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```