
```
sudo nano /etc/hostname
Reemplazar Raspberry con nombre del nodo
sudo nano /etc/hosts


sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo

sudo hduser

cd ~

sudo wget http://www-us.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
sudo tar -xvzf hadoop-2.7.3.tar.gz -C /opt/

cd /opt
nano ~/.bashrc
```


```
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")
export HADOOP_HOME=/opt/hadoop-2.7.3
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export YARN_CONF_DIR=$HADOOP_HOME/etc/hadoop
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
```



###### PENDIENTE
```
cd $HADOOP_CONF_DIR
nano hadoop-env.sh



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






## Configurar Cluster


### core-site.xml
```
cd $HADOOP_CONF_DIR
nano core-site.xml
```

```
<configuration>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://hdmaster:9000/</value>
    </property>
    <property>
        <name>fs.default.FS</name>
        <value>hdfs://hdmaster:9000/</value>
    </property>
</configuration>
```

### hdfs-site.xml: Cambiar el dfs.replication al numero de nodos que existan
```
su hduser
cd $HADOOP_CONF_DIR
nano hdfs-site.xml

sudo rm -r /opt/hadoop_tmp

sudo mkdir -p /opt/hadoop_tmp/hdfs/namenode
sudo mkdir -p /opt/hadoop_tmp/hdfs/datanode

sudo chown hduser:hadoop /opt/hadoop_tmp -R
sudo chmod 750 /opt/hadoop_tmp/hdfs

```
```
<configuration>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>/opt/hadoop_tmp/hdfs/namenode</value>
        <final>true</final>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>/opt/hadoop_tmp/hdfs/datanode</value>
        <final>true</final>
    </property>
    <property>
        <name>dfs.namenode.http-address</name>
        <value>master:50070</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>2</value>
    </property>
</configuration>
```


### yarn-site.xml

```
nano yarn-site.xml
```
```
<configuration>

  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value>hdmaster</value>
  </property>

    <property>
        <name>yarn.resourcemanager.resource-tracker.address</name>
        <value>hdmaster:8025</value>
    </property>
    <property>
        <name>yarn.resourcemanager.scheduler.address</name>
        <value>hdmaster:8035</value>
    </property>
    <property>
        <name>yarn.resourcemanager.address</name>
        <value>hdmaster:8050</value>
    </property>
</configuration>
```




### mapred-site.xml

```
nano mapred-site.xml
```
```
<configuration>
    <property>
        <name>mapreduce.job.tracker</name>
        <value>hdmaster:9000</value>
    </property>
</configuration>
```








## STOPPING HADOOP
El orden es primero el yarn y luego el dfs
```
stop-yarn.sh  
stop-dfs.sh  
```

## STARTING HADOOP
El orden es primero el dfs y luego el yarn
```
start-dfs.sh  
start-yarn.sh
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
