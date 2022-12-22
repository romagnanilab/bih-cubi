Upon connecting using the ```ssh bihcluster``` command, or through ```Clusters -> _cubi Shell Access``` on the Dashboard, you'll find yourself in a login node. **Do not** run anything here as there is limited RAM and CPU for anything, it is only intended for running ```tmux``` sessions.  

**1. Creating an interactive session** 

tmux is essentially a new window for your command line. You can attach and detach these and they will run in the background even when you close your terminal window.  

To begin:
```
tmux new -s cubi # create a new tmux session with the name 'cubi'
```

You can detach this at any time by pressing CTRL+b, letting go, and pressing the d key. You can reattach at any time in 'base' command windows by typing ```tmux a -t cubi```, or simply ```tmux a``` to attach your last accessed session.  

Next, we will ask the workload managing system ```slurm``` to allocate us some cores and RAM.

```srun -p medium --time 7-00 --mem=16G --ntasks=8 --pty bash -i```  

This creates a session which will last 7 days, reserve 16Gb RAM, and 8 cores. From here, we can install software, packages, extract files and run programs.

**2. Setting up a workspace environment**

From here, how you set up your workspace is entirely your decision. However it important to understand how the file structure of the BIH-CUBI cluster is set up:

- Your home directory, ```/data/gpfs-1/users/${USER}```, is only 1Gb in space and should not really contain anything other than *links* to other folders; already set up are ```/fast/scratch/users/${USER}``` and ```/fast/work/users/${USER}```.  
- Your ```scratch/``` folder has a hard quota of 220Tb; however, files are deleted after 2 weeks from the time of their creation. This will be where large data such as sequencing runs and processing pipelines will work out of.
- Your ```work/``` folder has a hard quota of 1.1Tb and is for non-group personal use.
- Finally, there is the ```/fast/groups/ag_romagnani/``` folder, where communal programs, scripts and reference genomes/files are kept.  
You can at any time check your quota with the command ```bih-gpfs-quota-user user_c```

Below is a set of instructions to install miniconda3, which is required to install Seurat and some other R dependencies.

```
# set up work/bin/ folder
cd /fast/work/users/${USER}/ && mkdir bin/ && cd bin/

# download, install, and update miniconda 
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p miniconda3 && rm Miniconda3-latest-Linux-x86_64.sh
source miniconda3/etc/profile.d/conda.sh && conda activate
conda upgrade --all
y

# modify conda repos 
cd && nano .condarc

# copy and paste this into nano (CTRL+C here, right click to paste in nano)
channels:
  - conda-forge
  - bioconda
  - defaults
show_channel_urls: true
changeps1: true
channel_priority: strict
# close by CTRL+X and y and enter

# create a conda environment called "r-sc" with the latest version of seurat
conda create -y -n sc r-tidyverse r-seurat r-hdf5r r-devtools
conda activate r-sc
```

# Temporary - due to issues with load packages

```
mkdir ~/work/bin/ondemand/dev && cd ~/work/bin/ondemand/dev
git clone https://github.com/bihealth/ood-bih-rstudio-server.git
nano ~/work/bin/ondemand/dev/ood-bih-rstudio-server/template/script.sh.erb

# under export LD_LIBRARY_PATH=/usr/lib64/:\$LD_LIBRARY_PATH, add:
export LD_PRELOAD=/fast/work/users/{$USER}/bin/miniconda3/envs/r-sc/lib/libstdc++.so.6 
# save and close
```

# install R packages, within R
```
R
remotes::install_github('satijalab/azimuth', ref = 'master')
install.packages('R.utils')
remotes::install_github('satijalab/seurat-wrappers')
remotes::install_github("mojaveazure/seurat-disk")
remotes::install_github("constantAmateur/SoupX")
remotes::install_github("immunogenomics/harmony")
BiocManager::install("scran")
```  

If at any point you come into errors installing packages through RStudio directly, try using this format while in the ```r-sc``` conda environment:  
```conda install -c conda-forge r-package```, replacing the word 'package' with what you want to install.
