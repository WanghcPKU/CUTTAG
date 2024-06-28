ls ./raw/*_1.fq.gz | while read id
echo $id
do 
id2=${id%%_1.fq.gz}"_2.fq.gz"
trim_galore --q 25 -j 10 --stringency 4 --length 36 --paired $id $id2 --out ./trim
done 
