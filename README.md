# S. mutans Variant and Phylogeny Analysis

## Project Overview
This repository contains the bioinformatics pipeline for analyzing ancient *Streptococcus mutans* genomes. The project implements a reproducible workflow for variant calling and phylogenetic reconstruction, following the methodology described in **Thygesen et al. (2026)**.

## Workflow
1. **Quality Control**: FastQC & Cutadapt (adapter trimming).
2. **Alignment**: Bowtie2 mapping to reference genome (*S. mutans* UA159).
3. **Variant Calling**: BCFTools mpileup and call (ploidy 1).
4. **Phylogeny**: IQ-TREE (Maximum Likelihood, 1000 bootstrap replicates).

## Pipeline Structure
- : Scripts for mapping and index generation.
- : Variant calling and merging scripts.

## Requirements
- Singularity/Apptainer
- BCFTools (v1.21)
- IQ-TREE (v2.x)

---
*Developed by Oğuzhan Işılay under the supervision of Assoc. Prof. Emrah Kırdök (Mersin University).*
