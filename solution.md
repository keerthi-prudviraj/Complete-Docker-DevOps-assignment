# Docker Assignment – Complete Solution

**Student Name:** Prudviraj Keerthi  
**Docker Hub Username:** prudviraj  
**Project:** Sample Flask Docker Application

---

# Task 1: Introduction and Conceptual Understanding

## Introduction to Docker

Docker is a containerization platform used to package applications together with their dependencies into lightweight, portable, and isolated containers.

Docker is widely used in modern DevOps because it provides consistency between development, testing, and production environments. It also makes application deployment faster and easier and integrates well with CI/CD pipelines and cloud platforms.

## Virtualization vs Containerization

| Virtualization                                | Containerization                    |
|-----------------------------------------------|-------------------------------------|
| Uses Virtual Machines                         | Uses Containers                     |
| Each VM has a complete guest operating system | Containers share the host OS kernel |
| Requires more CPU, memory, and storage        | Requires fewer resources            |
| VM startup is relatively slower               | Containers start very quickly       |
| Provides complete OS-level isolation          | Provides application-level isolation|
| Usually requires larger disk images           | Usually requires smaller images     |

## Why Containerization is Preferred for Microservices

Microservices applications consist of multiple independent services. Docker containers allow each service to be packaged, deployed, and scaled independently.

Example:

                    Application
                        |
          +-------------+-------------+
          |             |             |
          ↓             ↓             ↓
       Service A     Service B     Service C
       Container     Container     Container


Each service can have its own dependencies and can be updated independently.

## Why Containerization is Useful for CI/CD

Containers provide a consistent environment throughout the software development lifecycle.

                    Developer
                        ↓
                    Build
                        ↓
                    Docker Image
                        ↓
                    Automated Tests
                        ↓
                    Docker Registry
                        ↓
                    Deployment


This reduces the "works on my machine" problem and makes automated deployments more reliable.

---

# Task 2: Create a Dockerfile for a Sample Project

## Sample Application

A simple Python Flask application was created.

The application displays:

```text
Hello, Docker! 🚀
```

The Flask application runs inside a Docker container on port 80.

## Dockerfile

```dockerfile
# Use Python 3.12 slim as the base image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY app.py .

# Document that the application uses port 80
EXPOSE 80

# Start the Flask application
CMD ["python", "app.py"]
```

## Build the Docker Image

The image was built using:

```powershell
docker build -t prudviraj/sample-app:latest .
```

The build completed successfully.

## Run the Container

```powershell
docker run -d -p 8080:80 --name sample-app prudviraj/sample-app:latest
```

## Verify the Container

```powershell
docker ps
```

The container was successfully running.

## Check Container Logs

```powershell
docker logs sample-app
```

## The logs showed:

Serving Flask app 'app'
Running on all addresses (0.0.0.0)
Running on http://127.0.0.1:80


The application successfully returned HTTP status `200`.

## Test in Browser

The application was tested using:

http://localhost:8080


## Expected output:

Hello, Docker! 🚀

---

# Task 3: Docker Terminologies and Components

## Docker Image

A Docker image is a read-only template containing the application, runtime, libraries, dependencies, and configuration required to run a container.

Example:

```text
prudviraj/sample-app:v1.0
```

## Docker Container

A container is a running instance of a Docker image.

Example:

```powershell
docker run prudviraj/sample-app:v1.0
```

## Dockerfile

A Dockerfile is a text file containing instructions used to build a Docker image.

Common Dockerfile instructions include:

FROM
WORKDIR
COPY
RUN
EXPOSE
CMD


## Docker Volume

A Docker volume provides persistent storage for containers.

Example:

```powershell
docker volume create my_volume
```

## Docker Network

A Docker network allows containers to communicate with each other.

Example:

```powershell
docker network create my_network
```

## Docker Engine

Docker Engine is the core technology responsible for building and running containers.

## Docker Client

The Docker CLI allows users to communicate with Docker Engine.

Examples:

```powershell
docker build
docker run
docker ps
docker images
```

## Docker Hub

Docker Hub is a container registry used to store and distribute Docker images.

The Docker Hub repository used in this assignment was:

prudviraj/sample-app


## Docker Compose

Docker Compose is used to define and manage multiple containers using a YAML configuration file.

## Docker Scout

Docker Scout is used to analyze Docker images for vulnerabilities, dependencies, policies, and security issues.

## Interaction Between Docker Components

                        Dockerfile
                            ↓
                        Docker Engine
                            ↓
                        Docker Image
                            ↓
                        Docker Container
                            ↓
                        Docker Hub
                            ↓
                        Deployment


Docker Compose can manage multiple containers, while Docker volumes provide persistent storage and Docker networks provide communication between containers.

---

# Task 4: Optimize Docker Image with Multi-Stage Builds

## Multi-Stage Dockerfile

A multi-stage Dockerfile was created to separate dependency installation from the runtime image.

```dockerfile
# Stage 1: Builder
FROM python:3.12-slim AS builder

# Set working directory
WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install dependencies into a separate directory
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# Stage 2: Runtime
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy only installed dependencies
COPY --from=builder /install /usr/local

# Copy application source code
COPY app.py .

# Document application port
EXPOSE 80

# Start Flask application
CMD ["python", "app.py"]
```

## Build Multi-Stage Image

```powershell
docker build -f Dockerfile.multistage -t prudviraj/sample-app:v1.0 .
```

## Image Size Comparison

## The original image was:

Disk Usage: 197 MB
Content Size: 48.2 MB

## The optimized image was:

Disk Usage: 184 MB
Content Size: 44.8 MB


## Comparison

| Image       | Disk Usage | Content Size |
| ----------- | ---------: | -----------: |
| Original    |     197 MB |      48.2 MB |
| Multi-stage |     184 MB |      44.8 MB |
| Reduction   |      13 MB |       3.4 MB |

The multi-stage build reduced disk usage by approximately 6.6%.

## Benefits of Multi-Stage Builds

* Reduces final image size.
* Keeps unnecessary build dependencies out of the runtime image.
* Reduces the potential attack surface.
* Improves deployment efficiency.
* Reduces storage requirements.
* Produces cleaner production images.

The application already used `python:3.12-slim`, so the size reduction was moderate.

---

# Task 5: Manage Image with Docker Hub

## Docker Login

```powershell
docker login
```

## Tag the Image

```powershell
docker tag prudviraj/sample-app:latest prudviraj/sample-app:v1.0
```

## Push Image to Docker Hub

```powershell
docker push prudviraj/sample-app:v1.0
```

The image was successfully pushed to Docker Hub.

## Pull Image

The image can be pulled using:

```powershell
docker pull prudviraj/sample-app:v1.0
```

## Docker Image Tags

The project contains the following image tags:

prudviraj/sample-app:latest
prudviraj/sample-app:v1.0


Docker Hub provides a centralized registry where Docker images can be stored and distributed.

---

# Task 6: Persist Data with Docker Volumes

## Create Docker Volume

```powershell
docker volume create my_volume
```

## Inspect Volume

```powershell
docker volume inspect my_volume
```

The volume was successfully created.

The volume configuration showed:

Name: my_volume
Driver: local
Scope: local


## Run Container Using the Volume

```powershell
docker run -d --name volume-app -v my_volume:/app/data prudviraj/sample-app:v1.0
```

## Inspect Container

```powershell
docker inspect volume-app
```

The inspection confirmed the volume mount:


my_volume:/app/data


The mount was configured as:

Type: volume
Name: my_volume
Destination: /app/data
RW: true


## Importance of Docker Volumes

Containers are designed to be replaceable, so important application data should not depend only on the container's writable filesystem.

Docker volumes store data outside the container's lifecycle.


            Container
                |
                ↓
            /app/data
                |
                ↓
            my_volume
                |
                ↓
            Persistent Data


Volumes are particularly useful for databases and applications that require persistent storage.

---

# Task 7: Configure Docker Networking

## Create Custom Network

```powershell
docker network create my_network
```

The network was successfully created using the bridge driver.

## Verify Network

```powershell
docker network ls
```

The custom network appeared as:

my_network

## Run Sample Application on Network

```powershell
docker run -d --name sample-app-network --network my_network prudviraj/sample-app:v1.0
```

## Run MySQL on Same Network

```powershell
docker run -d --name my-db --network my_network -e MYSQL_ROOT_PASSWORD=root mysql:8.4
```

## Verify Containers

```powershell
docker ps
```

Both containers were successfully running:

sample-app-network
my-db


## Network Architecture

                 my_network
                     |
          +----------+----------+
          |                     |
          ↓                     ↓
 sample-app-network           my-db
      Flask                   MySQL
       :80                    :3306


Containers connected to the same user-defined network can communicate with each other.

## Importance of Docker Networking

Docker networking is important for multi-container applications because services such as web applications, APIs, databases, caches, and message queues need to communicate with each other.

---

# Task 8: Orchestrate with Docker Compose

A `docker-compose.yml` file was created to manage the Flask application and MySQL database.

## docker-compose.yml

```yaml
services:

  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: sample-app-compose
    ports:
      - "8080:80"
    networks:
      - app-network
    volumes:
      - app-data:/app/data
    depends_on:
      - db

  db:
    image: mysql:8.4
    container_name: mysql-compose
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: sampledb
    networks:
      - app-network
    volumes:
      - mysql-data:/var/lib/mysql

networks:
  app-network:

volumes:
  app-data:
  mysql-data:
```

## Start Services

```powershell
docker compose up -d
```

## Verify Services

```powershell
docker compose ps
```

The output confirmed that both services were running:

```text
mysql-compose
sample-app-compose
```

The application was exposed using:

```text
0.0.0.0:8080 -> 80
```

## Check Logs

```powershell
docker compose logs


The Flask logs showed successful HTTP requests:


"GET / HTTP/1.1" 200


The MySQL logs showed:


Creating database sampledb


and:

ready for connections
port: 3306


## Test Application

The application was tested at:


http://localhost:8080


The application displayed:

Hello, Docker! 🚀

## Stop Services

```powershell
docker compose down
```

## Compose Architecture

                 Docker Compose
                       |
                app-network
                  /         \
                 /           \
                ↓             ↓
      sample-app-compose   mysql-compose
            Flask             MySQL
             :80              :3306
                \             /
                 \           /
                   Volumes
```

Docker Compose simplifies the management of multi-container applications because services, networks, volumes, ports, and environment variables can be defined in one file.

---

# Task 9: Analyze Image with Docker Scout

Docker Scout was used to analyze the Docker image:

```text
prudviraj/sample-app:v1.0
```

The image contained:

```text
134 packages
```

Docker Scout detected:

```text
49 vulnerabilities
13 vulnerable packages
```

## Vulnerability Summary

| Severity    | Number |
| ----------- | -----: |
| Critical    |      2 |
| High        |      2 |
| Medium      |      9 |
| Low         |     31 |
| Unspecified |      5 |
| Total       |     49 |

## Critical Vulnerabilities

The following Critical vulnerabilities were identified in the Perl package:

```text
CVE-2026-13221
CVE-2026-12087
```

Docker Scout reported that fixed versions were not available for these vulnerabilities at the time of scanning.

## High Vulnerabilities

The following High vulnerabilities were identified:

```text
CVE-2026-48959
CVE-2026-48962
```

These vulnerabilities were associated with the Perl package.

## Other Affected Packages

Docker Scout reported vulnerabilities in packages including:


perl
pip
glibc
util-linux
tar
coreutils
systemd
sqlite3
diffutils
openssl
Flask
shadow
apt


## Example Fixable Vulnerability

The Flask package was version:

3.1.2


Docker Scout identified:

CVE-2026-27205


with a fixed version:


3.1.3


The pip package also contained vulnerabilities for which newer versions were available.

## Base Image Analysis

The current base image was:

python:3.12-slim


Docker Scout identified:


python:3.13-slim


as an updated base image recommendation.

The updated base image showed fewer Medium and Low vulnerabilities in the comparison.

## Docker Scout Policy Results

Docker Scout reported policy issues related to:

* Running the image as the root user.
* Copyleft-licensed packages.
* Missing supply-chain attestations.

The policy related to having no fixable Critical or High vulnerabilities passed.

## Security Recommendations

Based on the Docker Scout analysis:

1. Keep the Python base image updated.
2. Upgrade vulnerable Python dependencies.
3. Use minimal base images.
4. Avoid running applications as root.
5. Regularly scan Docker images.
6. Rebuild images after security updates.
7. Add supply-chain provenance and attestations.
8. Review vulnerabilities inherited from the base image.
9. Keep application dependencies up to date.

## Docker Scout Commands

The following commands were used:

```powershell
docker scout version
```

```powershell
docker scout quickview prudviraj/sample-app:v1.0
```

```powershell
docker scout cves prudviraj/sample-app:v1.0
```

The report was also saved using:

```powershell
docker scout cves prudviraj/sample-app:v1.0 > scout_report.txt
```

---

# Task 10: Documentation and Critical Reflection

## Complete List of Commands Used

### Build Image

```powershell
docker build -t prudviraj/sample-app:latest .
```

### Run Container

```powershell
docker run -d -p 8080:80 --name sample-app prudviraj/sample-app:latest
```

### List Containers

```powershell
docker ps
```

### View Logs

```powershell
docker logs sample-app
```

### List Images

```powershell
docker images
```

### Multi-Stage Build

```powershell
docker build -f Dockerfile.multistage -t prudviraj/sample-app:v1.0 .
```

### Docker Login

```powershell
docker login
```

### Tag Image

```powershell
docker tag prudviraj/sample-app:latest prudviraj/sample-app:v1.0
```

### Push Image

```powershell
docker push prudviraj/sample-app:v1.0
```

### Pull Image

```powershell
docker pull prudviraj/sample-app:v1.0
```

### Create Volume

```powershell
docker volume create my_volume
```

### List Volumes

```powershell
docker volume ls
```

### Inspect Volume

```powershell
docker volume inspect my_volume
```

### Run Container With Volume

```powershell
docker run -d --name volume-app -v my_volume:/app/data prudviraj/sample-app:v1.0
```

### Inspect Container

```powershell
docker inspect volume-app
```

### Create Network

```powershell
docker network create my_network
```

### List Networks

```powershell
docker network ls
```

### Run Application on Network

```powershell
docker run -d --name sample-app-network --network my_network prudviraj/sample-app:v1.0
```

### Run MySQL on Network

```powershell
docker run -d --name my-db --network my_network -e MYSQL_ROOT_PASSWORD=root mysql:8.4
```

### Docker Compose

```powershell
docker compose up -d
```

```powershell
docker compose ps
```

```powershell
docker compose logs
```

```powershell
docker compose down
```

### Docker Scout

```powershell
docker scout version
```

```powershell
docker scout quickview prudviraj/sample-app:v1.0
```

```powershell
docker scout cves prudviraj/sample-app:v1.0
```

```powershell
docker scout cves prudviraj/sample-app:v1.0 > scout_report.txt
```

---

# Image Optimization Results

The original image had:

Disk Usage: 197 MB
Content Size: 48.2 MB
```

The optimized image had:

Disk Usage: 184 MB
Content Size: 44.8 MB
```

Therefore:

Disk Usage Reduction = 13 MB
Content Size Reduction = 3.4 MB
```

The multi-stage build helped remove unnecessary build-related content from the final runtime image.

---

# Critical Reflection on Docker

Docker is an important technology in modern software development and DevOps because it provides a consistent and portable environment for building, testing, and deploying applications.

One of Docker's major benefits is portability. An application packaged into a Docker image can run consistently across development machines, testing environments, servers, and cloud platforms.

Docker also supports microservices architecture by allowing individual services to run in separate containers. Each service can be developed, deployed, scaled, and updated independently.

Docker integrates well with CI/CD pipelines. A Docker image can be automatically built, tested, scanned, stored in a container registry, and deployed.

Docker Compose makes it easier to manage multi-container applications by defining services, networks, and volumes in a single YAML file.

However, Docker also introduces challenges. Docker images may contain security vulnerabilities, as demonstrated by the Docker Scout analysis. Images therefore need to be regularly scanned and updated.

Other challenges include:

* Container networking.
* Persistent storage.
* Secrets management.
* Security configuration.
* Image size optimization.
* Monitoring and logging.
* Dependency management.

The Docker Scout analysis demonstrated that image size is not the only consideration when building containers. Security, dependency management, minimal base images, and least-privilege execution are also important.

Overall, Docker provides significant benefits for modern DevOps by improving portability, consistency, deployment speed, scalability, and automation.


# Final Conclusion

This assignment provided practical experience with the complete Docker workflow.

                            Application
                                ↓
                            Dockerfile
                                ↓
                            Docker Image
                                ↓
                            Docker Container
                                ↓
                            Docker Hub
                                ↓
                            Docker Volume
                                ↓
                            Docker Network
                                ↓
                            Docker Compose
                                ↓
                            Docker Scout
                                ↓
                            Security & Optimization


The project successfully demonstrated:

* Docker fundamentals.
* Dockerfile creation.
* Image building.
* Container execution.
* Image optimization using multi-stage builds.
* Docker Hub image management.
* Persistent storage using Docker volumes.
* Container networking.
* Multi-container orchestration using Docker Compose.
* Docker Scout vulnerability analysis.
* Docker security and optimization practices.

Docker provides a strong foundation for modern DevOps and CI/CD workflows by making applications portable, reproducible, scalable, and easier to deploy.