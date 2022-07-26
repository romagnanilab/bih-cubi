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

#edit me
project_id="example" # enter project ID between quotation marks, usually the run ID from provider
library_type="example" # usually either, atac, gex, cite, vdj
bases_mask="Y103,I8,Y24,Y103" # This is an EXAMPLE - will be found in sequencing requirements info, or see github page for suggestions

#leave me alone
export PATH=/fast/work/groups/ag_romagnani/bin/bcl2fastq2-v2.20.0/bin:$PATH
export PATH=/u/$USER/bin/cellranger-7.0.0:$PATH # whatever your experiment, the cellranger called is just a wrapper for bcl2fastq2
mkdir -p /fast/work/users/$USER/slurm/
mkdir -p /fast/scratch/users/$USER/$project_id
scripts_dir=/fast/work/users/$USER/data/${project_id}_scripts/
bcl_dir=/fast/work/users/$USER/data/${project_id}_bcl/
outs_dir=/fast/scratch/users/$USER/$project_id

#leave me alone

cd data/$project_id

cellranger mkfastq --id=${project_id}_fastq_${library_type} --run=$bcl_dir --csv=$scripts_dir/${library_type}_indices.csv --use-bases-mask=$bases_mask
