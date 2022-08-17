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

module load R/4.0.4
module load jdk/11.0.8
source /fast/work/groups/ag_romagnani/bin/miniconda3/etc/profile.d/conda.sh
conda activate

# edit me
project_id="example" # enter project ID between quotation marks, usually the run ID from provider

# leave me alone
multiome_outs=/fast/scratch/users/$USER/$project_id/${project_id}_outs/multiome/
mkdir /fast/scratch/users/$USER/$project_id/${project_id}_outs/mito -p

sample="example"
cd $multiome_outs/$sample/outs/filtered_feature_bc_matrix && cp barcodes.tsv.gz barcodes1.tsv.gz && gunzip barcodes1.tsv.gz && cd $multiome_outs/
mgatk tenx -i $multiome_outs/$sample/outs/atac_possorted_bam.bam -n $sample -o $multiome_outs/mito/$sample/ -bt CB -b $multiome_outs/$sample/outs/filtered_feature_bc_matrix/barcodes1.tsv -c 32
rm $multiome_outs/$sample/outs/filtered_feature_bc_matrix/barcodes1.tsv