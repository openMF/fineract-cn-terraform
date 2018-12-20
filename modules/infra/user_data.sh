#!/bin/bash

# Java
yum install java-1.8.0-openjdk-devel.x86_64 -y

# Cassandra installation
# https://cassandra.apache.org/download/
bash -c 'cat << EOF > /etc/yum.repos.d/cassandra.repo
[cassandra]
name=Apache Cassandra
baseurl=https://www.apache.org/dist/cassandra/redhat/311x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.apache.org/dist/cassandra/KEYS
EOF'
yum install cassandra -y

# Cassandra configuration
# https://cassandra.apache.org/doc/latest/getting_started/configuring.html
sed -i /etc/cassandra/default.conf/cassandra.yaml -e '/^cluster_name:/ s/Test Cluster/datacenter1/g'
IP=$(hostname -I)
sed -i /etc/cassandra/default.conf/cassandra.yaml -e "/seeds:/ s/127.0.0.1/$IP/g"
sed -i /etc/cassandra/default.conf/cassandra.yaml -e 's|^listen_address: localhost|# listen_address: localhost|g'
sed -i /etc/cassandra/default.conf/cassandra.yaml -e 's|^# listen_interface: eth1|listen_interface: eth0|g'
sed -i /etc/cassandra/default.conf/cassandra.yaml -e 's|^rpc_address: localhost|# rpc_address: localhost|g'
sed -i /etc/cassandra/default.conf/cassandra.yaml -e 's|^# rpc_interface: eth1|rpc_interface: eth0|g'

# storage_port: 7000
# CQL native transport: 9042
systemctl enable cassandra.service

# Cassandra start
systemctl start cassandra.service


# Install as ec2-user from now on
cd /home/ec2-user

# Kafka+Zookeeper download and unpack
# https://kafka.apache.org/quickstart
wget https://www-eu.apache.org/dist/kafka/2.1.0/kafka_2.12-2.1.0.tgz
tar xzf kafka_2.12-2.1.0.tgz

# Kafka+Zookeeper configuration
# https://www.digitalocean.com/community/tutorials/how-to-install-apache-kafka-on-centos-7#step-4-%E2%80%94-creating-systemd-unit-files-and-starting-the-kafka-server
# Zookeeper systemd unit
bash -c 'cat << EOF > /etc/systemd/system/zookeeper.service
[Unit]
Requires=network.target remote-fs.target
After=network.target remote-fs.target

[Service]
Type=simple
User=ec2-user
ExecStart=/home/ec2-user/kafka_2.12-2.1.0/bin/zookeeper-server-start.sh /home/ec2-user/kafka_2.12-2.1.0/config/zookeeper.properties
ExecStop=/home/ec2-user/kafka_2.12-2.1.0/bin/zookeeper-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
EOF'

# Kafka systemd unit
bash -c 'cat << EOF > /etc/systemd/system/kafka.service
[Unit]
Requires=zookeeper.service
After=zookeeper.service

[Service]
Type=simple
User=ec2-user
ExecStart=/bin/sh -c "/home/ec2-user/kafka_2.12-2.1.0/bin/kafka-server-start.sh /home/ec2-user/kafka_2.12-2.1.0/config/server.properties > /home/ec2-user/kafka_2.12-2.1.0/kafka.log 2>&1"
ExecStop=/home/ec2-user/kafka_2.12-2.1.0/bin/kafka-server-stop.sh
Restart=on-abnormal

[Install]
WantedBy=multi-user.target
EOF'
systemctl enable kafka.service
chown ec2-user:ec2-user /home/ec2-user -R

# Kafka start
systemctl start kafka.service


# Eureka prerequisites
#yum install tomcat -y

# Eureka download
#wget https://search.maven.org/remotecontent?filepath=com/netflix/eureka/eureka-server/1.9.8/eureka-server-1.9.8.war -O eureka-server-1.9.8.war

# Eureka configuration
# https://github.com/Netflix/eureka/tree/master/eureka-examples
# https://github.com/Netflix/eureka/wiki/Configuring-Eureka
#cp eureka-server-1.9.8.war /var/lib/tomcat/webapps/eureka.war
#bash -c 'cat << EOF >> /etc/tomcat/conf.d/eureka.conf
#JAVA_OPTS=" \
#  -Deureka.environment=poc \
#  -Deureka.name=poc \
#  -Deureka.waitTimeInMsWhenSyncEmpty=0 \
#  -Deureka.numberRegistrySyncRetries=0"
#EOF'
#systemctl enable tomcat.service
#chown ec2-user:ec2-user /home/ec2-user -R

# Eureka, ehh... Tomcat start
#systemctl start tomcat.service
