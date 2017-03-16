## Descargar version lite de raspbian:
https://www.raspberrypi.org/downloads/raspbian/

## Copiar la imagen a la tarjeta SD
https://www.raspberrypi.org/documentation/installation/installing-images/mac.md
```
diskutil list
diskutil unmountDisk /dev/disk2
cd <Directorio donde esta la imagen de raspbian>
sudo dd bs=1m if=2017-03-02-raspbian-jessie-lite.img of=/dev/rdisk2
```

## Habilitar SSH creando un archivo "ssh" en la raiz del la tarjeta SD
https://www.raspberrypi.org/documentation/remote-access/ssh/README.md
ENABLE SSH ON A HEADLESS RASPBERRY PI
For headless setup, SSH can be enabled by placing a file named 'ssh', without any extension, onto the boot partition of the SD card. When the Pi boots, it looks for the 'ssh' file. If it is found, SSH is enabled, and the file is deleted. The content of the file does not matter: it could contain text, or nothing at all.


Conectar por cable para configurar IP del raspberry
 Regenerar llave ssh para conectarse a una IP previamente utilizada con otra maquina
```
ssh-keygen -R 192.168.0.X
```

## Cambiar nombre de la maquina, contraseña por defecto del usuario pi y expandir filesystem
```
sudo raspi-config
```

## Reiniciar
```
sudo shutdown -r now
```

## Configurar WIFI via command line
https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md
Cambiar a root para realizar cambios
```
sudo su
wpa_passphrase "WIFI_NAME" "WIFI_PASSWORD" >> /etc/wpa_supplicant/wpa_supplicant.conf
```

Borrar contraseña del archivo wpa_supplicant.conf
```
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
```

Aplicar los cambios WIFI y salir del modo root
```
sudo wpa_cli reconfigure

exit
```


## Configurar STATIC WIFI IP
https://kerneldriver.wordpress.com/2012/10/21/configuring-wpa2-using-wpa_supplicant-on-the-raspberry-pi/
```
sudo cp /etc/network/interfaces /etc/network/interfaces.backup
sudo nano /etc/network/interfaces
```

### Modificar linea de wlan0
```
allow-hotplug wlan0
iface wlan0 inet static
    address 192.168.0.X
    netmask 255.255.255.0
    gateway 192.168.0.1
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
```

## Levantar WIFI
```
sudo ifup wlan0
```

## Linkear otros equipos con nombres cortos
Agregar IP y nombre deseado
```
sudo nano /etc/hosts

192.168.0.X RASPBERRY1
192.168.0.Y RASPBERRY2
```


## Instalaciones varias: python, zip, unzip
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip
sudo apt-get install zip unzip
```
