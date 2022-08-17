#!/bin/bash

# output and error file locations
#SBATCH -o /fast/work/users/$USER/slurm/%j.out
#SBATCH -e /fast/work/users/$USER/slurm/%j.err

# job name, shown in 'squeue' function:
#SBATCH --job-name="fastq-1"

# working directory:
#SBATCH -D /fast/work/users/$USER/

# ram and cpu request:
#SBATCH --ntasks=72
#SBATCH --mem=120000

# e-mail upon error/completion to...
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --mail-user=user@charite.de

# wall clock limit in h, m, s:
#SBATCH --time=2:00:00

module purge

# edit me
project_id="example" # enter project ID between quotation marks, usually the run ID from provider

# leave me alone
export PATH=/fast/work/groups/ag_romagnani/bin/cellranger-7.0.0:$PATH # multi counting, for gene expression, feature barcoding, and immune profiling, requires cellranger base
scripts_dir=/fast/work/users/$USER/data/${project_id}_scripts/
bcl_dir=/fast/work/users/$USER/data/${project_id}_bcl/
project_dir=/fast/scratch/users/$USER/$project_id

mkdir -p $project_dir/${project_id}_outs && cd $project_dir/${project_id}_outs

#sample1
sample="example"

cellranger multi --id=$sample --csv=$scripts_dir/multi_sample1_indices.csv