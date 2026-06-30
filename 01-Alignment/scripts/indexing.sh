#!/bin/bash

#SBATCH -J index

#SBATCH -p barbun
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 40
#SBATCH --time=72:00:00

#SBATCH -o logs/%x-%j-%N-%u.out
#SBATCH -e logs/%x-%j-%N-%u.err

# containers
SINGULARITY_BWA=/arf/home/egitimg14/Lectures/01-Alignment/containers/bwa_latest.sif

# index reference genome

singularity run ${SINGULARITY_BWA} bwa index data/reference/GCF_000007465.2_ASM746v2_genomic.fna 

