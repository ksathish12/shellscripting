l=$30000
u=$40000

while read line
	do
	if [ "$line"|cut -d "," -f 7 -ge $l -a "$line"|cut -d "," -f 7 -le $u]
		echo "line"
	#echo "$line"|cut -d "," -f 7
	done<employee.csv

