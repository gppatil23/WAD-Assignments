# Docker Container Environment

This project includes Docker configuration for both development and production environments, with support for NVIDIA GPU acceleration.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- For GPU support: [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## Development Environment

To start the development environment:

```bash
docker compose up dev
```

The application will be available at http://localhost:5173

### With GPU Support

To start the development environment with NVIDIA GPU support:

```bash
docker compose up dev-gpu
```

## Production Environment

To build and run the production environment:

```bash
docker compose up prod
```

The application will be available at http://localhost:80

## Building Custom Images

To build a custom Docker image:

```bash
docker build -t my-react-app:tag .
```

For development image:

```bash
docker build -t my-react-app:dev -f Dockerfile.dev .
```

## Running Without Docker Compose

### Development

```bash
docker run -p 5173:5173 -v $(pwd):/app -v /app/node_modules my-react-app:dev
```

### Production

```bash
docker run -p 80:80 my-react-app:tag
```

### With NVIDIA GPU Support

```bash
docker run --gpus all -p 5173:5173 -v $(pwd):/app -v /app/node_modules my-react-app:dev
```

## Environment Variables

You can pass environment variables to your containers:

```bash
docker run -p 5173:5173 -e API_URL=http://api.example.com my-react-app:dev
```

Or through Docker Compose by adding them to the environment section or using a .env file.