## Setting up conda environments for processing genomics files

### Reticulate in R
```
conda create -y -n r-reticulate numpy leidenalg umap-learn
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

### Peak calling with MACS2
```
conda create -y -n peaks macs2
conda activate peaks
```
And then in ```R```, calling ```macs2``` with
```
peaks <- CallPeaks(atac.seurat.object, assay = 'ATAC', macs2.path = '/fast/work/users/$USER/bin/miniconda3/envs/peaks/bin/macs2')
````
Replacing ```$USER``` with your username.

### Mitochondrial genotyping using ```mgatk```

```
conda create -y -n mito r-data.table r-matrix bioconductor-genomicranges bioconductor-summarizedexperiment
conda activate mito
pip install mgatk
export PATH=/fast/work/groups/ag_romagnani/bin/jdk-18/bin:$PATH
```

### Doublet annotation of scATAC-seq data using ```AMULET```
```
conda create -y -n amulet numpy=1.21 pandas scipy statsmodels
conda activate amulet
```