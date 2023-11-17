# BIH-CUBI HPC Guide

The Romagnani lab works on the [Berlin Institute of Health-Core Bioinformatics Unit (BIH-CUBI) High Performance Computing (HPC) cluster](https://www.hpc.bihealth.org/) for bioinformatics analyses.

For RStudio and JupterLab, go to the >> **[BIH Dashboard](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/)** <<

If you run into trouble using any part of the HPC, heres an order of where to look for guidance:  
1. The BIH-CUBI HPC [documents](https://bihealth.github.io/bih-cluster/)  
2. Ollie  
3. The BIH-CUBI HPC [question board](https://hpc-talk.cubi.bihealth.org/) for posting and helping with issues  
4. The HPC helpdesk (hpc-helpdesk@bih-charite.de), explaining your problem according to [these guidelines](https://bihealth.github.io/bih-cluster/help/good-tickets/)  

# Contents

**[VPN access and requesting an account]()**  
**[Connecting to the cluster]()**  
**[Setting up your work environment]()**  
**[Setting up an RStudio session]()**  


# VPN access and requesting an account

1. **Fill in both VPN forms,** ```vpn_antrag.pdf```**, and** ```vpn_zusatzantrag_b.pdf```  
Print and sign both of these, scan them in and attach both files to an e-mail *sent from your charite e-mail address* to vpn@charite.de, with a subject line such as 'surname, firstname, VPN access'. Please also cc Chiara (chiara.romagnani@charite.de) so that the VPN gatekeepers know you have group leader-authorised permission.

2. **For personal computer access, install OpenVPN and configure your connection**  
Refer to either installation on macOS (```vpn_macOS_installation.pdf```) or Windows (```vpn_Windows_installation.pdf```)

If you have *any* issues with any of the steps below, feel free to ask Ollie for help. You can also check out the BIH-CUBI cluster guide [here](https://bihealth.github.io/bih-cluster/).

3. **Applying for an HPC user account**  

The below form must be filled in and forwarded to the named delegate (i.e. oliver.knight@charite.de)

```
- cluster: HPC 4 Research
- first name:
- last name:
- affiliation: Charite, Department of Gastroenterology
- institute email: # charite e-mail
- institute phone:
- user has account with
    - [ ] BIH
    - [x] Charite
    - [ ] MDC
- BIH/Charite/MDC user name: #this will be in the format surname+firstnameinitial without the plus
- duration of cluster access (max 1 year): 1 year
- AG: ag-romagnani
```

This will then be fowarded to hpc-gatekeeper@bihealth.de with you and Chiara in cc.

# Connecting to the cluster

**1. Login to the CUBI dashboard through your browser**   

Go [here](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/) here to log in to access the Dashboard.  
***a. Work computer Windows login***  
Login with your username in this format: ```username@CHARITE```  

***b. Work Mac or personal computer/laptop***  
Login with your Charite credentials, i.e. ```username```

<details>
  <summary>Optional - terminal connection</summary>
    
**2. Creating a secure shell (ssh) key**  

a. Type ```ssh-keygen -t rsa -C "your_email@charite.de"``` # leaving the quotation marks, enter your e-mail.  

c. Use the default location for storing your ssh key (press enter), and type a secure password in to store it.  

d. Locate the ```.ssh/id_rsa.pub``` file in your file explorer and open with notepad/textedit. You may need to enable the 'show hidden files and folders' setting in your control panel.  

e. Copy the contents; it should look something like  
```ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/Rdd5rf4BT38jsBlRrXpd1KDvjE1iZZlEmkB6809QK7hV6RCG13VcyPTIHSQePycfcUv5q1Jdy28MpacL/nv1UR/o35xPBn2HkgB4OqnKtt86soCGMd9/YzQP5lY7V60kPBJbrXDApeqf+H1GALsFNQM6MCwicdE6zTqE1mzWVdhGymZR28hGJbVsnMDDc0tW4i3FHGrDdmb7wHM9THMx6OcCrnNyA9Sh2OyBH4MwItKfuqEg2rc56D7WAQ2JcmPQZTlBAYeFL/dYYKcXmbffEpXTbYh+7O0o9RAJ7T3uOUj/2IbSnsgg6fyw0Kotcg8iHAPvb61bZGPOEWZb your_email@charite.de```

f. Go to https://zugang.charite.de/ and log in as normal. Click on the blue button ```SSHKeys...```, paste the key from your ```.ssh/id_rsa.pub``` file, and click append.  

**4. Connect to the cluster**  
a. Type
```ssh-add```  

b. Go to the ```~/.ssh/``` folder and create a new text file. paste the below in, adding your username and leaving the '_c', and save, *without* a file extension.  
```
Host bihcluster
    ForwardAgent yes
    ForwardX11 yes
    HostName hpc-login-1.cubi.bihealth.org
    User username_c
    RequestTTY yes

Host bihcluster2
    ForwardAgent yes
    ForwardX11 yes
    HostName hpc-login-1.cubi.bihealth.org
    User username_c
    RequestTTY yes
```

c. Then, you can simply type   
```ssh bihcluster```  
Enter the password you set during **step 2** and connect into the login node. Proceed directly to the instructions in [03_work_environment](https://github.com/romagnanilab/bih-cubi/tree/main/03_work_environment)

</details>

# Setting up your work environment

Upon connecting using the ```ssh bihcluster``` command, or through ```Clusters -> _cubi Shell Access``` on the Dashboard, you'll find yourself in a login node. **Do not** run anything here as there is limited RAM and CPU for anything, it is only intended for running ```tmux``` sessions.  

**1. Creating an interactive session** 

tmux is essentially a new window for your command line. You can attach and detach these and they will run in the background even when you close your terminal window.  

To begin:
```
tmux new -s cubi # create a new tmux session with the name 'cubi'
```

You can detach this at any time by pressing CTRL+b, letting go, and pressing the d key. You can reattach at any time in 'base' command windows by typing ```tmux a -t cubi```, or simply ```tmux a``` to attach your last accessed session.  

Next, we will ask the workload managing system ```slurm``` to allocate us some cores and RAM.

```srun --time 1-00 --ntasks 8 --mem 16G  --pty bash -i```  

This creates a session which will last 1 day, reserve 8 cores, and 16Gb RAM. From here, we can install software, packages, extract files and run programs.

**2. Setting up a workspace environment**

From here, how you set up your workspace is entirely your decision. However it important to understand how the file structure of the BIH-CUBI cluster is set up:

- Your home directory, ```/data/gpfs-1/users/${USER}```, or also sometimes written ```/fast/users/$USER``` is only 1Gb in space and should not contain anything other than *links* to other folders; already set up are ```/fast/scratch/users/${USER}``` and ```/fast/work/users/${USER}```.  
- Your ```scratch/``` folder has a quota of 200 Tb; however, files are deleted after 2 weeks from the time of their creation. This will be where large data such as sequencing runs and processing pipelines will work out of. It is possible to ```touch``` files to keep them here longer.
- Your ```work/``` folder has a hard quota of 1 Tb and is for non-group personal use.
- Finally, there is the ```/fast/groups/ag_romagnani/``` folder, where communal programs, scripts and reference genomes/files are kept.  

You can at any time check your quota with the command ```bih-gpfs-quota-user user_c```

Below is a set of instructions to install miniconda3, which is required to install Seurat and other R packages.

```
# link the group folder, and set up your work/bin/ folder
ln -s /fast/work/groups/ag_romagnani/ group
cd /fast/work/users/${USER}/ && mkdir bin/ && cd bin/

# download, install, and update miniconda 
curl -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -o Mambaforge-Linux-x86_64.sh
bash Mambaforge-Linux-x86_64.sh -b -p ~/work/bin/mambaforge && rm Mambaforge-Linux-x86_64.sh
source mambaforge/etc/profile.d/conda.sh && conda activate

# modify conda repos 
cd && nano .condarc

# copy and paste this into nano (CTRL+C here, right click to paste)
channels:
  - conda-forge
  - bioconda
  - defaults
show_channel_urls: true
changeps1: true
channel_priority: strict
# close by CTRL+X and y and enter

mamba upgrade --all -y

mamba env create -n #your_env_name_here -f ~/group/work/ref/seurat/sc_R.yml
```

Here, we make a folder called `bin` in your work directory, and then download and install miniconda. We install a `conda` alternative named `mamba`, which is much faster to create and install environments and packages. We then use it to create our R environment named `sc_R', but you can name this whatever you want.

If at any point you come into errors installing packages through RStudio directly, try using this format while in the `sc_R` conda environment: `mamba install r-package`, replacing the word 'package' with what you want to install. The 'r-' prefix indicates it's an `R` package, and not a python one.

# Setting up an RStudio session
In terminal, perform:  
```
mkdir ~/work/bin/ondemand/dev && cd ~/work/bin/ondemand/dev
git clone https://github.com/bihealth/ood-bih-rstudio-server.git
nano ~/work/bin/ondemand/dev/ood-bih-rstudio-server/template/script.sh.erb

# under export LD_LIBRARY_PATH=/usr/lib64/:\$LD_LIBRARY_PATH, add:
export LD_PRELOAD=/fast/work/users/{$USER}/bin/miniconda3/envs/sc/lib/libstdc++.so.6 
# save and close with CTRL + X, Y and enter
```

**1. Navigate to [this page](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/).** You must be connected to the Charite VPN to access this page

**2. In the top bar, go to `Interactive Apps` then the red `RStudio Server (Sandbox)`** button. It's important you choose the *Sandbox* RStudio server due to some ongoing package loading issues with the OnDemand platform.

From here, you can customise the session you want.

```
**R source:** change to miniconda  
**Miniconda path:** ~/bin/miniconda3/bin:sc_R  
**Singularity image:** *leave as is*  
**Number of cores:** Maximum 32
**Memory [GiB]:** Maximum 128  
**Running time [days]:** Maximum 14, recommended 1  
**Partition to run in:** medium
```

When you launch this, it will queue the request as it goes through the `slurm` workload manager. It will then automatically update when it is running, and you can launch the session. If it is taking too long, reduce the cores, memory, and running time. 16 cores, 64 Gb RAM, and 1 day often works well.

**3.** Close the R session, and go back to your terminal. You should see two new folders in your home directory, `ondemand` and `R`. Perform these steps:

```
cd # change to home directory
ls # to check where you are
mv .config work/bin/ && ln -s ~/work/bin/.config .config
mv .cache work/bin/ && ln -s ~/work/bin/.cache .cache
mv .local work/bin/ && ln -s ~/work/bin/.local .local
mv ondemand work/bin/ && ln -s ~/work/bin/ondemand ondemand
```
This creates symbolic links which moves certain default directories to a place where you have more space to do so.

## Installing common R packages
```
R
remotes::install_github('satijalab/azimuth')
remotes::install_github('satijalab/seurat-wrappers')
remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')
```  
