## Setting up conda envs for processing sequencing files

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
