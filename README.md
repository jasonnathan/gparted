# gparted-mac-arm64

This Docker repository contains a Docker image for running GParted on macOS ARM64 architecture (M1).

## Description

GParted is a partition editor for graphically managing disk partitions. This Docker image allows you to run GParted within a container on macOS ARM64 architecture.

## Usage

### Prerequisites

- Docker Desktop for Mac with support for ARM64 architecture.
- macOS M1 (Apple Silicon) or compatible hardware.

### Pull the Docker Image

To pull the Docker image from Docker Hub, run:

```bash
docker pull jasonnathan/gparted-mac:arm64
```

### Run GParted in a Docker Container
To run GParted in a Docker container, use the following command:

```bash
docker run -it --rm --privileged -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix jasonnathan/gparted-mac:arm64
```
This will open GParted in a graphical window on your macOS desktop.

