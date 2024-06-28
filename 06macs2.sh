ls ./sam/*ed.bam | while read id
do
name=${id##*/} 
name=${name%%_*}
macs2 callpeak -t $id  -f BAMPE -g hs -n $name -B --outdir ./peaks -q 0.05 --keep-dup all 
# -f BAMPE : pair-end bam file
# -g hs : Human
# -q 0.05 : FDR < 0.05
done 
