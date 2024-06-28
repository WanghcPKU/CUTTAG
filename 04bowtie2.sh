ls ./trim/*1.fq.gz |while read file
do 
f1=$file
f2=${file/1_val_1.fq.gz/2_val_2.fq.gz}
# replace '1_val_1.fq.gz' with '2_val_2.fq.gz'
name=$(basename $f1)
name=${name%%_*}
bowtie2 --end-to-end --very-sensitive --no-mixed --no-discordant --phred33 -I 10 -X 1000 -p 15 -x /lustre/user/taowlab/wanghc/work/lvwc/cuttag/bowtie/hg38/hg38 -1 $f1 -2 $f2 -S ./sam/${name}_bowtie2.sam
#-I -X insert fragments size between 10 and 1000
done
