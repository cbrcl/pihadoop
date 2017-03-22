## 1. Creacion de usuario y grupo hadoop
>ver config/02-raspberry-hadoop-user.sh


## 2. Linkear otros equipos con nombres cortos
Agregar IP
```
sudo cp /etc/hosts /etc/hosts.backup
sudo nano /etc/hosts
```
Asi es como deberia quedar
```
127.0.0.1       localhost
::1             localhost ip6-localhost ip6-loopback
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters

127.0.1.1     hdmaster
192.168.0.200   hdmaster
192.168.0.201   hdnode1
192.168.0.202   hdnode2
```

https://tekmarathon.com/2017/02/15/hadoop-and-spark-installation-on-raspberry-pi-3-cluster-part-2/

```
cd ~
wget http://apache.osuosl.org/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
sudo tar -xvzf hadoop-2.7.3.tar.gz -C /opt/
cd /opt
sudo chown -R hduser:hadoop hadoop-2.7.3/
sudo nano /opt/hadoop-2.7.3/etc/hadoop/hadoop-env.sh
export JAVA_HOME=/usr/lib/jvm/jdk-7-oracle-arm-vfp-hflt/jre
```

```
sudo nano ~/.bashrc


export JAVA_HOME=/usr/lib/jvm/jdk-7-oracle-arm-vfp-hflt/jre
export HADOOP_HOME=/opt/hadoop-2.7.3
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```


### core-site.xml
>ver hadoop/core-site.xml

### hdfs-site.xml
>ver hadoop/hdfs-site.xml

### mapred-site.xml
>ver hadoop/mapred-site.xml

### yarn-site.xml
>ver hadoop/yarn-site.xml

```
sudo shutdown -r now
```

```
hdfs namenode -format
```

### Configurar archivos master y slaves
Este paso se debe hacer antes despues de configurar los esclavos

```
nano $HADOOP_HOME/etc/hadoop/master

nano $HADOOP_HOME/etc/hadoop/slaves
```


## STARTING HADOOP
El orden es primero el dfs y luego el yarn
```
start-dfs.sh  
start-yarn.sh

hdfs dfsadmin -report
```


## STOPPING HADOOP
El orden es primero el yarn y luego el dfs
```
stop-yarn.sh  
stop-dfs.sh  
```

## Comandos hdfs
http://hadoop.apache.org/docs/r2.7.0/hadoop-project-dist/hadoop-common/FileSystemShell.html#ls
hadoop fs -mkdir hdfs://hdmaster:54310/testdir/
hadoop fs -mkdir /testdir2
hadoop fs -ls /


## correr ejercicio
https://blogs.sap.com/2015/04/25/a-hadoop-data-lab-project-on-raspberry-pi-part-14/
```
hadoop fs -copyFromLocal /opt/hadoop-2.7.3/LICENSE.txt /license.txt
hadoop jar /opt/hadoop-2.7.3/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /license.txt /license-out.txt
hadoop fs -copyToLocal /license-out.txt ~/
```

## Chequear Estado
```
cp $HADOOP_HOME/logs/blank.log $HADOOP_HOME/logs/hadoop-hduser-namenode-hdmaster.log
cp $HADOOP_HOME/logs/blank.log $HADOOP_HOME/logs/hadoop-hduser-datanode-hdnode2.log

tail -100 $HADOOP_HOME/logs/hadoop-hduser-namenode-hdmaster.log

tail -100 $HADOOP_HOME/logs/hadoop-hduser-datanode-hdnode1.log
tail -100 $HADOOP_HOME/logs/hadoop-hduser-datanode-hdnode2.log

more /opt/hadoop_tmp/hdfs/namenode/current/VERSION
nano /opt/hadoop_tmp/hdfs/namenode/current/VERSION

more /opt/hadoop_tmp/hdfs/datanode/current/VERSION
nano /opt/hadoop_tmp/hdfs/datanode/current/VERSION

clusterID=CID-f81f8cb8-175c-49b3-9709-5a05a42d3d7c
```
