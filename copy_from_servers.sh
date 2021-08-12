#!/bin/bash

echo "Select server ubuntu1/ubuntu2/centos:"
read server
echo "Select file to copy(full path after /home/iliya/):"
read path
scp iliya@$server:/home/iliya/$path .
sleep 1
echo "Done coping file to PC"