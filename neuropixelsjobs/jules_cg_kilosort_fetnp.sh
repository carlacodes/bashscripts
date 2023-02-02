#!/bin/bash -l

# Batch script to run a GPU job under SGE.

# Request a number of GPU cards, in this case 2 (the maximum)
#$ -l gpu=1

# Request ten hours of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=10:30:0

# Request 15 gigabytes of TMPDIR space (default is 10 GB)
#$ -l tmpfs=500G

# Set the name of the job.
#$ -N spikesortJob1_kilsortfettucini_S3_23012023_5

# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID :)
#$ -wd /home/zceccgr/Scratch/zceccgr/Kilosort-main/CUDA/

# Change into temporary directory to run work
#cd $TMPDIR

# load the cuda module (in case you are running a CUDA program)

# module unload compilers mpi
# module load compilers/gnu/4.9.2
# # module load xorg-utils/X11R7.7

# # module load matlab/full/r2019b/9.7
# module load cuda/10.1.243/gnu-4.9.2
# module load cuda/10.1.243/gnu-4.9.2
module unload compilers mpi
module load compilers/gnu/4.9.2
module load xorg-utils/X11R7.7

module load matlab/full/r2019b/9.7
module load cuda/10.1.243/gnu-4.9.2

module load python3/3.8

module list


cp ~/Scratch/zceccgr/neuropixelsdecodingproject/runspikesortingnptest.py $TMPDIR

cp -r ~/Scratch/zceccgr/Kilosort-main/CUDA/mexGPUall.m $TMPDIR
cp -r ~/Scratch/zceccgr/Kilosort-main/CUDA/ $TMPDIR

# cp ~/Scratch/zceccgr/Kilosort-2.0/mexThSpkPC.cu $TMPDIR


# Activate python environment
#source /home/zceccgr/spkenv2/bin/activate
source /home/zceccgr/envlib/npenv2/bin/activate
cd $TMPDIR
# Run the application - the line below is just a random example.
matlab -nosplash -nodesktop -nodisplay <  ~/Scratch/zceccgr/Kilosort-main/CUDA/mexGPUall.m
#$ -wd /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject/
cd /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject/


#python /home/zceccgr/Scratch/zceccgr/spikeinterface3cg/spikesorting_install_test.py

python /home/zceccgr/Scratch/zceccgr/neuropixelsdecodingproject/runspikesortingnptest.py

# 10. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/files_from_job_kilosort_fet_23012023_5_$JOB_ID.tar.gz $TMPDIR

# Make sure you have given enough time for the copy to complete!t