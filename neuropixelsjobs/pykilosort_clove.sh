#!/bin/bash -l

# Request 1 hour of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=3:00:00

# Request 256 gigabyte of RAM (must be an integer followed by M, G, or T)
#$ -l mem=10G

# Request 10 gigabyte of TMPDIR space (default is 10 GB)
#$ -l tmpfs=500G

# For 1 GPU
#$ -l gpu=1

# Request 18 cores.
#$ -pe smp 18

# Set the name of the job.
#$ -N spikesortJob2_clove_18042023
#$ -wd /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject



cd $TMPDIR
# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID :)
# Change into temporary directory to run work


# load the cuda module (in case you are running a CUDA program)

module unload compilers mpi
module load compilers/gnu/4.9.2
module load cuda/10.1.243/gnu-4.9.2
module load cudnn/7.6.5.32/cuda-10.1

module unload python
module load python/miniconda3/4.10.3
source $UCL_CONDA_PATH/etc/profile.d/conda.sh

nvidia-smi


# Activate python environment
conda activate ibl_pykil_ss



cp /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject/runspikesortingnptest_pykilosorts_clove.py $TMPDIR

# cp -r ~/Scratch/zceccgr/Kilosort-main/CUDA/mexGPUall.m $TMPDIR
# cp -r ~/Scratch/zceccgr/Kilosort-main/CUDA/ $TMPDIR

# cp ~/Scratch/zceccgr/Kilosort-2.0/mexThSpkPC.cu $TMPDIR

# Run the application - the line below is just a random example.
# matlab -nosplash -nodesktop -nodisplay <  ~/Scratch/zceccgr/Kilosort-main/CUDA/mexGPUall.m




#python /home/zceccgr/Scratch/zceccgr/spikeinterface3cg/spikesorting_install_test.py

python /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject/runspikesortingnptest_pykilosorts_clove.py
# 10. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/files_from_job_pykilosort_clove_2_18042023_$JOB_ID.tar.gz $TMPDIR

# Make sure you have given enough time for the copy to complete!t