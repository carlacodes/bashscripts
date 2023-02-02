#!/bin/bash -l

# Batch script to run a multi-threaded MATLAB job under SGE.

# Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=19:00:00

# Request 1 gigabyte of RAM per core. 
#$ -l mem=30G

# Request 15 gigabytes of TMPDIR space (default is 10 GB)
#$ -l tmpfs=500G

# Request a number of threads (which will use that number of cores). 
# On Myriad you can set the number of threads to a maximum of 36. 
#$ -pe smp 36

# Set the name of the job.
#$ -N LSTMjob_zola_14012023_2

# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID :)
#$ -wd /home/zceccgr/Scratch/zceccgr/lstmdecodingproject/leavepoutcrossvalidationlstmdecoder/

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

cp ~/home/zceccgr/Scratch/zceccgr/lstmdecodingproject/leavepoutcrossvalidationlstmdecoder/cgeuclidean_cvkfold_score_classification_zola.py $TMPDIR
#cp -r ~/Scratch/zceccgr/instruments/ $TMPDIR



# Activate python environment
source /home/zceccgr/envlib/newlstm/bin/activate

# Run the application - the line below is just a random example.
#matlab -nosplash -nodesktop -nodisplay <  ~/Scratch/zceccgr/Kilosort-2.0/CUDA/mexGPUall.m
python /home/zceccgr/Scratch/zceccgr/lstmdecodingproject/leavepoutcrossvalidationlstmdecoder/cgeuclidean_cvkfold_score_classification_zola.py

# 10. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/files_from_jobLSTM_14012023ZOLA_2_$JOB_ID.tar.gz $TMPDIR

# Make sure you have given enough time for the copy to complete!