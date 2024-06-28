# CUTTAG  
## Step 1 01fastqc.sh  
Quality Control  
1.fastqc  
2.multiqc  
## Step 2 02trim.sh
Trim the adaptors.  
## Step 3 03fastqc.sh  
## Step 4 04bowtie2.sh  
Map the high quality reads to the genome.  
bowtie2 index dowanload : https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml  
or build the genome index by processing genome.fa ：`bowtie2-build -f genome.fa hg38`  
genome.fa download : https://hgdownload.soe.ucsc.edu/downloads.html or http://asia.ensembl.org/index.html   
  
**Pay attention to the download version!**  
  
## Step 5 05bam.sh  
1.Sort the bam file and index alignment. --> `sort.sh`  
2.Transform the sorted file to .bw file. --> `bg.sh`  
## Step 6 06macs2.sh  
Peak calling.  
The CUTTAG peaks were performed using the MASC2 software.  
## Step 7 Data Downstream Analysis  
### 7.1 deeptools  
tssplot & heatmap : `deeptools.sh`  
computeMatrix -R reference : http://xuchunhui.top/2020/11/05/%E4%B8%BAdeepTools%E7%9A%84computeMatrix%E5%88%9B%E5%BB%BAgene.bed%E6%96%87%E4%BB%B6/  
deeptools Chinese usage introduction : https://www.jianshu.com/p/2b386dd437d3  
### 7.2 Differentially Peaks Analysis  
R pakage : Diffbind -- > `Diffbind.r`  
