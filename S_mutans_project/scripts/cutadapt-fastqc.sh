#!/bin/bash

#SBATCH -J quality-control-and-cutadapt

#SBATCH -p barbun
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --time=24:00:00

#SBATCH -o logs/%x-%j-%N-%u.out
#SBATCH -e logs/%x-%j-%N-%u.err


cd /arf/scratch/egitimg14u1/S_mutans_Analizi/00-Quality-Control/

SINGULARITY_CUTADAPT=/arf/scratch/egitimg14u1/S_mutans_Analizi/00-Quality-Control/containers/cutadapt_5.0--py39hbcbf7aa_0.sif
SINGULARITY_FASTQC=/arf/scratch/egitimg14u1/S_mutans_Analizi/00-Quality-Control/containers/fastqc_0.12.1--hdfd78af_0.sif

THREADS=20

mkdir -p results/processed
mkdir -p results/fastqc-after-trimming

while read ID true
do

echo "Su an islenen numune: ${ID}"

singularity run ${SINGULARITY_CUTADAPT} cutadapt -q 20 -m 30 --trim-n -Z -j ${THREADS} -a AGATCGGAAGAG -o results/processed/${ID}.fastq.gz data/${ID}.fastq.gz 

singularity run ${SINGULARITY_FASTQC} fastqc results/processed/${ID}.fastq.gz --threads 4 --nogroup --outdir results/fastqc-after-trimming

done < fastq_ids.txt
