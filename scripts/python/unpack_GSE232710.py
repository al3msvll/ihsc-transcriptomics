"""Descomprime GSE232710_RAW.tar después de descargarlo manualmente desde GEO."""

import tarfile
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parents[2]
raw_dir = BASE_DIR / 'data_raw' / 'GSE232710_bulk'
tar_path = raw_dir / 'GSE232710_RAW.tar'

if tar_path.exists():
    with tarfile.open(tar_path, 'r') as tar:
        tar.extractall(raw_dir / 'GSE232710_RAW')
    print('Descomprimido en', raw_dir / 'GSE232710_RAW')
else:
    print('No se encontró GSE232710_RAW.tar. Descárgalo primero desde GEO.')
