## Guias utilizadas
http://www.becausewecangeek.com/building-a-raspberry-pi-hadoop-cluster-part-2/

## Creacion de usuario y grupo hadoop
>ver config/02-raspberry-hadoop-user.sh

## Configurar acceso a los slaves sin password desde el master
```
su hduser  
cd ~
ssh-keygen  
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys  
chmod 0600 ~/.ssh/authorized_keys  
ssh-copy-id hduser@hdnode1
ssh-copy-id hduser@hdnode2

#testear
ssh hduser@hdnode1

#realizar modificacion de /etc/hosts en cada nodo

#volver al hdmaster
exit
```


## En el master generar el zip con la carpeta de configuracion
```
su hduser
cd ~
zip -r hadoop-2.7.3-hdmaster.zip /opt/hadoop-2.7.3/

scp hadoop-2.7.3-hdmaster.zip hduser@hdnode1:~
ssh hduser@hdnode1
sudo unzip hadoop-2.7.3-hdmaster.zip -d /
sudo chown -R hduser:hadoop /opt/hadoop-2.7.3/
rm hadoop-2.7.3-hdmaster.zip
exit
scp .bashrc hduser@hdnode1.local:~/.bashrc



scp hadoop-2.7.3-hdmaster.zip hduser@hdnode2.local:~
ssh hduser@hdnode2
sudo unzip hadoop-2.7.3-hdmaster.zip -d /
sudo chown -R hduser:hadoop /opt/hadoop-2.7.3/
rm hadoop-2.7.3-hdmaster.zip
exit
scp .bashrc hduser@hdnode2.local:~/.bashrc
```
