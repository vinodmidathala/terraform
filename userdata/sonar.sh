#!/bin/bash
sudo dnf update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER


# Run Jenkins container
docker run -d --name sonar -p 9000:9000  sonarqube:lts