# gparted-mac-arm64

This Docker repository was an experimental setup to run GParted on macOS ARM64 (M1) with an X11 server. While the Docker container allows GParted to run with a GUI, I encountered challenges with mounting macOS disks directly. Accessing raw macOS disks within Docker is difficult due to Docker's virtualisation on macOS, which limits direct access to local devices. Below are some alternative workarounds and setup steps to run GParted in a container, but note that mounting and managing the actual disk is restricted.

## Description

GParted is a partition editor for managing disk partitions. This setup aims to run GParted within a container on macOS ARM64 (M1) with XQuartz for GUI display.

## Prerequisites

- Docker Desktop for Mac with ARM64 support.
- macOS M1 (Apple Silicon) or compatible hardware.
- [XQuartz](https://www.xquartz.org/) for X11 display support.

### Install XQuartz
To display the GParted GUI, install and start XQuartz on your macOS:

```
brew install --cask xquartz
open -a XQuartz
```

Next, configure your environment to allow Docker to connect to the XQuartz display.

```
export DISPLAY=:0
xhost + 127.0.0.1
```

### Build and Run the Docker Image

1. **Build the Image Locally**:  
   Since the Docker Hub image was removed, you’ll need to build it yourself. Clone this repository, navigate to the directory, and build:

   ```
   docker build -t gparted-mac-arm64 .
   ```

2. **Run GParted in Docker**:  
   Attempt to run GParted in a container with disk access:

   ```
   diskutil list
   ```

   This command lists all available disks and partitions on macOS. Take note of the specific disk (e.g., `/dev/disk2`) you wish to mount in the container.

   ```
   docker run -it --rm --privileged \
     -e DISPLAY=host.docker.internal:0 \
     -v /tmp/.X11-unix:/tmp/.X11-unix \
     --device /dev/disk2 \
     gparted-mac-arm64
   ```

   While this command runs GParted in the container and attempts to provide access to the specified disk, **it does not work** on macOS due to Docker’s virtualisation constraints. Docker on macOS lacks direct access to raw disks, so GParted does not display or interact with the mounted disk as expected.

## Limitations and Workarounds

Since Docker Desktop for Mac doesn’t allow raw disk access like on Linux, mounting and managing macOS disks directly through Docker isn’t feasible. However, here are a few alternative approaches:

1. **Disk Image Workaround**: Create a virtual disk image and mount it as a device.
   
   ```
   hdiutil create -size 10g -fs HFS+ -volname MyDisk ~/Desktop/mydisk.dmg
   hdiutil attach ~/Desktop/mydisk.dmg
   ```

   This will create a virtual disk accessible as a mounted device, which you can add to the Docker container with `--device`.

2. **Using GParted Live on a Virtual Machine**: Running GParted Live in a Linux VM provides full access to hardware disks on macOS. Tools like VirtualBox or Parallels let you mount raw disks into a VM, making it easier to modify partitions safely and directly.

These workarounds allow some interaction with virtualized disks but don’t enable full access to macOS raw disks in Docker. Use a VM for complete disk access if required.
