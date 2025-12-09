## Docker Command Cheat Sheet


### Version

- `docker version`: Outputs the version numbers of Docker.
- `docker --version`: Outputs the version number of the Docker CLI.
- `docker compose version`: Show the Docker Compose version information.

### Container Management

- `docker start <container>`: Start a stopped container.
- `docker stop <container>`: Stop a running container.
- `docker restart <container>`: Restart a running container.
- `docker rm <container>`: Remove a stopped container.
- `docker ps`: List running containers.
- `docker ps -a`: List all containers (including stopped ones).
- `docker image prune`: Clears an unused image.


### Container Build

- `docker build`: Builds an image from a Dockerfile in the current directory
- `docker build https://github.com/docker/rootfs.git#container:docker`: Builds an image from a remote GIT repository
- `docker build -t imagename/tag`: Builds and tags an image for easier tracking
- `docker build https://yourserver/file.tar.gz`: Builds an image from a remote tar archive
- `docker build -t image:1.0<<EOFFROM busyboxRUN echo “hello world”EOF`: Builds an image via a Dockerfile that is passed through STDIN


### Run a new Container

- `docker run -it --rm -d --network NETWORK_NAME -p HOST_PORT:CONTAINER_PORT --hostname HOST_NAME --name CONTAINER_NAME IMAGE`:
    - `-i or --interactive`: Terminal will transfer the input to container 
    - `-t or ---tty`: Allocates a pseudo-TTY (a terminal interface). 
    - `-d or --detach`: Run the container in the background
    - `-p or --publish`: Explicitly map a single port or range of ports in the container to the host.
    - `-P or --publish-all`: Publishes all the exposed ports to the host. Docker binds each exposed port to a random port on the host.
    - `--rm:`: Automatically removes the container when it exits. This ensures that no stopped container is left on the system once stop the container.
    - `--network:`: Add to specific network
    - `HOST_PORT`: The port number on host machine where you want to receive traffic
    - `HOST_NAME`: Custom Hostname of the container
    - `CONTAINER_PORT`: The port number within the container that's listening for connections
    - `NETWORK_NAME`: User define network
    - For example: `docker run -it --rm -d -p 8080:80 --name nginx-reverse-proxy nginx`


### Container Compose

- `docker compose version`: Displays the version of Docker Compose installed.
- `docker compose config`: Validates and displays the composed configuration file.
- `docker compose start`: Starts the services defined in the docker-compose.yml file.
- `docker compose stop`: Stops the running services defined in the docker-compose.yml file.
- `docker compose restart`: Restarts the services defined in the docker-compose.yml file.
- `docker compose run`: Runs a one-time command against a service.
- `docker compose create`: Creates containers for services defined in the docker-compose.yml file, but does not start them.
- `docker compose attach`: Attaches to a running container.
- `docker compose pause`: Pauses services.
- `docker compose unpause`: Unpauses services.
- `docker compose wait`: Blocks until services are ready.
- `docker compose up`: Builds, (re)creates, starts, and attaches to containers for a service.
- `docker compose down`: Stops and removes containers, networks, volumes, and images created by docker compose up.
- `docker compose ps`: Lists containers.
- `docker compose top`: Displays the running processes of a service container.
- `docker compose events`: Streams real-time events from containers.
- `docker compose logs`: Displays log output from services.
- `docker compose images`: Lists images used by services.
- `docker compose build`: Builds or rebuilds services.
- `docker compose push`: Pushes service images to a registry.
- `docker compose cp`: Copies files/folders between a container and the local filesystem.
- `docker compose exec`: Executes a command in a running container.


### Image Management

- `docker pull <image>`: Download an image from a registry.
- `docker build -t <tag> <path>`: Build an image from a Dockerfile.
- `docker push <image>`: Push an image to a registry.
- `docker images`: List downloaded images.
- `docker rmi <image>`: Remove an image.
- `docker save -o <file_name>.tar <image><tag>`: downloads the image as a regular .tar file
- `docker load -i <file_name>.tar`: Load on other server:
- `docker tag <image><tag> <registry-url>/<image><tag>`: Upload/Publish to a registry (GitHub/GitLab/Docker Hub)


### Network Management

- `docker network create <network>`: Create a new network.
- `docker network ls`: List networks.
- `docker network inspect <network>`: Inspect a network.
- `docker network connect <network> <container>`: Connect a container to a network.
- `docker network disconnect <network> <container>`: Disconnect a container from a network.
- `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}} <container>`: Docker container's IP address from the host.

### Volume Management

- `docker volume create <volume>`: Create a new volume.
- `docker volume ls`: List volumes.
- `docker volume inspect <volume>`: Inspect a volume.
- `docker volume rm <volume>`: Remove a volume.
- `docker volume prune`: Remove all unused volumes.

### Other Commands

- `docker exec <container> <command>`: Run a command inside a running container.
- `docker logs <container>`: View the logs of a container.
- `docker inspect <container>`: Inspect a container.
- `docker version`: Show Docker version information.
- `docker system df`: Show docker disk usage.
- `docker system events`: Get real time events from the server.
- `docker system info`: Display system-wide information.
- `docker system prune`: Remove unused data.

### demon management Commands

