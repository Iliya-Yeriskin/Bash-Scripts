#!/bin/bash

echo '
	        Hello
	     And Welcome!
          -----------------
This Script will run a Dockerfile
That file is building an custom Nginx server
On Ubuntu base image.
Including custom Webpage of my GitHub.
We will let you decide the names of Image & Container.
And of course on which Port you want to run the Container.
'
sleep 3
echo -n "Please choose a name for the Image: "
read image
echo -e "\nNow we will Create the the Image...\nPlease wait proccess will take about a minute......"

dockerfile() {
mkdir dockerfile_mid_lab
cd dockerfile_mid_lab
echo '\
# The line below states we will base our new image on the Latest Official Ubuntu
FROM ubuntu:latest
#
# Identify the maintainer of an image
LABEL maintainer="Iliya Yerikin https://github.com/ThatsMyName92"
#
# Update the image to the latest packages
RUN apt-get update && apt-get upgrade -y
#
# Install NGINX to test & wget my GitHub to the index.html file
RUN apt-get install nginx -y && apt-get install wget -y
RUN cd /var/www/html ; sleep 1 ; wget -4 https://github.com/ThatsMyName92 -O index.nginx-debian.html
#
# Expose port 80
EXPOSE 80
EXPOSE 443
#
# Last is the actual command to start up NGINX within our Container
CMD ["nginx", "-g", "daemon off;"]' > midlab_dockerfile
sleep 1
sudo docker build --no-cache -f midlab_dockerfile -t $image . >/dev/null
echo -e '
####### ####### ####### ####### ####### ####### ####### ####### ####### ####### ####### 
                                                                                        
                                                                                        
                                                                                        
             ######  ##     ##  ######   ######  ########  ######   ######              
            ##    ## ##     ## ##    ## ##    ## ##       ##    ## ##    ##             
            ##       ##     ## ##       ##       ##       ##       ##                   
             ######  ##     ## ##       ##       ######    ######   ######              
                  ## ##     ## ##       ##       ##             ##       ##             
            ##    ## ##     ## ##    ## ##    ## ##       ##    ## ##    ##             
             ######   #######   ######   ######  ########  ######   ######              
                                                                                        
                                                                                        
                                                                                        
####### ####### ####### ####### ####### ####### ####### ####### ####### ####### #######
			    The Image Created Successfully!
'
cd ..
rm -rf dockerfile_mid_lab
}
dockerfile
echo -e "Installed Image:"
sudo docker images | awk 'NR==1' && sudo docker images | grep $image
echo -e "\nNow we'll run a Container with the new Image($image)"
echo -n "Please Choose a Name to the Container: "
read name
echo -n "Please Choose Port: "
read port
for i in `sudo docker ps -a | grep ::: | awk '{print$1}'`
do
	check="`sudo docker port $i | grep ::: | awk "NR==1" | cut -d ":" -f4`"
	echo $check >>ports11.txt
done
while grep $port ports11.txt
do
	echo -e "**Sorry this port is used**\n___________________________\nEnter new port number: "
	read port
	continue
done
rm ports11.txt
echo -e "Creating your Container..."
sleep 1
sudo docker run -d -p $port:80 --name $name $image
echo -e "----------------------------------------\nThis is your new Container:"
sudo docker ps | awk 'NR==1' && sudo docker ps | grep $port
echo -e "Now we'll do an health check to your container:"
echo -n "Enter your IP Address: "
read IP
echo -e "Fetching data from your Container...."
sleep 1.5
wget -4 $IP:$port -O health_check.html
echo -e "Finished getting data\nDo you want to check the output file?(y/n)"
read ans
if [ $ans == "y" ]
then
	cat health_check.html
	echo -e "Check done"
else
	echo -e "Passing check\n"
fi
rm health_check.html
echo -e "-------------------------------------------------------\nNow Let's upload your image($image) to hub.docker.com"
echo "Please enter your login details:"
echo -n "Username: "
read username
echo -n "Password: "
read pass
echo -e "The proccess will be automatic\nPlease wait..."
sudo docker login --username $username --password $pass
sudo docker tag $image $username/$image && sudo docker push $username/$image >/dev/null
echo -e "Your Image($image) Uploaded to hub.docker.com\nRunning search command in hub.docker.com\nPlease wait...."
sleep 2
for i in {1..7}
do
        echo -n "..."
        sleep 1
done
echo -e "\n"
sudo docker search $username
echo -e "------------------------\nThe Script $0 is Done.\n------------------------"
