**1. Navigate to [this page](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/).** You must be connected to the Charite VPN to access this page

**2. In the top bar, go to ```Interactive Apps``` then ```RStudio Server```**  
Here, you can customise the session you want.

```
R source: miniconda # change from 'singularity'
Miniconda path: ~/bin/miniconda3/bin:r-sc # Point it towards the R environment we just made
Singularity image: # leave as is
Number of cores: 32 # your choice
Memory [GiB]: 64 # also your choice
Running time [days]: 14
Partition to run in: long
```  

When you launch this, it will queue the request as it goes through the ```slurm``` workload manager. It will then automatically update when it is running, and you can launch the session.

When you log in, and at the top of all your future scripts, make sure to explicitly tell R where your packages are installed, and will be installed in the future. This can be achieved with:  

**Close** the R session, and go back to your terminal. You should see two new folders in your home directory, ```ondemand``` and ```R```. Perform these steps:

```
cd # change to home directory
ls # to check
mv ondemand work/bin/
ln -s ~/work/bin/ondemand ondemand

rm -r R
ln -s ~/work/bin/miniconda3/envs/r-sc/lib/R/library/ R
```
