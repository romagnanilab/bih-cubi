#!/bin/bash

# Output and error
#SBATCH -o /u/$USER/slurm/%j.out
#SBATCH -e /u/$USER/slurm/%j.err

# Job name:
#SBATCH --job-name="fastq-a"

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
#SBATCH --time=4:00:00

module purge # ensure no modules are loaded

export PATH=/u/$USER/bin/cellranger-arc-2.0.1:$PATH # multiome libraries reqire cellranger arc

project_id="example" # enter project ID between quotation marks, usually eh run ID from provider
project_dir=/u/$USER/data/$project_id/
ref="/u/oknight/ref/hs/refdata-arc-hardmasked-GRCh38-2.0.1" # the hardmasked reference genome is required for extracting mitochondrial mutations later

mkdir $project_dir/${project_id}_outs -p && $project_dir/${project_id}_outs

sample="sample1"
cellranger-arc count --id=${sample} --reference=${ref} --libraries=$project_dir/${project_id}_scripts/multiome_${sample}.csv