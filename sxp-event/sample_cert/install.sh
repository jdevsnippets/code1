#!/bin/bash
killall -9 java
serverIP=$(hostname -I)
keystorePass=changeit
truststorePass=changeit


echo "Operation started..." 
currentDir=$PWD
if ! [ -d zookeeper-3.3.6  ]; then
	if ! [ -f zookeeper-3.3.6.tar.gz ]; then
		wget http://apache.claz.org/zookeeper/zookeeper-3.3.6/zookeeper-3.3.6.tar.gz
		echo "Charlie reporting: Zookeeper downloaded successfully"
		tar -xvf zookeeper-3.3.6.tar.gz
		echo "Charlie reporting: Zookeeper extracted successfully"
		cp zookeeper-3.3.6/conf/zoo_sample.cfg zookeeper-3.3.6/conf/zoo.cfg
		echo "Charlie reporting: Zookeeper configured successfully"
	fi
fi



# configure kafka
if ! [ -d kafka_2.10-0.10.0.1  ]; then
	if ! [ -f kafka_2.10-0.10.0.1.tgz  ]; then
		wget http://apache.claz.org/kafka/0.10.0.1/kafka_2.10-0.10.0.1.tgz
		echo "Charlie reporting: Kafka 0.10.0.1 downloaded successfully"
		tar -xvf kafka_2.10-0.10.0.1.tgz
		echo "Charlie reporting: Kafka 0.10.0.1 extracted successfully"
		
		cd kafka_2.10-0.10.0.1/config/
		echo "Charlie reporting: Configuring kafka"
		
		sed -i '/advertised.host.name/s/^/#/g' server.properties
		echo "advertised.host.name=$serverIP" >> server.properties
		sed -i '/listeners=/s/^/#/g' server.properties
		echo "listeners=PLAINTEXT://$serverIP:9092,SSL://$serverIP:9093">> server.properties
		sed -i '/advertised.listeners=/s/^/#/g' server.properties
		echo "advertised.listeners=PLAINTEXT://$serverIP:9092,SSL://$serverIP:9093">> server.properties
		
		echo "Current $currentDir"

		echo "## KAFKA SECURITY SETTINGS" >> server.properties
		echo "ssl.keystore.location=$currentDir/kafka.server.keystore.jks" >> server.properties
		echo "ssl.keystore.password=$keystorePass" >> server.properties
		echo "ssl.key.password=$keystorePass" >> server.properties
		echo "ssl.truststore.location=$currentDir/kafka.server.truststore.jks" >> server.properties
		echo "ssl.truststore.password=$truststorePass" >> server.properties
		echo "ssl.enabled.protocols=TLSv1.2,TLSv1.1,TLSv1" >> server.properties
		echo "security.inter.broker.protocol=SSL" >> server.properties
		
		echo "Charlie reporting: KAFKA configured successfully"
		cd ../../
	fi
fi


sh zookeeper-3.3.6/bin/zkServer.sh start
sleep 20
sh kafka_2.10-0.10.0.1/bin/kafka-server-start.sh kafka_2.10-0.10.0.1/config/server.properties &