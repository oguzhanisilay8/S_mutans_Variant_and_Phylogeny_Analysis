#!/bin/bash
#SBATCH -J test.fasta
#SBATCH -p barbun
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 40
#SBATCH --time=24:00:00
#SBATCH -o logs/%x-%j-%N-%u.out
#SBATCH -e logs/%x-%j-%N-%u.err

# define containers
IQTREE=/arf/home/egitimg14/Containers/iqtree\:2.3.6--h503566f_1

# --bind /arf eklendi ve .calls.vcf.gz (sıkıştırılmış) dosyalar okutuldu
singularity run ${IQTREE} iqtree -s test.fasta -m MFP -bb 1000 -T AUTO
