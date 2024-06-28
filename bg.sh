#Pay attention to the working directory

# cd ./sam
ls *sorted.bam | while read id
do
bamCoverage -p 15 --binSize 1 --normalizeUsing RPKM -b $id -o ${id%%.*}2.last.bw # binSize is preferably between 1 and 50
done
