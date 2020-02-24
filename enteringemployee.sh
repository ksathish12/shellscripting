echo "Enter how many records needed"
read n
i=1
empid=100
while [ $i -le $n ]
	do
		echo "Enter name"
		read name
		echo "Enter basic salary"
		read basic
	((empid++))
	((i++))
	echo "$empid | $name | $basic" >> employee.txt
done
