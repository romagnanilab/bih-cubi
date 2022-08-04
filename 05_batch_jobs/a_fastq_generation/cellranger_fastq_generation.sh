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

export PATH=/u/$USER/bin/cellranger-7.0.0:$PATH # it doesn't matter which cellranger you use, it is all a wrapper for bcl2fastq2
export PATH=/u/$USER/bin/bcl2fastq2-v2.20.0/bin:$PATH

project_id="example" # enter project ID between quotation marks, usually eh run ID from provider
library_type="example" # usually either, atac, gex, or cite
bases_mask="Y103,I8,Y24,Y103" # This is an EXAMPLE - will be found in sequencing requirements info, or see github page for suggestions
scripts=/u/$USER/data/$project_id/${project_id}_scripts/

cellranger mkfastq --id=${project_id}_fastq_${library_type} --run=${project_id}_bcl --csv=$scripts/${library_type}_indices.csv --use-bases-mask=$bases_mask
