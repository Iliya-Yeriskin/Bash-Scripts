#!/bin/bash

echo -e "Please enter number of rows: $rows"
read rows
echo -e "Please enter number of columns: $columns"
read columns
echo -e "Thats your pattern:\n"
c=1
r=1
while [ $r -le $rows ]
do
	echo `\
		while [ $c -le $columns ]
		do
			echo  "Iliya "
			let c=1+c
		done`
	let r=1+r
done

