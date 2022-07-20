Upon connecting using the ```ssh bihcluster``` command through your terminal, you'll find yourself in a login node. **Do not** run anything here as there is limited RAM and CPU for anything, it is only intended for running ```tmux``` or ```screen``` sessions.  

**1. Creating an interactive session** 

tmux and screen are essentially new windows for your command line. You can attach and detach these and they will run in the background even when you close your terminal window.  

To begin:
```
tmux new -s cubi # create a new tmux session with the name 'cubi'
```

You can detach this at any time by pressing CTRL+b, letting go, and pressing the d key. You can reattach at any time in 'base' command windows by typing ```tmux a -t cubi```  

Next, we will ask the workload managing system ```slurm``` to allocate us some cores and RAM.

```srun -p long --time 7-00 --mem=32G --ntasks=16 --pty bash -i```  

This creates a session which will last 7 days, reserve 32Gb RAM, and 16 cores. From here, we can install software, packages, extract files and run programs.

**2. Setting up a workspace environment**

From here, how you set up your workspace is entirely your decision. However it important to understand how the file structure of the BIH-CUBI cluster is set up:

- Your home directory, ```/data/gpfs-1/users/${USER}```, is only 1Gb in space and should not really contain anything other than *links* to other folders; already set up are ```/fast/scratch/users/${USER}``` and ```/fast/work/users/${USER}```.  
- Your ```scratch/``` folder has a hard quota of 220Tb; however, files are deleted after 2 weeks from the time of their creation. This will be where large data such as sequencing runs and processing pipelines will work out of.
- Your ```work/``` folder has a hard quota of 1.1Tb and is for non-group personal use.
- Finally, there is the ```/fast/groups/ag_romagnani/``` folder, where communal programs, scripts and reference genomes/files are kept.  
You can at any time check your quota with the command ```bih-gpfs-quota-user user_c```
