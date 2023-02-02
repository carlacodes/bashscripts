#!/bin/bash -l

# Batch script to run a GPU job under SGE.

# Request a number of GPU cards, in this case 2 (the maximum)
#$ -l gpu=1

# Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=20:30:0

# Request 1 gigabyte of RAM (must be an integer followed by M, G, or T)
#$ -l mem=126G

# Request 15 gigabyte of TMPDIR space (default is 10 GB)
#$ -l tmpfs=500G

# Set the name of the job.
#$ -N spikesortJob1_06082022

# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID :)
#$ -wd /home/zceccgr/Scratch/zceccgr/spikeinterface3cg

# Change into temporary directory to run work
cd $TMPDIR

# load the cuda module (in case you are running a CUDA program)

module unload compilers mpi
module load compilers/gnu/4.9.2
# module load xorg-utils/X11R7.7

# module load matlab/full/r2019b/9.7
module load cuda/10.1.243/gnu-4.9.2
module load python3/3.8

module list


cp ~/Scratch/zceccgr/spikeinterface3cg/interfacetest_jules_cg_kilosort_concatenate_ms4.py $TMPDIR
cp -r ~/Scratch/zceccgr/spikeinterface3cg/ $TMPDIR
# cp -r ~/Scratch/zceccgr/Kilosort-2.0/ $TMPDIR
# cp -r ~/Scratch/zceccgr/Kilosort-2.0/CUDA/. $TMPDIR

# cp -r ~/Scratch/zceccgr/Kilosort-2.0/CUDA/mexGPUall.m $TMPDIR

# cp ~/Scratch/zceccgr/Kilosort-2.0/mexThSpkPC.cu $TMPDIR








# Activate python environment
source /home/zceccgr/spkenv2/bin/activate

# Run the application - the line below is just a random example.
#matlab -nosplash -nodesktop -nodisplay <  ~/Scratch/zceccgr/Kilosort-2.0/CUDA/mexGPUall.m
python /home/zceccgr/Scratch/zceccgr/spikeinterface3cg/spikesorting_install_test.py

python /home/zceccgr/Scratch/zceccgr/spikeinterface3cg/interfacetest_jules_cg_kilosort_concatenate_ms4.py

# 10. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/files_from_jobGPU06082022_2_$JOB_ID.tar.gz $TMPDIR

# Make sure you have given enough time for the copy to complete!