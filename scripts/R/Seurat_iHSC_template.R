# Plantilla Seurat para scRNA-seq de Ng et al. iHSC

library(Seurat)

# counts <- Read10X('../data_raw/scRNAseq_Ng2025/RM_TOM_sample1')
# obj <- CreateSeuratObject(counts = counts, project = 'Ng_iHSC')

# obj <- NormalizeData(obj)
# obj <- FindVariableFeatures(obj)
# obj <- ScaleData(obj)
# obj <- RunPCA(obj)
# obj <- FindNeighbors(obj)
# obj <- FindClusters(obj, resolution = 0.5)
# obj <- RunUMAP(obj, dims = 1:20)

hsc_genes <- c('RUNX1','MECOM','MLLT3','HLF','HOXA9','SPINK2')
# obj <- AddModuleScore(obj, features = list(HSC_signature = hsc_genes), name = 'HSC_Score')
