## Setting up conda environments for processing genomics files

### Single cell annotation tools

```
mamba create -y -n sctools -c bih-cubi kallisto bustools numpy=1.21.0 pandas scipy statsmodels r-data.table r-matrix bioconductor-genomicranges bioconductor-summarizedexperiment java-jdk cellsnp-lite libgcc bcl2fastq2
pip install mgatk vireoSNP
```

### Reticulate in R
```
mamba create -y -n sc_python numpy leidenalg umap-learn macs2 scanpy scvi-tools
conda activate sc_python
```

Then, in R, start your script with
```
Sys.setenv(RETICULATE_MINICONDA_PATH = '/fast/work/users/$USER/bin/miniconda3/')
Sys.setenv(PATH= paste('/fast/work/users/$USER/bin/miniconda3/envs/sc_python/lib/python3.11/site-packages/',Sys.getenv()["PATH"],sep=":"))
library(reticulate)
use_miniconda('/fast/work/users/$USER/bin/miniconda3/envs/sc_python/')
```
Replacing ```$USER``` with your username.

And for MACS2 peaks calling:
```
peaks <- CallPeaks(atac.seurat.object, assay = 'ATAC', macs2.path = '/fast/work/users/$USER/bin/miniconda3/envs/peaks/bin/macs2')
````
Replacing ```$USER``` with your username, again.
