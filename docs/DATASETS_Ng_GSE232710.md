# DATASETS_Ng_GSE232710

Este documento resume cómo organizar los datos en el repositorio. Consulta también el README principal para más contexto.

## 1. scRNA-seq Ng et al. 2025

- Descarga las matrices 10X Genomics (cuando estén disponibles) asociadas al artículo.
- Colócalas en `data_raw/scRNAseq_Ng2025/` en subcarpetas por muestra.
- Usa `scripts/python/build_scRNAseq_h5ad.py` o el script R de Seurat para generar un objeto único.

## 2. Bulk RNA-seq GSE232710

- Descarga `GSE232710_RAW.tar` y la Series Matrix desde GEO.
- Guárdalos en `data_raw/GSE232710_bulk/`.
- Ejecuta `scripts/python/unpack_GSE232710.py` para descomprimir.
- Crea un archivo `matrix_processed.tsv` con los counts filtrados y un `metadata_samples.tsv` con información de condición, día, RETA vs NIL.
