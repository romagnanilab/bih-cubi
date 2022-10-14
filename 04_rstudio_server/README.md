**1. Navigate to [this page](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/).** You must be connected to the Charite VPN to access this page

**2. In the top bar, go to ```Interactive Apps``` then ```RStudio Server```**  
Here, you can customise the session you want.

```
R source: miniconda # change from 'singularity'
Miniconda path: /fast/work/users/${USER}/bin/miniconda3/bin:r-sc # Point it towards the R environment we just made
Singularity image: # leave as is
Number of cores: 32
Memory [GiB]: 64
Running time [days]: 28
Partition to run in: long
```  

When you launch this, it will queue the request as it goes through the ```slurm``` workload manager. It will then automatically update when it is running, and you can launch the session.

When you log in, and at the top of all your future scripts, make sure to explicitly tell R where your packages are installed, and will be installed in the future. This can be achieved with:  

```.libPaths('/fast/work/groups/ag_romagnani/bin/miniconda3/envs/r-sc/lib/R/library/')```

Going back to your terminal now, you will see two new folders in your home directory, ```ondemand``` and ```R```. Perform these steps to clean it all up:

```
cd && ln -sr ~/work/bin/miniconda3/envs/r-sc/lib/R/library/ ~/R
mv ondemand work/bin/ && ln -sr ~/work/bin/ondemand ~/ondemand
```
