# Bash-Scripts Explanation:
#### docker_lab2.sh:
1.Checking if your machine got Docker installed
2.Then you got menu: 
  a.Create Custom Nginx container+commiting image from this container.
  b.Making Dockerfile of Ubuntu image that runs a script in a loop+creating an image from it. 
  
  
#### connect_menu2.sh + connect_output.py:
A menu script that does:
1.Create a new file
2.Make a new folder
3.Create a new user
In a remote machine that is connected with sshpass by questioning the user for inputs
in the end it run the coonect_output script.
Connect_output connects via paramiko to the same server that was entered by inputs before and making a file that collects all the
commands thats was done during the run of the script.


#### **
