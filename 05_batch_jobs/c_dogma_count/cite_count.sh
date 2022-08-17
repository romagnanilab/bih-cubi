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

export PATH=/fast/work/groups/ag_romagnani/bin/kallisto/build/src:$PATH
export PATH=/fast/work/groups/ag_romagnani/bin/bustools/build/src:$PATH
source /fast/work/groups/ag_romagnani/bin/miniconda3/etc/profile.d/conda.sh
conda activate

# edit me
project_id="example" # enter project ID between quotation marks, usually eh run ID from provider

# leave me alone
multiome_outs=/fast/scratch/users/$USER/$project_id/${project_id}_outs/
scripts_dir=/fast/work/users/$USER/data/${project_id}_scripts/
fastq_dir=/fast/scratch/users/$USER/$project_id/${project_id}_fastq_cite/
asap="/fast/work/groups/ag_romagnani/bin/asap/asap_to_kite_v2.py"
kite="/fast/work/groups/ag_romagnani/bin/asap/featuremap.py"
arc_whitelist="/fast/work/groups/ag_romagnani/bin/cellranger-arc-2.0.1/lib/python/cellranger/barcodes/737K-arc-v1.txt"

# create adt index
mkdir /fast/scratch/users/$USER/$project_id/${project_id}_outs/cite -p && cd  /fast/scratch/users/$USER/$project_id/${project_id}_outs/cite

python $kite $scripts_dir/kite_adt.csv --header
kallisto index -i FeaturesMismatch.idx -k 15 ./FeaturesMismatch.fa

# process sample

sample1="example"
kallisto bus -i FeaturesMismatch.idx -o ../cite -x 10xv3 -t 16 $fastq_dir/${sample1}_cite*
bustools correct -w $arc_whitelist output.bus -o output_corrected.bus
bustools sort -t 16 -o output_sorted.bus output_corrected.bus
bustools count -o $sample1/ --genecounts -g FeaturesMismatch.t2g -e matrix.ec -t transcripts.txt output_sorted.bus

rm !("$sample1"|"$sample2")