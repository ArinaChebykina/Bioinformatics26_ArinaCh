#!/bin/bash
#SBATCH --job-name=star_mapping
#SBATCH --cpus-per-task=34
#SBATCH --mem=128gb
#SBATCH --time=1:55:00
#SBATCH --output=~/hw6/logs/star_%j.out
#SBATCH --partition=AMD9554-common

export PATH="/home/STUDY/FBMF/bioinformatics/anaconda3/bin:$PATH"
ulimit -n 20000

GENOME_DIR="/home/STUDY/FBMF/bioinformatics/GRCh38/"
READS1=~/hw6/data/trimmed/Eg_Treg_S71_R1_trimmed.fastq.gz
READS2=~/hw6/data/trimmed/Eg_Treg_S71_R2_trimmed.fastq.gz
OUTPUT_DIR=~/hw6/results/star_alignment

mkdir -p $OUTPUT_DIR

STAR \
  --runThreadN 16 \
  --runMode alignReads \
  --genomeDir $GENOME_DIR \
  --readFilesIn $READS1 $READS2 \
  --readFilesCommand zcat \
  --outFileNamePrefix ${OUTPUT_DIR}/RNA_ \
  --outSAMtype BAM SortedByCoordinate \
  --quantMode GeneCounts 

echo "Alignment Done"
