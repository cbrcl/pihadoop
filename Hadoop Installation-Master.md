## Creacion de usuario y grupo hadoop

```
sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo

su hduser
sudo mkdir /hdfs
sudo mkdir /hdfs/tmp
sudo chown -R hduser:hadoop /hdfs/tmp
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



## Configurar acceso a los slaves sin password

```
su hduser  
ssh-keygen  
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys  
chmod 0600 ~/.ssh/authorized_keys  
ssh-copy-id hduser@legoc-3 (Repeat for each slave node)  
ssh hduser@legoc-3
```


### core-site.xml
```
sudo nano /opt/hadoop-2.7.3/etc/hadoop/hdfs-site.xml

<property>
        <name>dfs.replication</name>
        <value>1</value>
</property>
sudo nano /opt/hadoop-2.7.3/etc/hadoop/core-site.xml

<property>
        <name>fs.default.name</name>
        <value>hdfs://hdmaster:54310</value>
</property>
<property>
        <name>hadoop.tmp.dir</name>
        <value>/hdfs/tmp</value>
</property>

cp /opt/hadoop-2.7.3/etc/hadoop/mapred-site.xml.template /opt/hadoop-2.7.3/etc/hadoop/mapred-site.xml
sudo nano /opt/hadoop-2.7.3/etc/hadoop/mapred-site.xml

<property>
  <name>mapreduce.framework.name</name>
  <value>yarn</value>
</property>
<property>
  <name>mapreduce.map.memory.mb</name>
  <value>256</value>
</property>
<property>
  <name>mapreduce.map.java.opts</name>
  <value>-Xmx204m</value>
</property>
<property>
  <name>mapreduce.reduce.memory.mb</name>
  <value>102</value>
</property>
<property>
  <name>mapreduce.reduce.java.opts</name>
  <value>-Xmx102m</value>
</property>
<property>
  <name>yarn.app.mapreduce.am.resource.mb</name>
  <value>128</value>
</property>
<property>
  <name>yarn.app.mapreduce.am.command-opts</name>
  <value>-Xmx102m</value>
</property>


sudo nano /opt/hadoop-2.7.3/etc/hadoop/yarn-site.xml

<property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>hdmaster:8025</value>
</property>
<property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>hdmaster:8030</value>
</property>
<property>
        <name>yarn.resourcemanager.address</name>
        <value>hdmaster:8050</value>
</property>
<property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
</property>
<property>
        <name>yarn.nodemanager.resource.cpu-vcores</name>
        <value>4</value>
</property>
<property>
        <name>yarn.nodemanager.resource.memory-mb</name>
        <value>1024</value>
</property>
<property>
        <name>yarn.scheduler.minimum-allocation-mb</name>
        <value>128</value>
</property>
<property>
        <name>yarn.scheduler.maximum-allocation-mb</name>
        <value>1024</value>
</property>
<property>
        <name>yarn.scheduler.minimum-allocation-vcores</name>
        <value>1</value>
</property>
<property>
        <name>yarn.scheduler.maximum-allocation-vcores</name>
        <value>4</value>
</property>
<property>
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
</property>
<property>
        <name>yarn.nodemanager.pmem-check-enabled</name>
        <value>true</value>
</property>
<property>
        <name>yarn.nodemanager.vmem-pmem-ratio</name>
        <value>4</value>
</property>
```

```
sudo shutdown -r now
```

```
hdfs namenode -format
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

## Chequear Estado

cp /opt/hadoop-2.7.3/logs/blank.log /opt/hadoop-2.7.3/logs/hadoop-hduser-namenode-hdmaster.log
cp /opt/hadoop-2.7.3/logs/blank.log /opt/hadoop-2.7.3/logs/hadoop-hduser-datanode-hdnode2.log

tail -100 /opt/hadoop-2.7.3/logs/hadoop-hduser-namenode-hdmaster.log

tail -100 /opt/hadoop-2.7.3/logs/hadoop-hduser-datanode-hdnode1.log
tail -100 /opt/hadoop-2.7.3/logs/hadoop-hduser-datanode-hdnode2.log

more /opt/hadoop_tmp/hdfs/namenode/current/VERSION
nano /opt/hadoop_tmp/hdfs/namenode/current/VERSION

more /opt/hadoop_tmp/hdfs/datanode/current/VERSION
nano /opt/hadoop_tmp/hdfs/datanode/current/VERSION

clusterID=CID-f81f8cb8-175c-49b3-9709-5a05a42d3d7c


```
hdfs namenode -format

hdfs dfsadmin -report

ssh hduser@hdnode1
ssh hduser@hdnode2

cd $HADOOP_CONF_DIR
nano mapred-site.xml
```
