#!/bin/bash -l

# Batch script to run a multi-threaded MATLAB job under SGE.

# Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=20:10:0

# Request 1 gigabyte of RAM per core. 
#$ -l mem=2G

# Request 15 gigabytes of TMPDIR space (default is 10 GB)
#$ -l tmpfs=155G

# Request a number of threads (which will use that number of cores). 
# On Myriad you can set the number of threads to a maximum of 36. 
#$ -pe smp 18

# Request one MATLAB licence - makes sure your job doesn't start 
# running until sufficient licenses are free.
#$ -l matlab=1

# Set the name of the job.
#$ -N Matlab_Zola2_nps_21082022L28

# Set the working directory to somewhere in your scratch space.
# This is a necessary step as compute nodes cannot write to $HOME.
# Replace "<your_UCL_id>" with your UCL user ID.
# This directory must already exist.
#$ -wd /home/zceccgr/Scratch/zceccgr/

# Your work should be done in $TMPDIR
cd $TMPDIR

module load xorg-utils/X11R7.7
module load matlab/full/r2021a/9.10
# outputs the modules you have loaded
module list

# Optional: copy your script and any other files into $TMPDIR.
# This is only practical if you have a small number of files.
# If you do not copy them in, you must always refer to them using a
# full path so they can be found, eg. ~/Scratch/Matlab_examples/analyse.m

cp ~/code/write_to_bin_ks/myriad_upload/Zola_classifysweeps_distvdist_reducednPSL28.m $TMPDIR
cp ~/code/write_to_bin_ks/myriad_upload/classifySweeps_optionforcmmat.m $TMPDIR
cp -r ~/Scratch/zceccgr/npy-matlab-master $TMPDIR

# These echoes output what you are about to run
echo ""
echo "Running matlab -nosplash -nodisplay < zola_classifysweeps_distvdist_reduced.m ..."
echo ""

matlab -nosplash -nodesktop -nodisplay < Zola_classifysweeps_distvdist_reducednPSL28.m
# Or if you did not copy your files:

# tar up all contents of $TMPDIR back into your space
tar zcvf $HOME/Scratch/files_from_jobZoladistvdist_${JOB_ID}.tgz $TMPDIR

# Make sure you have given enough time for the copy to complete!