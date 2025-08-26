# NDI Discovery Server
This repository contains the files needed to run the NDI Discovery Server as a Docker container, making it portable or executable without installing it on the host OS. The Docker image is created from the official NDI Tools files you download from ndi.video.

## Table of Contents
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Installation](#installation)

## Features
This Docker image only requires two files from the repository:
- The server binary
- The JSON configuration file

All other files come from the original NDI Tools .gz archive and are kept to provide context, allow exploration, read the PDF manual, or use the service files on a host OS.

The NDI Discovery Server supports multiple CPU architectures. The ./bin directory contains a subdirectory for each architecture, each with its corresponding binary.

## Repository Structure

```text
NDI-Discovery-Server-Docker/
├── README.md
├── docker-compose.yml
├── Dockerfile
├── config/
│   └── ndi-discovery-service.v1.json
├── bin/
│   ├── aarch64-newtek-linux-gnu/
│   │   └── ndi-discovery-server
│   ├── aarch64-rpi4-linux-gnueabi/
│   │   └── ndi-discovery-server
│   ├── arm-newtek-linux-gnueabihf/
│   │   └── ndi-discovery-server
│   ├── arm-rpi1-linux-gnueabihf/
│   │   └── ndi-discovery-server
│   ├── arm-rpi2-linux-gnueabihf/
│   │   └── ndi-discovery-server
│   ├── arm-rpi3-linux-gnueabihf/
│   │   └── ndi-discovery-server
│   ├── arm-rpi4-linux-gnueabihf/
│   │   └── ndi-discovery-server
│   ├── i686-linux-gnu/
│   │   └── ndi-discovery-server
│   └── x86_64-linux-gnu/
│       └── ndi-discovery-server
└── Install_NDI_Discovery_Server_v6/
    ├── bin/
    │   ├── aarch64-newtek-linux-gnu/
    │   │   └── ndi-discovery-server
    │   ├── aarch64-rpi4-linux-gnueabi/
    │   │   └── ndi-discovery-server
    │   ├── arm-newtek-linux-gnueabihf/
    │   │   └── ndi-discovery-server
    │   ├── arm-rpi1-linux-gnueabihf/
    │   │   └── ndi-discovery-server
    │   ├── arm-rpi2-linux-gnueabihf/
    │   │   └── ndi-discovery-server
    │   ├── arm-rpi3-linux-gnueabihf/
    │   │   └── ndi-discovery-server
    │   ├── arm-rpi4-linux-gnueabihf/
    │   │   └── ndi-discovery-server
    │   ├── i686-linux-gnu/
    │   │   └── ndi-discovery-server
    │   └── x86_64-linux-gnu/
    │       └── ndi-discovery-server
    ├── licenses/
    │   ├── asio.txt
    │   ├── NDI Discovery Server EULA.txt
    │   ├── rapidjson.txt
    │   └── rapidxml.txt
    ├── services-files/
    │   ├── init.d/
    │   │   └── ndi-discovery
    │   └── systemd/
    │       └── ndi-discovery.service
    ├── Install_NDI_Discovery_Server_v6.gz
    ├── Install_NDI_Discovery_Server_v6.sh
    ├── NDI Discovery Service.pdf
    └── Version.txt
```

## Installation

1. Select the correct binary for your CPU architecture. Edit the Dockerfile and replace the placeholder in the COPY line with the matching folder name from /bin.

```Dockerfile
COPY ./bin/{architecture}/ndi-discovery-server ndi-discovery-server
```

Available folders:
- aarch64-newtek-linux-gnu
- aarch64-rpi4-linux-gnueabi
- arm-newtek-linux-gnueabihf
- arm-rpi1-linux-gnueabihf
- arm-rpi2-linux-gnueabihf
- arm-rpi3-linux-gnueabihf
- arm-rpi4-linux-gnueabihf
- i686-linux-gnu
- x86_64-linux-gnu

Example (x86_64):
```Dockerfile
COPY ./bin/x86_64-linux-gnu/ndi-discovery-server ndi-discovery-server
```
Save the Dockerfile.

2. Adjust the configuration file as needed (defaults allow LAN access):
File: config/ndi-discovery-service.v1.json
```json
{
    "binding": "0.0.0.0",
    "port_no": "5959"
}
```

3. Build and start the container:
```bash
docker-compose up -d --build
```

4. (Optional) Verify it is running:
```bash
docker ps
docker logs ndi-discovery-server
```