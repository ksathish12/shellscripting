rm fx
rm fx2
rm freq

max=`cat adult.csv|grep '^[0-9]'|cut -d ',' -f 1|sort -nr|head -n 1`
min=`cat adult.csv|grep '^[0-9]'|cut -d ',' -f 1|sort -n|head -n 1`

echo "The minimum value is $min and the Maximum value is $max"
echo "------------------------"
echo "Enter the class interval"
read ci
echo "------------------------"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "   Class -> Count -> x -> f.x -> x^2 -> f.x^2"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"    
ll=`echo "$min"`
start=$min
start1=`echo "$min+$ci"|bc`
for i in `seq $start1 $ci $max`
do
  count=0
  for j in `cat adult.csv|grep '^[0-9]'|cut -d ',' -f 1`
          do
          if [ $j -ge $start ] && [ $j -lt $i ]
          then
                  count=`echo "$count + 1"|bc`
         fi
 done
mean=`expr "scale=4;(($start+$i)-1)/2"|bc -l`
fx=`expr "scale=4;$mean * $count"|bc -l`
mean2=`expr "scale=4;$mean * $mean"|bc -l`
fx2=`expr "scale=4; $count * $mean * $mean"|bc -l`
echo "$fx2">>fx2
echo "$fx">>fx
echo "$count">>freq
echo "[$start - $i) -> $count -> $mean -> $fx -> $mean2 -> $fx2"
start=$i
done


if [ $i -lt $max ]
then
  count=0
    for k in `cat adult.csv|grep '^[0-9]'|cut -d ',' -f 1`
            do
            if [ $k -ge $i ] && [ $k -le $max ]
            then
                    count=`echo "$count + 1"|bc`
           fi
   done
mean=`expr "scale=4;(($max+$i))/2"|bc -l`
fx=`expr "scale=4;$mean * $count"|bc -l`
mean2=`expr "scale=4;$mean * $mean"|bc -l`
fx2=`expr "scale=4;$count * $mean * $mean"|bc -l`
echo "$fx2">>fx2
echo "$fx">>fx
echo "$count">>freq
echo "[$i - $max] -> $count -> $mean -> $fx -> $mean2 -> $fx2"
fi
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
sumfx=0
sumfx2=0
sumfreq=0
while read line
do
sumfx=`expr "scale=4;$sumfx + $line"|bc -l`
done<fx
echo "Sum of fx is $sumfx"

while read line
do
sumfx2=`expr "scale=4;$sumfx2 + $line"|bc -l`
done<fx2
echo "Sum of fx^2 is $sumfx2"

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

while read line
do
sumfreq=`expr "scale=4;$sumfreq + $line"|bc -l`
done<freq
echo "Sum of frequency is $sumfreq"
finalmean=`expr "scale=4;($sumfx/$sumfreq)"|bc -l`
variance=`expr "scale=4;($sumfx2/$sumfreq)-($finalmean*$finalmean)"|bc -l`
sd=`expr "scale=4;sqrt($variance)"|bc -l`
echo "Mean is $finalmean"
echo "Variance is $variance"
echo "Standard deviation is $sd"



