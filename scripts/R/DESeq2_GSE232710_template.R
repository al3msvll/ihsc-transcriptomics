# Plantilla DESeq2 para GSE232710

library(DESeq2)
library(readr)
library(dplyr)

counts <- read_tsv('../data_raw/GSE232710_bulk/matrix_processed.tsv')
meta   <- read_tsv('../data_raw/GSE232710_bulk/metadata_samples.tsv')

gene_ids <- counts[[1]]
counts_mat <- as.matrix(counts[,-1])
rownames(counts_mat) <- gene_ids

meta$condition <- factor(meta$condition)

dds <- DESeqDataSetFromMatrix(countData = counts_mat,
                              colData   = meta,
                              design    = ~ condition)

dds <- DESeq(dds)
res <- results(dds, contrast = c('condition','RETA','NIL'))

res_tbl <- as.data.frame(res)
res_tbl$gene <- rownames(res_tbl)
res_tbl <- arrange(res_tbl, padj)

readr::write_tsv(res_tbl, '../results/tables/DESeq2_GSE232710_RETA_vs_NIL.tsv')

reta_up <- res_tbl %>% filter(padj < 0.05, log2FoldChange > 0.5) %>% pull(gene)
readr::write_lines(reta_up, '../results/tables/02_up_genes.txt')
