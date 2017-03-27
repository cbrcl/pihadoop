https://www.packtpub.com/books/content/creating-supercomputer

```
cd $SPARK_HOME
./sbin/start-all.sh
./bin/pyspark



zip -r spark-2.1.0-hdmaster.zip /opt/spark-2.1.0-bin-hadoop2.7/
scp spark-2.1.0-hdmaster.zip hduser@hdnode1:~
scp spark-2.1.0-hdmaster.zip hduser@hdnode2:~

sudo unzip spark-2.1.0-hdmaster.zip -d /
sudo chown -R hduser:hadoop /opt/spark-2.1.0-bin-hadoop2.7


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

spark-submit --master spark://hdmaster:7077 --conf spark.executor.memory=640m pi-spark.py


spark-submit --master yarn --conf spark.executor.memory=640m --deploy-mode cluster pi-spark.py

spark-submit --master yarn --deploy-mode cluster pi-spark.py

spark-submit --master yarn --executor-memory 512m --deploy-mode cluster pi-spark.py

spark-submit –-master yarn –executor-memory 512m –name pi-spark –executor-cores 8  pi-spark.py


spark-submit --master yarn --deploy-mode client spark://hdmaster:7077 pi-spark.py

nano /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh

scp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh hduser@hdnode1:/opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh
scp /opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh hduser@hdnode2:/opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh
/opt/spark-2.1.0-bin-hadoop2.7/conf/spark-env.sh

```
