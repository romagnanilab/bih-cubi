#!/bin/bash/

bin_folder=${HOME}/work/bin
mkdir -p ${bin_folder}

ln -s /data/cephfs-2/unmirrored/projects/romagnani-share ${HOME}/share
ln -s /fast/groups/ag_romagnani ${HOME}/group
mkdir -p ${HOME}/.config
mv .config ${bin_folder} && ln -s ${bin_folder}/.config ${HOME}/.config
mkdir -p ${HOME}/.cache
mv .cache ${bin_folder} && ln -s ${bin_folder}/.cache ${HOME}/.cache
mkdir -p ${HOME}/.local
mv .local ${bin_folder} && ln -s ${bin_folder}/.local ${HOME}/.local
mkdir -p ${HOME}/ondemand
mv ondemand ${bin_folder} && ln -s ${bin_folder}/ondemand ${HOME}/ondemand

echo "Do you want to install miniconda, for building environments such as for RStudio? (y/n)"
read -r choice

while [[ ! $choice =~ ^[YyNn]$ ]]; do
    echo "Invalid input. Please enter y or n"
    read -r choice
done

# Process choices
if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then

    cd ${bin_folder}

    curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-latest-Linux-x86_64.sh

    bash Miniconda3-latest-Linux-x86_64.sh -b -p ${bin_folder}/miniconda3

    rm Miniconda3-latest-Linux-x86_64.sh

    echo 'channels:
    - conda-forge
    - bioconda
    - bih-cubi
    - defaults
show_channel_urls: true
changeps1: true
channel_priority: flexible' > ${HOME}/.condarc

    source ${bin_folder}/miniconda3/etc/profile.d/conda.sh

    conda activate

    conda upgrade --all -y
    conda config --set solver libmamba

elif [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
    :
fi

echo "Do you want to create R_4.2.3? (y/newname/n)"
read -r choice

# Validate user input
while [[ ! $choice =~ ^[YyNn]$ && $choice != "newname" ]]; do
    echo "Invalid input. Please enter Y, N, or newname"
    read -r choice
done

environment=$HOME/group/work/bin/source/R_4.2.3.yml
# Process user choice
if [[ $choice =~ ^[Yy]$ ]]; then
    echo ""
    echo "Creating a new environment for RStudio. This might take a while..."
    echo ""
    env_name='R_4.2.3'
    conda env create -f $environment
elif [[ $choice == "newname" ]]; then
    echo ""
    echo "Enter the name for the new environment:"
    read -r env_name

    cp "$environent" "${TMPDIR}/${env_name}.yml"

    echo ""
    echo "Creating a new environment named '${env_name}' for RStudio..."
    echo ""

    sed -i "1s/.*/name: ${env_name}/" "${TMPDIR}/${env_name}.yml"

    conda env create -f "${TMPDIR}/${env_name}.yml"

    echo "New environment '${env_name}' created."

elif [[ $choice =~ ^[Nn]$ ]]; then
    echo "Not creating a new environment for RStudio."
fi

echo "Do you want to create a reticulate environment for R? (y/n)"
read -r choice

# Validate user input
while [[ ! $choice =~ ^[YyNn] ]]; do
    echo "Invalid input. Please enter y or n"
    read -r choice
done

# Process user choice
if [[ $choice =~ ^[Yy]$ ]]; then
    echo ""
    echo "Creating r-reticulate, this might take a while..."
    echo ""
    conda env create -f $HOME/group/work/bin/source/r-reticulate.yml
elif [[ $choice =~ ^[Nn]$ ]]; then
    echo "Not creating r-reticulate"
fi

if [[ -d ${HOME}/ondemand/dev ]]; then
    rm -r ${HOME}/ondemand/dev
fi

echo "Do you want to correct OnDemand for RStudio? (y/n)"
read -r choice

while [[ ! $choice =~ ^[YyNn]$ ]]; do
    echo "Invalid input. Please enter y or n"
    read -r choice
done

# Process choices
if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
    mkdir -p ${HOME}/ondemand/dev
    cd ${HOME}/ondemand/dev
    git clone https://github.com/ollieeknight/ondemand-rstudio-server
    source $HOME/work/bin/miniconda3/etc/profile.d/conda.sh
    conda activate
    miniconda_dir=$(echo $PATH | grep -o "$HOME/[^:]*miniconda3" | head -n 1)
    line_number=$(grep -n 'LD_LIBRARY_PATH=/usr/lib64/' ${HOME}/ondemand/dev/ondemand-rstudio-server/template/script.sh.erb | cut -d ":" -f 1)
    if [[ -n $line_number ]]; then
        sed -i "${line_number}a   export LD_PRELOAD=${miniconda_dir}/envs/$env_name/lib/libstdc++.so.6" ${HOME}/ondemand/dev/ondemand-rstudio-server/template/script.sh.erb
    else
        echo "LD_LIBRARY_PATH line not found in script.sh"
    fi
else
   echo "Exiting"
fi
