FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget git build-essential

WORKDIR /home

RUN \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y openssh-server && \
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    chmod 0600 ~/.ssh/authorized_keys && \
    /etc/init.d/ssh start && \
    ssh-keyscan localhost >> ~/.ssh/known_hosts

RUN \
    wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz -O hadoop.tar.gz && \
    mkdir hadoop && \
    tar -xvzf hadoop.tar.gz -C hadoop && \
    mv ./hadoop/hadoop-3.3.1/* ./hadoop/ && \
    rm hadoop.tar.gz

COPY src/hadoop-env.sh /home/hadoop/etc/hadoop/hadoop-env.sh
COPY src/hdfs-site.xml /home/hadoop/etc/hadoop/hdfs-site.xml
COPY src/core-site.xml /home/hadoop/etc/hadoop/core-site.xml
COPY src/start-dfs.sh /home/hadoop/sbin/start-dfs.sh
COPY src/stop-dfs.sh /home/hadoop/sbin/stop-dfs.sh
COPY src/startup.sh /home/startup.sh

EXPOSE 9000
EXPOSE 9870
EXPOSE 9864

RUN \
    export HADOOP_HOME=/home/hadoop && \
    export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 && \
    export PATH=$PATH:$HADOOP_HOME/bin && \
    service ssh start && \
    chmod +x /home/hadoop/sbin/* && \
    chmod +x /home/startup.sh && \
    hdfs namenode -format && \
    rm -rf /var/lib/apt/lists/*

CMD /bin/bash -c '/home/startup.sh -d'
