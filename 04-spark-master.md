## Descarga, instalacion y configuración de Spark en cluster
https://tekmarathon.com/2017/02/15/hadoop-and-spark-installation-on-raspberry-pi-3-cluster-part-2/

```
# descarga archivo
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz

# descomprime archivo en carpeta /opt/
sudo tar -xvzf spark-2.1.0-bin-hadoop2.7.tgz -C /opt/

# asigna carpeta a usuario hduser
sudo chown -R hduser /opt/spark-2.1.0-bin-hadoop2.7
```

### nano $SPARK_HOME/conf/spark-env.sh
> ver [spark-files/spark-env.sh](spark-files/spark-env.sh)

### nano $SPARK_HOME/conf/slaves
> ver [spark-files/slaves](spark-files/slaves)

Una vez hecha esta configuracion se puede copiar la carpeta /opt/spark-2.1.0-bin-hadoop2.7 a los slaves de la siguiente manera
```
zip -r spark-2.1.0-hdmaster.zip /opt/spark-2.1.0-bin-hadoop2.7/
scp spark-2.1.0-hdmaster.zip hduser@hdnode1:~
scp spark-2.1.0-hdmaster.zip hduser@hdnode2:~

ssh hdnode1
sudo unzip spark-2.1.0-hdmaster.zip -d /
sudo chown -R hduser:hadoop /opt/spark-2.1.0-bin-hadoop2.7

nano /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh
#modificar linea con SPARK_LOCAL_IP por IP hdnode1
SPARK_LOCAL_IP=192.168.0.191

#volver a hdmaster
exit

ssh hdnode2
sudo unzip spark-2.1.0-hdmaster.zip -d /
sudo chown -R hduser:hadoop /opt/spark-2.1.0-bin-hadoop2.7

nano /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh
#modificar linea con SPARK_LOCAL_IP por IP hdnode2
SPARK_LOCAL_IP=192.168.0.192

exit
```

## Iniciar Spark en hdmaster
```
cd $SPARK_HOME
./sbin/start-all.sh

#ejecutar shell pyspark
./bin/pyspark
```



### Otras configuraciones de prueba

```
scp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh hdnode1:/opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh
scp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh hdnode2:/opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh

sed 's/rootCategory=INFO/rootCategory=WARN/'

sudo python -m pip install --upgrade --force setuptools
sudo python -m pip install --upgrade --force pip

wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install setuptools
sudo pip install "ipython[all]"

sudo pip install --upgrade ipython
sudo apt-get install --reinstall python

#SUCCEED
spark-submit --master yarn --conf spark.executor.memory=640m pi-spark.py

#SUCCEED
spark-submit --master spark://hdmaster:7077 --conf spark.executor.memory=768m pi-spark.py 20

spark-submit --master yarn --conf spark.executor.memory=640m --deploy-mode cluster pi-spark.py

spark-submit --master yarn --deploy-mode cluster pi-spark.py

spark-submit --master yarn --executor-memory 512m --deploy-mode cluster pi-spark.py

spark-submit –-master yarn –executor-memory 512m –name pi-spark –executor-cores 8  pi-spark.py

spark-submit --master yarn --deploy-mode client spark://hdmaster:7077 pi-spark.py

```
