echo "Enter the terms"
read terms
a=0
b=1
aa=0
bb=1
for i in `seq $terms`
#for (( i=0; i < $terms; i++ ))
do
	term=$a
	x=`echo "(($a + $b))"|bc`
	d=`expr "(($aa / $bb))"|bc -l`
	id=`expr "(($bb/ $aa))"|bc -l`
	term1=$d
	term2=$id
	echo "$term -> $term1 -> $term2"
	a=$b
	b=$x
	aa=$bb
	bb=$x
done


