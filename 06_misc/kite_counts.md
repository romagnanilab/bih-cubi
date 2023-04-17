# Processing TotalSeqA antibody counts

## From single-, paired-end, or mtASAP-seq

<details>
  <summary>Set up conda environment</summary>
  
  ```
  source ~/work/bin/miniconda3/etc/profile.d/conda.sh
  conda install mamba
  mamba create -y -n sctools python kallisto bustools
  conda activate sctools
  ```
  
</details>

## Converting ASAP-seq CITE to counts

An ADT library from ASAP-seq is sequenced as ATAC-seq reads (R1,R2,R3), it needs to be converted to files readable by kallisto. We download two files for this:

```
cd ~/work/bin
mkdir asap && cd asap
wget https://raw.githubusercontent.com/caleblareau/asap_to_kite/master/asap_to_kite_v2.py
wget https://raw.githubusercontent.com/pachterlab/kite/master/featuremap/featuremap.py
```

Extract our counts

```
asap="~/work/bin/asap/asap_to_kite_v2.py"
project_id=""
project_dir=/scratch/tmp/${project_id}
fastq=${project_dir}/${project_id}/${project_id}_fastq_adt/outs/fastq_path/

sample=
python ${asap}/asap_to_kite_v2.py -f {FASTQ} -s $fastq/${fastq_name}_adt*L001*R1* $fastq1/${fastq_name}_adt*L001*R2* $fastq1/${fastq_name}_adt*L002*R1* $fastq1/${fastq_name}_adt*L002*R2* -o fastq/sample_fastq

kite="~/work/bin/asap/featuremap.py"
fiveprime_whitelist="~/work/bin/cellranger-7.0.1/lib/python/cellranger/barcodes/737K-august-2016.txt"
threeprime_whitelist='~/work/bin/cellranger-7.0.1/lib/python/cellranger/barcodes/3M-february-2018.txt'
ASAP=/u/${USER}/bin/asap
FASTQ=/u/${USER}/data/runID/runID_fastq_cite
ATAC_CELLS=/u/${USER}/bin/cellranger-atac-1.2.0/cellranger-atac-cs/1.2.0/lib/python/barcodes/737K-cratac-v1.txt

mkdir /u/${USER}/data/runID/runID_cite_outs/ && cd /u/${USER}/data/runID/runID_cite_outs/
mkdir fastq




python ${ASAP}/featuremap.py adt.csv --t2g FeaturesMismatch.t2g --fa FeaturesMismatch.fa --header --quiet
kallisto index -i FeaturesMismatch.idx -k 15 FeaturesMismatch.fa

kallisto bus -i FeaturesMismatch.idx -o ../runID_cite_outs/ -x 10xv2 -t 40 ${FASTQ}/sample_*

bustools correct -w ${ATAC_CELLS} output.bus -o output_corrected.bus
bustools sort -t 40 -o output_sorted.bus output_corrected.bus
bustools count -o sample_cite/ --genecounts -g FeaturesMismatch.t2g -e matrix.ec -t transcripts.txt output_sorted.bus
```



```
source /u/${USER}/bin/miniconda3/etc/profile.d/conda.sh
conda activate

export PATH=/u/${USER}/bin/kallisto:$PATH
export PATH=/u/${USER}/bin/bustools/build/src:$PATH

ASAP=/u/${USER}/bin/asap
FASTQ=/u/${USER}/data/runID/runID_fastq_cite

ARC_CELLS=/u/${USER}/bin/cellranger-arc-2.0.1/lib/python/cellranger/barcodes/737K-arc-v1-2.txt

python ${ASAP}/featuremap.py adt.csv --t2g FeaturesMismatch.t2g --fa FeaturesMismatch.fa --header --quiet

kallisto index -i FeaturesMismatch.idx -k 15 FeaturesMismatch.fa

kallisto bus -i FeaturesMismatch.idx -o ../runID_cite/ -x 10xv3 -t 40 ${FASTQ}/sample_*

bustools correct -w ${ARC_CELLS} output.bus -o output_corrected.bus
bustools sort -t 40 -o output_sorted.bus output_corrected.bus
bustools count -o sample_cite/ --genecounts -g FeaturesMismatch.t2g -e matrix.ec -t transcripts.txt output_sorted.bus
```
