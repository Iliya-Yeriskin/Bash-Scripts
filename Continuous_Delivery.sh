#!/bin/bash

echo '
	       		   Hello
	               	And Welcome!
          	     -----------------
This Script will pull my uploaded imgae form hub.docker.com
Then execute a menu to pull,remove,run,show
images and containers.
'
sleep 3
echo -e "------------------------------------------\nPulling net4u_iliya1 from hub.docker.com...."
for i in {1..5} ; do echo -n "......" ; sleep 1 ; done
sudo docker pull iliyayeri/net4u_iliya1 >/dev/null
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
                            The Image Downloaded Successfully!
'
echo -e "Now script will run the menu..."
sleep 5

menu() {
while [ True ]
do
        echo -e "Hello\n_________\nPlease choose an option:\n1.Pull Images\n2.Remove Images/Containers\n3.Install Container(s)\n4.Show Installed Images\n5.Show Running Containers"
        read choise
        if [ $choise == "1" ]
        then
                echo "You choose 1"
                echo -n "What Image would you like to pull?: "
		read image
		sudo docker search $image
		echo "Please type the exact image name: "
		read image
		sudo docker pull $image
        elif [ $choise == "2" ]
        then
		while [ True ]
		do
                echo "You choose 2"
                echo -e "Choose if you want to remove Image or Container:\n1.Image\n2.Container"
		read rem
		if [ $rem == "1" ]
		then
			sudo docker images
			echo -n "Copy and Paste your Image ID here: "
			read IMID
			if sudo docker rmi -f $IMID 2>gugu.txt
			then
				echo "Image removed Successfully."
			elif cat gugu.txt | grep child
			then
				echo -e "Image got child images.\nPlease Enter Image Repository name:"
				read repo
				sudo docker rmi -f $repo
			else
				echo "Please stop any Container thats running from this Image"
				sudo docker ps -a | grep $IMID
				echo -n "Copy and Paste your Container ID here: "
                        	read COID
                        	sudo docker rm -f $COID
                        	echo -e "Container removed Successefully.\nNow the Image($IMID) will be removed"
				sleep 1.5
				sudo docker rmi -f $IMID
                                echo "Image removed Successefully."
			fi
		elif [ $rem == "2" ]
		then
			sudo docker ps -a
			echo -n "Copy and Paste your Container ID here: "
                        read COID
                        sudo docker rm -f $COID
                        echo "Container removed Successefully."
		else
			echo "Please choose 1-2 ONLY!"
		fi
		echo -e "Do you want to exit (y)\nRemove another image/container? (n)"
		read ex
		if [ $ex == "y" ]
		then
			echo "Thank you Byebye..."
			sleep 1
			break
		else
			continue
		fi
		done
        elif [ $choise == "3" ]
        then
		echo "You choose 3"
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
				echo $check >>ports11.txt 2>/dev/null
			done
			while grep $port ports11.txt 2>/dev/null
			do
				echo -e "**Sorry this port is used**\n___________________________\nEnter new port number: "
				read port
				continue
			done
			rm ports11.txt 2>/dev/null
			sudo docker run -d -p $port:80 iliyayeri/net4u_iliya1
			echo "Container #$count Running"
			let count++
		done
        elif [ $choise == "4" ]
        then
                echo "You choose 4"
                sudo docker images
        elif [ $choise == "5" ]
        then
                echo "Youc hoose 5"
                sudo docker ps
        else
                echo "Please choose 1-6 ONLY!!!"
        fi
        echo "Do you want to Exit? (y/n)"
        read e
        if [ $e == y ] || [ $e == yes ]
        then
                echo "Thank You & Byebye."
		sleep 1.5
                break
        else
                echo "Returning to Menu"
                sleep 1.5
        fi

done
}
menu
