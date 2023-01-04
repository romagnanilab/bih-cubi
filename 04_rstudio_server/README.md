## Setting up an RStudio session

**1. Navigate to [this page](https://hpc-portal.cubi.bihealth.org/pun/sys/dashboard/).** You must be connected to the Charite VPN to access this page

**2. In the top bar, go to ```Interactive Apps``` then ```RStudio Server (Sandbox)```**. It's important you choose the *Sandbox* RStudio server due to some ongoing package loading issues with the OnDemand platform.

From here, you can customise the session you want.

**R source:** miniconda  
**Miniconda path:** ~/bin/miniconda3/bin:sc  
**Singularity image:** *leave as is*  
**Number of cores:** Maximum 64, recommended 16  
**Memory [GiB]:** Maximum 128  
**Running time [days]:** Maximum 14  
**Partition to run in:** long  

When you launch this, it will queue the request as it goes through the ```slurm``` workload manager. It will then automatically update when it is running, and you can launch the session. If it is taking too long, reduce the cores, memory, and running time. 16 cores, 64 Gb RAM, and 1 day often works well.

**3. Close** the R session, and go back to your terminal. You should see two new folders in your home directory, ```ondemand``` and ```R```. Perform these steps:

```
cd # change to home directory
ls # to check
mv ondemand work/bin/ && ln -s ~/work/bin/ondemand ondemand

rm -r R && ln -s ~/work/bin/miniconda3/envs/sc/lib/R/library/ R
```
