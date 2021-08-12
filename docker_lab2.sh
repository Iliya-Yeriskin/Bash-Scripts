#!/bin/bash

#Docker install
if systemctl --all --type service | grep -q docker
then
    echo "docker exists."
else
	echo "docker does NOT exist."
	curl -fsSL https://get.docker.com -o get-docker.sh
	sleep 5
	bash get-docker.sh
fi


#nginx with custom html+custom nginx
private_nginx() {
echo "Enter port number for your nginx server"
read port
sudo docker run -d -p $port:80 nginx
sleep 1
name="`sudo docker ps | grep nginx | awk 'NR==1 {print $1}'`"
sudo docker exec -i -t $name /bin/bash -c 'cd /usr/share/nginx/html && echo "<h1>Iliya.Y Private Nginx Server</h1>" > index.html'
echo "Created Nginx Container in port $port"
sleep 1
sudo docker commit $name nginx_iliya_new
sleep 1
echo "Created new image"
sudo docker images
}

#Create a Dockerfile

dockerfile() {
mkdir dockerfile
cd dockerfile
echo -e "#!bin/bash\n\nwhile true\ndo\n	echo 'Iliya is the King'\n	sleep 1\ndone" > mycommand.sh
echo -e '\
FROM ubuntu

MAINTAINER Iliya Yeriskin

COPY mycommand.sh /usr/local/bin/mycommand.sh

RUN chmod +x /usr/local/bin/mycommand.sh

RUN set -x \
  && apt-get update && apt-get upgrade -y && apt-get install curl -y && apt-get install python3 -y && apt-get install net-tools -y



CMD ["/usr/local/bin/mycommand.sh"]' > mydockerfile

echo "Created files...."
sleep 2
sudo docker build -f mydockerfile -t iliya_lab_image .
echo "Created new image"
sleep 1
sudo docker images
}

echo -e "Hello\n____________\n1.Create private nginx\n2.Create private Dockerfile"
read ans
if [ $ans == "1" ]
then
	private_nginx
elif [ $ans == "2" ]
then
	dockerfile
else
	echo "Please select 1-2 ONLY!"
fi
