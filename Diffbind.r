library(DiffBind)
dbcsv <- read.csv("./diff.csv") 
dbObj <- dba(sampleSheet=dbcsv,scoreCol=5) #查看peakscore 在输入peak文件的第几列


dbObj_c <- dba.count(dbObj,bUseSummarizeOverlaps=TRUE)

dbObj_c <-dba.contrast(dbObj_c,
                    minMembers=2,
                    categories = DBA_CONDITION)

dbObj_c <- dba.normalize(dbObj_c,method=DBA_ALL_METHODS,
                           normalize=DBA_NORM_NATIVE) ## optional step 可以调参
dbObj_c <- dba.analyze(dbObj_c,method=DBA_DESEQ2)  
db_report <- dba.report(dbObj_c,th=1,contrast =1)

## 如果重复性不好 会导致Fold 很小 
library(DESeq2)

deseq2_results <- dbObj_c$DESeq2$DEdata
 
shrink_results_apeglm <- lfcShrink(deseq2_results, coef=2, type="normal") # type : normal and apeglm 
head(shrink_results_apeglm)
shrink_results_apeglm<- as.data.frame(shrink_results_apeglm)
range(shrink_results_apeglm$log2FoldChange)
new_df <- data.frame(id = c(1:nrow(shrink_results_apeglm)),
                    pval =shrink_results_apeglm$pval,
                    padj = shrink_results_apeglm$padj,
                    fold =  shrink_results_apeglm$log2FoldChange)

dbObj_c$contrasts[[1]]$DESeq2$de <- new_df
db_report <- dba.report(dbObj_c,th=1,contrast =1)

##peak annotation
library(ChIPpeakAnno)
library(ChIPseeker)
library("TxDb.Hsapiens.UCSC.hg38.knownGene")
library("org.Hs.eg.db")
library(VennDiagram)
   txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
promoter <- getPromoters(TxDb=txdb, 
                         upstream=3000, downstream=3000)

peakAnno <- annotatePeak(db_report,  # db_report 为 S4 对象 
                         tssRegion=c(-3000, 3000),
                         TxDb=txdb, annoDb="org.Hs.eg.db")

###deeptools 上升的上升 下降的下降
peak_tss <- subset(peak_df,abs(distanceToTSS) < 3000)

peak_tss_up <- subset(peak_tss, Fold > 0.5)
head(peak_tss_up)

write.table(peak_tss_up[,1:3], 
            file = "./deeptools/peak_tss_up.txt", 
            sep = "\t", 
            col.names = FALSE, 
            row.names = FALSE, 
            quote = FALSE)

##enrichment

geneid <- bitr(peak_tss_up$SYMBOL, fromType = "SYMBOL",
            toType = c("ENTREZID"),
            OrgDb = org.Hs.eg.db)
gene.GO <- enrichGO(gene = geneid$ENTREZID,
            OrgDb = org.Hs.eg.db,
            keyType = "ENTREZID",
            ont = "ALL",
            pAdjustMethod ="BH",
            pvalueCutoff = 0.5,
            qvalueCutoff = 1,
            readable = T)

gene.GO <- as.data.frame(gene.GO)

write.csv(gene.GO,"gene.GO_up.csv")
