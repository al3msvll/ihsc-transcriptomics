"""Construye un objeto .h5ad a partir de múltiples carpetas 10X de Ng et al."""

from pathlib import Path
import scanpy as sc

BASE_DIR = Path(__file__).resolve().parents[2]
root = BASE_DIR / 'data_raw' / 'scRNAseq_Ng2025'
out_path = BASE_DIR / 'data_processed' / 'iHSC_scRNAseq_Ng2025.h5ad'

adatas = []

for sample_dir in root.glob('*'):
    if sample_dir.is_dir():
        print('Leyendo', sample_dir)
        ad = sc.read_10x_mtx(sample_dir, var_names='gene_symbols')
        ad.obs['sample'] = sample_dir.name
        adatas.append(ad)

if adatas:
    adata = adatas[0].concatenate(adatas[1:], join='outer')
    adata.write_h5ad(out_path)
    print('Guardado en', out_path)
else:
    print('No se encontraron directorios 10X en', root)
