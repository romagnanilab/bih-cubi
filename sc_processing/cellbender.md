# Processing scRNA-seq and CITE-seq with [Cellbender](https://github.com/broadinstitute/CellBender)
## Setting up miniconda environment
```
maba create -y -n cellbender python=3.7
conda activate cellbender
mamba install -c anaconda pytables
pip install torch
python -c 'import torch; print(torch.cuda.is_available())'
pip install --no-cache-dir -U git+https://github.com/broadinstitute/CellBender.git@sf_dev_0.3.0_postreg
```
## Acessing a GPU node
https://bihealth.github.io/bih-cluster/how-to/connect/gpu-nodes/#allocating-gpus
