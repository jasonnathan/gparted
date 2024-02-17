FROM debian:bullseye-slim

# Install GParted and dependencies
RUN apt-get update && apt-get install -y gparted

# Set up environment variables
ENV DISPLAY=host.docker.internal:0
