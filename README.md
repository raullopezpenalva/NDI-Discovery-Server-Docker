# NDI Discovery Server
This repository contains the files needed to run the NDI Discovery Server as a Docker container, making it portable or executable without installing it on the host OS. The Docker image is created from the official NDI Tools files you download from ndi.video.

## Table of Contents
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Installation](#installation)

## Features

The docker only uses 2 files from the repository:

    - The binary file with the code of the server
    - The JSON configuration file

All others files are from the original .gz file from NDI Tools. I decided to leave them in the repository for add more context for the code or if someone wants explore the code, read the manual (pdf), or use it like service in the OS.

NDI has design the code to run it in differents CPU architectures, so in `./bin` folder you can find all the architectures. Every folder has the binary file for the specific architecture.

## Repository Structure

NDI-Discovery-Server-Docker/
    README.md
    docker-compose.yml
    Dockerfile
    config/
        ndi-discovery-service.v1.json
    bin/
        aarch64-newtek-linux-gnu/
            ndi-discovery-server
        aarch64-rpi4-linux-gnueabi/
            ndi-discovery-server
        arm-newtek-linux-gnueabihf/
            ndi-discovery-server
        arm-rpi1-linux-gnueabihf/
            ndi-discovery-server
        arm-rpi2-linux-gnueabihf/
            ndi-discovery-server
        arm-rpi3-linux-gnueabihf/
            ndi-discovery-server
        arm-rpi4-linux-gnueabihf/
            ndi-discovery-server
        i686-linux-gnu/
            ndi-discovery-server
        x86_64-linux-gnu
            ndi-discovery-server
    Install_NDI_Discovery_Server_v6/ #Extracted file from NDI Tools Installer
        bin/
            aarch64-newtek-linux-gnu/
                ndi-discovery-server
            aarch64-rpi4-linux-gnueabi/
                ndi-discovery-server
            arm-newtek-linux-gnueabihf/
                ndi-discovery-server
            arm-rpi1-linux-gnueabihf/
                ndi-discovery-server
            arm-rpi2-linux-gnueabihf/
                ndi-discovery-server
            arm-rpi3-linux-gnueabihf/
                ndi-discovery-server
            arm-rpi4-linux-gnueabihf/
                ndi-discovery-server
            i686-linux-gnu/
                ndi-discovery-server
            x86_64-linux-gnu
                ndi-discovery-server
        licenses/
            asio.txt
            NDI Discovery Server EULA.txt
            rapidjson.txt
            rapidxml.txt
        services-files/
            init.d/
                ndi-discovery
            systemd/
                ndi-discovery.service
        Install_NDI_Discovery_Server_v6.gz
        Install_NDI_Discovery_Server_v6.sh
        NDI Discovery Service.pdf
        Version.txt

## Installation

1. Before start the docker container you have to selectar correct binary for your architecture. To do that, you have to change the path of what binary copy the Dockerfile to the container

```Dockerfile
COPY ./bin/{your-architecture-folder}/ndi-discovery-server ndi-discovery-server
````
Modify {your-architecture-folder} with the correct one inside the `/bin` folder.

Save the file.

2. Modify your config file as you need it, by default is set up for listening from anyone from the LAN.

```json
{
  "binding": "0.0.0.0",
  "port_no": "5959"
}
````
3. Run the docker

```bash
docker-compose up -d --build
````


