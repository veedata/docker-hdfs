export HADOOP_HOME=/home/hadoop
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export PATH=$PATH:$HADOOP_HOME/bin

service ssh start
chmod +x /home/hadoop/sbin/*
/home/hadoop/sbin/start-dfs.sh


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi