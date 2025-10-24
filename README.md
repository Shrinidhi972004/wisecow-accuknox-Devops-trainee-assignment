# Wisecow Application

A containerized web application that serves random fortune cookies with ASCII art cows using the classic `cowsay` and `fortune` commands.

## Features

- Serves random fortune quotes with cowsay ASCII art
- Lightweight containerized deployment
- Kubernetes-ready with deployment and service manifests
- Health checks and resource limits configured
- Docker image published to Docker Hub

## Quick Start

### Local Development

Prerequisites for local development:
```bash
sudo apt install fortune-mod cowsay netcat -y
```

Run the application directly:
```bash
./wisecow.sh
```

The application will start on port 4499. Point your browser to `http://localhost:4499`

### Docker Deployment

Pull and run the pre-built image:
```bash
docker run -p 4499:4499 shrinidhiupadhyaya/wisecow:latest
```

Or build locally:
```bash
docker build -t wisecow .
docker run -p 4499:4499 wisecow
```

### Kubernetes Deployment

Deploy to Kubernetes cluster:
```bash
kubectl create namespace wisecow
kubectl apply -f k8s/wisecow-deployment.yaml
kubectl apply -f k8s/wisecow-service.yaml
```

Forward the service port to access locally:
```bash
kubectl port-forward svc/wisecow-service 4499:80 -n wisecow
```

Access at `http://localhost:4499`

## Project Structure

```
.
├── Dockerfile                   # Multi-stage container definition
├── wisecow.sh                   # Main application script
├── k8s/
│   ├── wisecow-deployment.yaml  # Kubernetes deployment manifest
│   └── wisecow-service.yaml     # Kubernetes service manifest
├── LICENSE                      # License file
└── README.md                    # Documentation
```

## Docker Image

The application uses a multi-stage Dockerfile based on Debian Slim featuring:
- Required packages: `fortune-mod`, `fortunes`, `cowsay`, `netcat-openbsd`
- Minimal security footprint with non-root user
- Optimized for container environments
- Published image: `shrinidhiupadhyaya/wisecow:latest`

## Kubernetes Configuration

### Deployment Features
- **Replicas**: 2 for high availability
- **Resources**: 100m CPU, 128Mi memory limits
- **Health Checks**: Liveness and readiness probes
- **Namespace**: wisecow
- **Image**: shrinidhiupadhyaya/wisecow:latest

### Service Configuration
- **Type**: ClusterIP
- **Port**: 80 (external) → 4499 (container)
- **Selector**: app=wisecow

## What to Expect

![wisecow](https://github.com/nyrahul/wisecow/assets/9133227/8d6bfde3-4a5a-480e-8d55-3fef60300d98)

The application displays random fortune quotes with ASCII cow art, refreshing with each request.

## Health Monitoring

The application includes comprehensive health checks:
- **Liveness Probe**: HTTP GET on `/` every 30 seconds (15s initial delay)
- **Readiness Probe**: HTTP GET on `/` every 10 seconds (5s initial delay)

## Development

### Building the Image
```bash
docker build -t shrinidhiupadhyaya/wisecow:latest .
docker push shrinidhiupadhyaya/wisecow:latest
```

### Kubernetes Commands
```bash
# Check deployment status
kubectl get pods -n wisecow

# View logs
kubectl logs -n wisecow deployment/wisecow-deployment

# Check service
kubectl get svc -n wisecow
```

## Problem Statement

Deploy the wisecow application as a Kubernetes application with the following requirements:

### Requirements
1. ✅ Create Dockerfile for the image and corresponding k8s manifest to deploy in k8s env
2. ✅ The wisecow service should be exposed as k8s service
3. 🔄 Github action for creating new image when changes are made to this repo
4. 🔄 [Challenge goal]: Enable secure TLS communication for the wisecow app

### Expected Artifacts
1. ✅ Github repo containing the app with corresponding dockerfile, k8s manifest
2. 🔄 Github repo with corresponding github action
3. ✅ Github repo access enabled for specified IDs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker and Kubernetes
5. Submit a pull request

## License

See LICENSE file for details.
