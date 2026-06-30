#!/bin/bash
#SBATCH -p barbun
#SBATCH -A egitimg14
#SBATCH -J fastqc_Smutans
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --time=04:00:00
#SBATCH --output=logs/fastqc-%j.out

# Çıktı klasörünü oluştur
mkdir -p results/fastqc_before_trimming

# Konteyner ve Singularity komutu
CONTAINER="containers/fastqc_0.12.1--hdfd78af_0.sif"
singularity exec ${CONTAINER} fastqc data/ERR2505846.fastq.gz --threads 4 --nogroup --outdir results/fastqc_before_trimming/

