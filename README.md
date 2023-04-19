# BIH-CUBI HPC Guide

The Romagnani lab works on the [Berlin Institute of Health-Core Bioinformatics Unit (BIH-CUBI) High Performance Computing (HPC) cluster](https://www.hpc.bihealth.org/) for bioinformatics analyses. This allows several advantages including more storage space, faster workloads, and more flexible and shared analysis pipelines.  

Access to the >> **[BIH Dashboard](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/)** <<

## Cheat commands you might like:
`wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh`  
`bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda3 && rm Miniconda3-latest-Linux-x86_64.sh`  
`srun --time 1-00 --ntasks=8 --mem=16G  --pty bash -i`


Several support options are available if you run into errors (in order of what you should check first):  
1. The BIH-CUBI HPC [documents](https://bihealth.github.io/bih-cluster/)  
2. Timo and Ollie  
3. The BIH-CUBI HPC [blog](https://hpc-talk.cubi.bihealth.org/) for posting and helping with issues  
4. The HPC helpdesk (hpc-helpdesk@bih-charite.de), explaining your problem according to [these guidelines](https://bihealth.github.io/bih-cluster/help/good-tickets/)  


To do list:  
- ```rclone``` replacement for data migration and archiving  
- Etiquette for the ```ag_romagnani``` group folder  
- Guides sequencing methods (base masks etc), understanding outs  
