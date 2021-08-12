#!/bin/bash

e="y"
while [ $e == "y" ]
do
	echo -e '
	     Hello
	  -----------
   Welcome to Docker Menu Script
____________________________________

Please Choose from the Following(1-6):
1.Download Nginx+DockerUI Images
2.Create Nginx Containers
3.IP Log of all the Containers
4.Create DockerUI Container+Add his IP to the Ip Logs
5.Create folder with index.html
6.Create 2 Nginx Containers with the mount of the index.html we created in 5'

	echo 'Enter your choise: '
	read choise
	if [ $choise == "1" ]
	then
		echo "You choose 1"
		sudo docker pull nginx:latest
		sudo docker pull abh1nav/dockerui:latest

	elif [ $choise == "2" ]
	then
		echo "You choose 2"
		echo -e "How Many of Containers?"
		read multi
		count=1
		while [ $count -le $multi ]
		do
			echo "Please Enter port number:"
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
			sudo docker run -d -p $port:80 nginx
			echo "Container #$count Running"
			let count++
		done

	elif [ $choise == "3" ]
	then
		echo "You choose 3"
		for i in `sudo docker ps -a | grep -e nginx -e dockerui -e centos | awk '{print$1}'`
		do
			sudo docker inspect $i | grep -we "IPAddress" -we Image
			echo "----------------------------------------------------------------------------------------------"
		done >> IP_log.txt

	elif [ $choise == "4" ]
	then
		echo "You choose 4"
		echo "Please choose port for your DockerUI Container:"
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
		sudo docker run -d -p $port:9000 -v /var/run/docker.sock:/docker.sock abh1nav/dockerui -e="/docker.sock"
		echo "DockerUi Container Created"
		for i in `sudo docker ps -a | grep dockerui | awk '{print$1}'`
                do
                        sudo docker inspect $i | grep -we "IPAddress" -we Image
                        echo "----------------------------------------------------------------------------------------------"
                done >> IP_log.txt
	elif [ $choise == "5" ]
	then
		echo "You Choose 5"
		mkdir web
		cd web
		wget -4 https://github.com/ThatsMyName92 -O index.html
		echo "Created web folder with index.html inside"

	elif [ $choise == "6" ]
	then
		echo "You choose 6"
		num=0
		while [ $num -lt 2 ]
		do
			echo "Please Enter port number:"
                        read port
			count=1
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
                        sudo docker run -d -p $port:80 -v /home/iliya/Desktop/Docker/Docker_Final_Lab/web:/usr/share/nginx/html nginx
                        echo "Container #$count Created"
			let count++
			let num++
		done
	else
		echo "Please choose 1-6 ONLY!!!"
	fi
	echo "Do you want to go back to Menu? (y/n)"
	read e
	if [ $e == n ]
	then
		echo "Thank You & Byebye."
		break
	else
		echo "Returning to Menu"
		sleep 1.5
	fi
done

