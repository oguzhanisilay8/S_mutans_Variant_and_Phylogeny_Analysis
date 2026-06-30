#!/bin/bash
#SBATCH -J variant-calling
#SBATCH -p barbun
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 20
#SBATCH --time=24:00:00
#SBATCH -o logs/%x-%j-%N-%u.out
#SBATCH -e logs/%x-%j-%N-%u.err

# define containers
BCFTOOLS=/arf/home/egitimg14/Containers/bcftools:1.21--h3a4d415_1

# create folders
mkdir -p results/variants

SAMPLE=$1
GENOME=GCF_000007465.2_ASM746v2_genomic.fna

# create pileup file (Singularity korlugu asildi)
singularity run --bind /arf ${BCFTOOLS} bcftools mpileup -Ov -f data/reference/${GENOME} results/alignment/${SAMPLE}.sorted.rmdup.bam > results/variants/${SAMPLE}.sorted.rmdup.likelihoods.vcf

# call variants (Ploidy 1 parametresi eklendi)
singularity run --bind /arf ${BCFTOOLS} bcftools call -mv -Ov --ploidy 1 -o results/variants/${SAMPLE}.sorted.rmdup.calls.vcf results/variants/${SAMPLE}.sorted.rmdup.likelihoods.vcf
