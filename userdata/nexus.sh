#!/bin/bash
sudo dnf update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Run Jenkins container
docker run -d --name nexus -p 8081:8081  sonatype/nexus3