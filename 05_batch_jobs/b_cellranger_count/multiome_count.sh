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
ref="/fast/work/groups/ag_romagnani/ref/hs/refdata-arc-hardmasked-GRCh38-2.0.1" # the hardmasked reference genome is required for extracting mitochondrial mutations later


export PATH=/fast/work/groups/ag_romagnani/bin/cellranger-arc-2.0.1:$PATH # multiome libraries reqire cellranger arc
# leave me alone
scripts_dir=/fast/work/users/$USER/data/${project_id}_scripts/
bcl_dir=/fast/work/users/$USER/data/${project_id}_bcl/
project_dir=/fast/scratch/users/$USER/$project_id

mkdir -p $project_dir/${project_id}_outs/multiome/ && cd $project_dir/${project_id}_outs/multiome/

#sample1
sample="example"

cellranger-arc count --id=$sample --reference=$ref --libraries=$scripts_dir/multiome_${sample}.csv