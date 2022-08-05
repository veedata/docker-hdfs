# HDFS (Pseudodistributed mode) on docker
[![Docker Pulls](https://img.shields.io/docker/pulls/veedata/hdfs-pseudodistributed.svg)]()

Hadoop Pseudo Distributed File System. Do not use for production!!

## Specifications
- Base image: Ubuntu 20.04 64 bit
- Java: openjdk-8-jdk
- Hadoop - v3.3.1

## Ports (Exposed)
- HDFS -> 9000
- HDFS namenode http-address -> 9870
- HDFS datanode http-address -> 9864

## Usage
![Demo](/media/Docker-HDFS-Usage.gif)

### quick start
```
docker run -dit -p 9000:9000/tcp -p 9864:9864/tcp -p 9870:9870/tcp veedata/hdfs-pseudodistributed:latest
```
Then browser to [localhost:9870](http://localhost:9870) to see HDFS WebUI

### changing port
eg: changing UI port on host from 9870 to 9800
```
docker run -dit -p 9000:9000/tcp -p 9864:9864/tcp -p 9800:9870/tcp veedata/hdfs-pseudodistributed:latest
```
