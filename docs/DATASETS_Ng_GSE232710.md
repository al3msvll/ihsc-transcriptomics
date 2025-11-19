## DATASETS_Ng_GSE232710

Este documento resume cómo organizar los datos en el repositorio. Consulta también el README principal para obtener todo el contexto.

*1.scRNA-seq Ng et al. 2025*
1.1. no son públicas por lo que no están disponibles ahora mismo
1.2. descarga las matrices 10X Genomics (cuando estén disponibles) asociadas al artículo.
1.3. colócalas en `data_raw/scRNAseq_Ng2025/` en subcarpetas por muestra.
1.4. usa `scripts/python/build_scRNAseq_h5ad.py` o el script R de Seurat para generar un objeto único.

*2.Bulk RNA-seq GSE232710*

2.1. descarga `GSE232710_RAW.tar` y la Series Matrix desde GEO.
2.2. guárdalos en `data_raw/GSE232710_bulk/`.
2.3. ejecuta `scripts/python/unpack_GSE232710.py` para descomprimir.
2.4. crea un archivo `matrix_processed.tsv` con los counts filtrados y un `metadata_samples.tsv` con información de condición, día, RETA vs NIL.
