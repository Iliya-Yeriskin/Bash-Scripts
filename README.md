# Bash-Scripts Explanation:
#### docker_lab2.sh:
1. Checking if your machine got Docker installed
2. Then you got menu:
  * Create Custom Nginx container+commiting image from this container.
  * Making Dockerfile of Ubuntu image that runs a script in a loop+creating an image from it.
  
  
#### connect_menu2.sh + connect_output.py:
A menu script that does:
1. Create a new file
2. Make a new folder
3. Create a new user
* in a remote machine that is connected with sshpass by questioning the user for inputs
  in the end it run the coonect_output script.
  Connect_output connects via paramiko to the same server that was entered by inputs before and making a file that collects all the
  commands thats was done during the run of the script.


#### docker_menu_lab2.sh:
A menu script that does:
1. Download Nginx+DockerUI Images
2. Create Nginx Containers
3. IP Log of all the Containers
4. Create DockerUI Container+Add his IP to the Ip Logs
5. Create folder with index.html
6. Create 2 Nginx Containers with the mount of the index.html we created in 5


#### copy_from_server.sh:
A script that i made that helps me download with scp command any scripts or files from my linux servers

#### Continuous_Integration.sh:
- This Script will run a Dockerfile
- That file is building an custom Nginx server
On Ubuntu base image.
- Including custom Webpage of my GitHub.
- Script will let you decide the names of Image & Container.
- And of course on which Port you want to run the Container.
- In the end it will run the Container and will **upload the image to hub.docker.com**


#### rows_columns.sh:
- Creates a pattern of the word Iliya from user input of rows and columns.
