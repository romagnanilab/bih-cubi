## Updating your existing Seurat Installation
```
mamba create -n sc_v5 r-tidyverse r-hdf5r r-devtools r-seurat r-r.utils
remotes::install_github("mojaveazure/seurat-object", "seurat5")
remotes::install_github("mojaveazure/seurat-disk", "feat/h5ad")
remotes::install_github("satijalab/seurat-data", "seurat5")
remotes::install_github("satijalab/seurat", "seurat5")
remotes::install_github("satijalab/azimuth", "seurat5")
remotes::install_github("stuart-lab/signac", "seurat5")
```
