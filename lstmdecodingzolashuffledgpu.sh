#!/bin/bash -l

# Batch script to run a GPU job under SGE.

# Request a number of GPU cards, in this case 2 (the maximum)
#$ -l gpu=1

# Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=6:30:0

# Request 1 gigabyte of RAM (must be an integer followed by M, G, or T)
#$ -l mem=50G

# Request 15 gigabyte of TMPDIR space (default is 10 GB)
#$ -l tmpfs=100G

# Set the name of the job.
#$ -N LSTMjob_ZOLA_SHUFFLED_05122022_8_gpu

# Set the working directory to somewhere in your scratch space.
# Replace "<your_UCL_id>" with your UCL user ID :)
#$ -wd /home/zceccgr/Scratch/zceccgr/shuffledrasterscores

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

cp ~/Scratch/zceccgr//shuffledrasterscores/cgeuclidean_cv_shuffled_score_classification_zola.py $TMPDIR
#cp -r ~/Scratch/zceccgr/instruments/ $TMPDIR



# Activate python environment
source /home/zceccgr/envlib/newlstm/bin/activate

# Run the application - the line below is just a random example.
#matlab -nosplash -nodesktop -nodisplay <  ~/Scratch/zceccgr/Kilosort-2.0/CUDA/mexGPUall.m
python /home/zceccgr/Scratch/zceccgr/shuffledrasterscores/cgeuclidean_cv_shuffled_score_classification_zola.py

# 10. Preferably, tar-up (archive) all output files onto the shared scratch area
tar zcvf $HOME/Scratch/files_from_jobLSTM05122022_ZOLA_1_$JOB_ID.tar.gz $TMPDIR

# Make sure you have given enough time for the copy to complete!