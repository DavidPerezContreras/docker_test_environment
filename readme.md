# 🧪 Test Environment Setup with Docker

This project uses Docker to create lightweight, customizable desktop environments based on Debian Trixie with XFCE and XRDP. It’s ideal for testing, development, or remote desktop access.

---

## 📁 Script: `new_test_environment.sh`

This script creates a new container from the prebuilt image `debian-trixie-xfce-xrdp`.

### ✅ Usage

./new_test_environment.sh <container_name> [host_port]

- `container_name`: Unique name for your new test container
- `host_port` (optional): Port to expose XRDP (default is `3389`)

### 🧪 Example

./new_test_environment.sh trixie-dev1 3390

This creates a container named `trixie-dev1` and maps its XRDP port to `localhost:3390`.

---

## 🖥️ Connect via RDP

Use GNOME Connections or any RDP client:

- Address: `localhost:<host_port>`
- Username: `docker`
- Password: `docker` (change after login)

---

## 🛠 Docker Management Commands

### 🔍 List Containers

docker ps            # Running containers  
docker ps -a         # All containers (including stopped)

### 🚀 Start/Stop Containers

docker start <name>  # Start a stopped container  
docker stop <name>   # Gracefully stop a running container  
docker kill <name>   # Force-stop a container

### 🧹 Remove Containers

docker rm <name>     # Remove a stopped container  
docker rm -f <name>  # Force-remove a running container

### 📦 List Images

docker images

---

## 📂 Docker Volume Management

### 📋 List Volumes

docker volume ls

### 🔍 Inspect a Volume

docker volume inspect <volume_name>

### ➕ Create a Volume

docker volume create <volume_name>

### 🧹 Remove a Volume

docker volume rm <volume_name>         # Only if not in use  
docker volume prune                    # Remove all unused volumes

### 📦 Use a Volume in a Container

docker run -v <volume_name>:/path/in/container ...

### 📁 Bind a Host Directory

docker run -v /host/path:/container/path ...

---

## 🧼 Clean Up Disk Space

docker system df                      # Show disk usage  
docker system prune                   # Remove unused containers/images  
docker system prune -a                # Remove all unused images  
docker system prune --volumes         # Include unused volumes

---

## 🧠 Tips

- You can run multiple containers from the same image with different ports.  
- Use volumes to persist data across container restarts.  
- Use `docker exec -it <name> bash` to open a shell inside any running container.  
- Named volumes are managed by Docker and are ideal for persistent, portable data.  
- Bind mounts are great for sharing local folders with containers during development.
