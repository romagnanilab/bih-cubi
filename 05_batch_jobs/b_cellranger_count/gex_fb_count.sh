#!/bin/bash

# Output and error
#SBATCH -o /u/$USER/slurm/%j.out
#SBATCH -e /u/$USER/slurm/%j.err

# Job name, 8 characters
#SBATCH --job-name="job_name"

# Directory:
#SBATCH -D /u/$USER/

# What do you want to request? cores, RAM:
#SBATCH --ntasks=72
#SBATCH --mem=120000

# email upon error/completion to...
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --mail-user=user@charite.de

# wall clock limit in h, m, s:
#SBATCH --time=6:00:00

module purge # ensure no modules are loaded

export PATH=/u/$USER/bin/cellranger-7.0.0:$PATH # multi counting, for gene expression, feature barcoding, and immune profiling, requires cellranger base

mkdir $project_dir/${project_id}_outs -p && $project_dir/${project_id}_outs

project_id="example" # enter project ID between quotation marks, usually eh run ID from provider
project_dir=/u/$USER/data/$project_id/
ref="/u/oknight/ref/hs/refdata-gex_GRCh38-2020-A" # the hardmasked reference genome is required for extracting mitochondrial mutations later

sample="example"
cellranger count --id=$sample --libraries=$project_dir/${project_id}_scripts/gex_fb_${sample}.csv --transcriptome=$ref --feature-ref=$project_dir/${project_id}_scripts/cite.csv