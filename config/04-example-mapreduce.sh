hadoop fs -copyFromLocal $HADOOP_HOME/LICENSE.txt /license.txt
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /license.txt /license-out.txt
hadoop fs -copyToLocal /license-out.txt ~/
