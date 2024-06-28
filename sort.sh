#Pay attention to the working directory

# cd ./sam
for sample in $(ls ./*.bam | cut -d"/" -f 2 | cut -d"." -f 1); do
samtools sort -O bam  -@ 10 -o ${sample}_sorted.bam ${sample}.bam
samtools index ${sample}_sorted.bam
done
