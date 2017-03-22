sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo
sudo hduser
sudo mkdir /hdfs/tmp
sudo chown -R hduser:hadoop /hdfs/tmp
