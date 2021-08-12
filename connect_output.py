#!/bin/python3

import paramiko
import sys

print(sys.argv[1])

nbytes = 4096
hostname = input('Please Enter IP Address to connect: ')
port = 22
username = input('Please enter username: ')
password = input('Please enter password: ')
command = '''
echo {} > /home/iliya/Desktop/Lab2/manager.txt'''.format(sys.argv[1])

client = paramiko.Transport((hostname, port))
client.connect(username=username, password=password)

stdout_data = []
stderr_data = []
session = client.open_channel(kind='session')
session.exec_command(command)

session.close()
client.close()
