# iHSC_multiomic_Ng2025_GSE232710

## Análisis Multi-ómico de la Diferenciación de Células Madre Hematopoyéticas Derivadas de iPSC

### Descripción general del proyecto

La finalidad de este proyecto es estudiar la diferenciación de células madre hematopoyéticas de larga duración (iHSCs) derivadas de células iPSC humanas, integrando datos de **scRNA-seq** y **RNA-seq bulk**. 

El análisis se basa en dos fuentes principales:

1. El trabajo de **Ng et al., Nature Biotechnology 2025**, donde se describen iHSCs con capacidad de injerto a largo plazo generadas a partir de iPSC humanas mediante un programa de mesodermo arterial y endotelio hemogénico.
2. El conjunto de datos **GSE232710 (Jacky Y. Li et al.)**, que recoge RNA mensajero en sobrenadantes de cultivos durante la fase de diferenciación, con y sin tratamiento con retinoide (RETA).

El objetivo es reproducir y extender los análisis de estos estudios, explorando cómo cambian los programas de expresión génica y las firmas de retinoides a lo largo de los distintos estados celulares del linaje iHSC.

---

## Contexto y motivo del estudio

La generación de células madre hematopoyéticas funcionales a partir de iPSC representa un paso clave hacia terapias de reemplazo hematopoyético personalizadas y modelos de enfermedad más precisos. Sin embargo, comprender en detalle los estados celulares intermedios (mesodermo arterial, endotelio hemogénico, pre-HSC, iHSC) y su regulación por señales como el ácido retinoico sigue siendo un reto.

Este análisis multi-ómico permite:

1. **Caracterizar** los estados celulares descritos por Ng et al. (endotelio arterial, HE, HSPC, progenitores) mediante scRNA-seq.
2. **Cuantificar** el impacto del tratamiento con retinoides y del tiempo de exposición usando RNA-seq bulk (GSE232710).
3. **Integrar** ambas capas de datos, proyectando firmas de expresión diferencial del bulk sobre las poblaciones celulares individuales, para identificar qué estados responden más fuertemente a los retinoides y a los programas HOXA/HSC.

---

## Fuentes de datos

Los datos que se utilizan en este proyecto provienen de repositorios públicos:

1. **Ng et al. 2025 – iHSC scRNA-seq**  
   Datos de scRNA-seq 10X Genomics asociados al artículo:  
   *Ng ES, Sarila G, Li JY, Edirisnghe IS, et al. Long-term engrafting multilineage hematopoietic cells differentiated from human induced pluripotent stem cells. Nat Biotechnol. 2025.*  
   (Accesión GEO/SRA cuando esté disponible).

2. **GSE232710 – Bulk RNA-seq de sobrenadantes de cultivo**  
   GEO: GSE232710.  
   Datos de RNA-seq obtenidos de sobrenadantes celulares PB BFP 3B5A con diferentes tiempos y condiciones de tratamiento con ácido retinoico (RETA vs control).  
   Incluye archivo suplementario `GSE232710_RAW.tar` (MTX/TSV) y Series Matrix procesada.

---

## Metodología

### 1. scRNA-seq (Ng et al.)

Para los datos de Ng et al., el flujo general es:

1. **Descarga y organización de matrices 10X** en `data_raw/scRNAseq_Ng2025/`.
2. **Conversión a AnnData / Seurat** usando los scripts de `scripts/python/build_scRNAseq_h5ad.py` o `scripts/R/Seurat_iHSC_template.R`.
3. **Control de calidad (QC)**: número de genes, UMIs, porcentaje mitocondrial.
4. **Normalización, PCA, vecinos, UMAP y clustering** usando Scanpy o Seurat.
5. **Anotación de clusters** (stroma, endothelium, hemogenic endothelium, HSPC, progenitores) mediante marcadores conocidos.
6. **Cálculo de firmas HSC** (por ejemplo, RUNX1, MECOM, MLLT3, HLF, HOXA9, SPINK2) y visualización en UMAP.

### 2. Bulk RNA-seq (GSE232710)

1. Descarga de `GSE232710_RAW.tar` y de la Series Matrix desde GEO.
2. Descompresión y organización de archivos en `data_raw/GSE232710_bulk/` usando `scripts/python/unpack_GSE232710.py`.
3. Construcción de una matriz de expresión y metadatos de muestra (condición, día, RETA vs NIL).
4. Análisis de expresión diferencial con **DESeq2** (`scripts/R/DESeq2_GSE232710_template.R`), generando tablas de resultados y listas de genes up/down.
5. Visualización mediante volcano plots y heatmaps.

### 3. Integración scRNA-seq + bulk

1. A partir de los resultados de DESeq2, se definen **conjuntos de genes firma** (por ejemplo `RETA_up`, `RETA_down`).  
2. Estas firmas se usan en los notebooks para calcular **module scores** en el objeto de scRNA-seq (Scanpy/Seurat).
3. Se visualizan las firmas en UMAP y se resumen los scores por cluster para identificar qué poblaciones celulares presentan mayor respuesta a RETA o a programas HOXA/HSC.

---

## Estructura del Repositorio

Este repositorio se organiza de la siguiente forma:

1. Un directorio principal con los archivos `README.md`, `.gitignore`, `LICENSE` (si se incluye) y archivos de entorno como `environment.yml` o `requirements.txt`.
2. Una carpeta `docs/` donde se documentan los datasets utilizados y notas metodológicas (`DATASETS_Ng_GSE232710.md`). 
3. Una carpeta `data_raw/` con subcarpetas para los datos brutos:
   - `scRNAseq_Ng2025/` para matrices 10X u objetos crudos del scRNA-seq.
   - `GSE232710_bulk/` para los archivos RAW y la Series Matrix del RNA-seq bulk.
4. Una carpeta `data_processed/` donde se guardan los objetos ya procesados (por ejemplo, `iHSC_scRNAseq_Ng2025_qc_norm.h5ad` o archivos `.rds`). 
5. Una carpeta `scripts/` que contiene scripts en Python y R para:
   - Descargar/organizar datos (`unpack_GSE232710.py`, `build_scRNAseq_h5ad.py`).
   - Ejecutar análisis estadísticos (`DESeq2_GSE232710_template.R`, `Seurat_iHSC_template.R`).
6. Una carpeta `notebooks/` que incluye cuadernos Jupyter para:
   - QC y clustering de scRNA-seq (`01_scRNAseq_iHSC_QC.ipynb`).
   - Análisis de expresión diferencial del bulk (`02_bulk_GSE232710_DE.ipynb`).
   - Integración de firmas bulk en scRNA-seq (`03_integration_sc_bulk.ipynb`).
7. Una carpeta `results/` dividida en:
   - `figures/` para las figuras generadas (UMAPs, volcano plots, heatmaps, etc.).
   - `tables/` para tablas de resultados (DESeq2, listas de genes, scores por cluster).
   - `models/` para objetos pesados (modelos entrenados u otros artefactos).
8. Una carpeta `src/` para funciones reutilizables y módulos de código, en caso de que se desarrolle una librería interna.

---

## Limitaciones del estudio

Este análisis está sujeto a varias limitaciones, entre ellas:

1. **Disponibilidad y formato de los datos de scRNA-seq**: hasta que los datos de Ng et al. estén completamente accesibles, algunos pasos se basan en plantillas y supuestos sobre el formato 10X.
2. **Calidad y homogeneidad de los datos bulk (GSE232710)**: diferencias en protocolos, tiempos de tratamiento y condiciones de cultivo pueden introducir ruido biológico y técnico.
3. **Anotación de tipos celulares**: la asignación de identidades celulares depende de marcadores conocidos y puede variar entre estudios.
4. **Modelado simplificado**: los modelos de integración (scorecards, module scores) capturan solo una parte de la complejidad regulatoria subyacente.

---

## Autores del proyecto

Autores: **Alejandra Martin Sevilla** (diseño del repositorio, flujo de análisis y documentación).  
El repositorio está pensado como plantilla docente y base para futuros proyectos de análisis de datos hematopoyéticos derivados de iPSC.

---

## Licencia

Este proyecto está pensado para ser distribuido bajo Licencia MIT (u otra licencia abierta equivalente).  
Eres libre de usar, modificar y distribuir este código, siempre que se incluya la nota de copyright y la declaración de la licencia.

---

## Referencias

1. Ng ES, Sarila G, Li JY, Edirisnghe IS, et al. Long-term engrafting multilineage hematopoietic cells differentiated from human induced pluripotent stem cells. *Nat Biotechnol.* 2025;43(8):1274–1287.  
2. Li JY, et al. GEO Series GSE232710: Bulk RNA-seq of PB BFP 3B5A supernatant under different retinoid treatments. *Gene Expression Omnibus (GEO)*.  
