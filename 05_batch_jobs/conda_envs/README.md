## Setting up conda environments for processing genomics files

### Reticulate in R
```
conda create -y -n r-reticulate numpy leidenalg umap-learn macs2
conda activate r-reticulate
```

Then, in R, start your script with
```
Sys.setenv(RETICULATE_MINICONDA_PATH = 
             '/fast/work/users/$USER/bin/miniconda3/')
Sys.setenv(PATH= paste('/fast/work/users/$USER/bin/miniconda3/envs/r-reticulate/lib/python3.11/site-packages/',Sys.getenv()["PATH"],sep=":"))
library(reticulate)
use_miniconda('/fast/work/users/$USER/bin/miniconda3/envs/r-reticulate/')
```
Replacing ```$USER``` with your username.

And for MACS2 peaks calling:
```
peaks <- CallPeaks(atac.seurat.object, assay = 'ATAC', macs2.path = '/fast/work/users/$USER/bin/miniconda3/envs/peaks/bin/macs2')
````
Replacing ```$USER``` with your username, again.

### Mitochondrial genotyping using ```mgatk```

```
conda create -y -n mito r-data.table r-matrix bioconductor-genomicranges bioconductor-summarizedexperiment java-jdk
conda activate mito
pip install mgatk
```

### Doublet annotation of scATAC-seq data using ```AMULET```
```
conda create -y -n amulet numpy=1.21 pandas scipy statsmodels
conda activate amulet
```
