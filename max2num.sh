#tput clear
echo "Enter first number"
read x
echo "Enter second number"
read y
if [$x -ge $y]
	then 
	echo "$x is maximum"
else
	echo "$y is maximum"
fi
