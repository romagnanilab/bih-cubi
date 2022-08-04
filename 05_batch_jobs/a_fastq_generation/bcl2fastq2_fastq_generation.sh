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

export PATH=/u/oknight/bin/bcl2fastq2-v2.20.0/bin:$PATH

project_id="example" # enter project ID between quotation marks, usually eh run ID from provider
project_dir=/u/$USER/data/$project_id/
library_type="example" # usually either, atac, gex, or cite
bases_mask="Y103,I8,Y24,Y103" # This is an EXAMPLE - will be found in sequencing requirements info, or see github page for suggestions


bcl2fastq --use-bases-mask=$bases_mask \
  --create-fastq-for-index-reads \
  --minimum-trimmed-read-length=8 \
  --mask-short-adapter-reads=8 \
  --ignore-missing-positions \
  --ignore-missing-controls \
  --ignore-missing-filter \
  --ignore-missing-bcls \
  -R $project_dir/${project_id}_bcl\
  --output-dir=$project_dir/${project_id}_fastq_${library_type} \
  --interop-dir=$project_dir/${project_id}_fastq_${library_type}/InterOp \
  --sample-sheet=$project_dir/${project_id_}scripts/cite_indices.csv
  