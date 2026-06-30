#!/bin/bash

#SBATCH -J alignment
#SBATCH -p barbun
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 40
#SBATCH --time=72:00:00
#SBATCH -o logs/%x-%j-%N-%u.out
#SBATCH -e logs/%x-%j-%N-%u.err

BASE_DIR="/arf/scratch/egitimg14u1/S_mutans_Analizi/S_mutans_project"
cd ${BASE_DIR}
mkdir -p results/alignment

SINGULARITY_BWA="/arf/home/egitimg14/Lectures/01-Alignment/containers/bwa_latest.sif"
SINGULARITY_SAMTOOLS="/arf/home/egitimg14/Lectures/01-Alignment/containers/samtools_1.21.sif"

GENOME="GCF_000007465.2_ASM746v2_genomic.fna"
SAMPLE=$1

# Bütün yolları tartışmaya kapalı şekilde Mutlak Yol (Absolute Path) yapıyoruz
REF="${BASE_DIR}/data/reference/${GENOME}"
FQ="${BASE_DIR}/data/${SAMPLE}.fastq.gz"
SAI="${BASE_DIR}/results/alignment/${SAMPLE}.sai"
SAM="${BASE_DIR}/results/alignment/${SAMPLE}.sam"
BAM="${BASE_DIR}/results/alignment/${SAMPLE}.bam"
SORTED_BAM="${BASE_DIR}/results/alignment/${SAMPLE}.sorted.bam"
RMDUP_BAM="${BASE_DIR}/results/alignment/${SAMPLE}.sorted.rmdup.bam"

# Singularity komutlarına '--bind /arf' ekleyerek körlüğü kaldırıyoruz
singularity run --bind /arf ${SINGULARITY_BWA} bwa aln -l 1024 -n 0.01 -t 4 ${REF} ${FQ} > ${SAI}

singularity run --bind /arf ${SINGULARITY_BWA} bwa samse ${REF} ${SAI} ${FQ} > ${SAM}

singularity run --bind /arf ${SINGULARITY_SAMTOOLS} samtools view -Sb -F4 ${SAM} > ${BAM}

singularity run --bind /arf ${SINGULARITY_SAMTOOLS} samtools sort ${BAM} -o ${SORTED_BAM}
singularity run --bind /arf ${SINGULARITY_SAMTOOLS} samtools index ${SORTED_BAM}

singularity run --bind /arf ${SINGULARITY_SAMTOOLS} samtools rmdup ${SORTED_BAM} ${RMDUP_BAM}
singularity run --bind /arf ${SINGULARITY_SAMTOOLS} samtools index ${RMDUP_BAM}

rm ${SAI} ${SAM} ${BAM}
