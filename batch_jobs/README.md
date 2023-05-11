The main advantage of migrating everyone to the BIH-CUBI HPC is that we have exponentially increased our access to computing resources. This not only allows people to have much more computing power for their R sessions, but also to be able to run their own processing pipelines for sequencing data.  
This is performed once again using the ```slurm``` workload management system, which allocates your job to a set of cores and RAM using the ```sbatch``` command. Here, you set several parameters for your job. An example script for this is in the file ```sbatch_cellranger_count.sh```  

Below you will find the first part of this script, which ```slurm``` reads prior to performing your command. Note each line to see its function.

```
#!/bin/bash # this is the language used, and necessary to be the first line of the script. Note that each directory should be absolute; i.e. starts with a forward slash such as /home/oknight

# output and error
#SBATCH -o /u/oknight/slurm/%j.out # this is where each printed line from the command will be stored in a text file
#SBATCH -e /u/oknight/slurm/%j.err # should your script fail, the error message will be printed here

# Job Name:
#SBATCH --job-name="eae"

# Directory:
#SBATCH -D /u/oknight/data/S6088

# Node features:
#SBATCH --ntasks=64
#SBATCH --mem=128000
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --mail-user=oliver.knight@charite.de

# wall clock limit:
#SBATCH --time=6:00:00

export PATH=/u/oknight/bin/cellranger-7.0.0:$PATH
```
