#!/bin/bash

connection_sshpass() {
echo -e "Enter remote IP address: " ; read IP
echo -e "Enter remote Username: " ; read username
echo -e "Enter remote Username Password: " ; read pass

sshpass -p '$pass' ssh $username@$IP $1
}
DONE=""
e="n"
while [ $e == "n" ]
do
        echo -e "Hello Please choose an option from the Menu\nMenu:\n1.Create a new file"
        echo -e "2.Make a new folder\n3.Create a new user"
        read choise
        if [ $choise == 1 ]
        then
                echo -e "You choose 1\nEnter file name:"
		read filename
		connection_sshpass "touch /home/iliya/Desktop/Lab2/sshpass/$filename.txt"
		echo "Created a file named $filename"
		DONE+="\nCreated a file named $filename"

        elif [ $choise == 2 ]
        then
		echo -e "You choose 2\nEnter folder name:"
                read foldername
                connection_sshpass "mkdir /home/iliya/Desktop/Lab2/sshpass/$foldername"
		echo " Created a folder named $foldername"
		DONE+="\nCreated a folder named $foldername"
        elif [ $choise == 3 ]
        then
		echo -e "You choose 3\nEnter User name:"
                read username2
                connection_sshpass "sudo useradd $username2"
		echo "Created a user named $username2"
		DONE+="\nCreated a user named $username2"
        else
                echo "Please Enter 1-3 ONLY!!!"
        fi

        echo "Do you want to Exit? (y/n)"
        read e
        if [ $e == y ]
        then
                echo "Thank You & Byebye."
                break
        else
                echo "Returning to Menu"
                sleep 1.5
        fi
done
echo -e $DONE >> manager.txt
python3 connect_output.py "$DONE" "$IP" "$username" "$pass"
