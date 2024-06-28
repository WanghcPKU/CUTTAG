for sample in $(ls ./sam/*.sam | cut -d"/" -f 3 | cut -d"." -f 1); do
samtools view -bS -F 0x04 ./sam/${sample}.sam > ./sam/${sample}.bam
#-F 0x04 filter the unalignment fragments
done
