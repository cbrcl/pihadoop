sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip
sudo apt-get install zip unzip
sudo apt-get install oracle-java7-jdk



sudo addgroup hadoop
sudo adduser --ingroup hadoop hduser
sudo adduser hduser sudo
sudo hduser
sudo mkdir /hdfs/tmp
sudo chown -R hduser:hadoop /hdfs/tmp
