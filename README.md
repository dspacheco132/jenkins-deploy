# Jenkins Docker Compose

This project configures a Jenkins service using Docker Compose.

## Usage

### Start Jenkins

```bash
docker compose up -d
```

### Stop Jenkins

```bash
docker compose down
```

### View logs

```bash
docker compose logs -f jenkins
```

### Access Jenkins

After starting the container, access:
- URL: http://localhost:8080
- The initial administrator password can be found at:
  ```bash
  docker compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
  ```

## Configuration

- **Port**: 8080 (web interface) and 50000 (agents)
- **Volume**: Jenkins data is persisted in the `jenkins_home` volume
- **Docker Socket**: Docker socket is mounted to allow Jenkins to execute Docker containers
- **Docker Socket Proxy**: Service that exposes Docker socket via TCP on port 2375 for use with Cloud Services in Jenkins

## Configure Docker Cloud in Jenkins

To use Docker as a Cloud Service in Jenkins:

1. Access Jenkins at http://localhost:8080
2. Go to **Manage Jenkins** → **Manage Nodes and Clouds** → **Configure Clouds**
3. Add a new cloud of type **Docker**
4. Configure:
   - **Docker Host URI**: `tcp://docker-socket-proxy:2375`
   - Or use the container IP:
     ```bash
     docker inspect docker-socket-proxy | grep IPAddress
     ```
     Then use: `tcp://<IP_ADDRESS>:2375`

## Services

- **jenkins**: Main Jenkins service
- **docker-socket-proxy**: TCP proxy for Docker socket, required to create cloud services in Jenkins

## Notes

- Jenkins is configured to restart automatically unless stopped manually
- The `jenkins_home` volume maintains all Jenkins data between restarts
- The `docker-socket-proxy` service allows Jenkins to connect to Docker via TCP to create containers dynamically
