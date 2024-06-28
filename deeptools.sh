#Pay attention to the working directory

# cd ./sam
computeMatrix reference-point --referencePoint TSS -p 15 \
-b 2000 -a 2000 -bs 50 \
-R ./hgTables.txt  \
-S a_sorted2.last.bw b_sorted2.last.bw \
--skipZeros --missingDataAsZero -o all_TSS.gz  \
--outFileSortedRegions all.bed
plotHeatmap -m all_TSS.gz \
# --colorList 'blue,white' \
--heatmapHeight 15 \
      -out all.pdf \

