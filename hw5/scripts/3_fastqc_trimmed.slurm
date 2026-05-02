#!/bin/bash
#SBATCH --job-name=fastqc_trimmed
#SBATCH --cpus-per-task=4
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --output=~/hw5_fastqc_trimming/fastqc_trimmed_%j.out
#SBATCH --partition=AMD9554-common

# Пути
DATA_DIR=~/hw5_fastqc_trimming/data/trimmed
OUTPUT_DIR=~/hw5_fastqc_trimming/results/fastqc_trimmed
MULTIQC_DIR=~/hw5_fastqc_trimming/results/multiqc

mkdir -p $OUTPUT_DIR $MULTIQC_DIR

cd $DATA_DIR

echo "=== FastQC ==="
fastqc -t 4 *.fastq.gz -o $OUTPUT_DIR

echo "=== MultiQC ==="
multiqc $OUTPUT_DIR -o $MULTIQC_DIR -n multiqc_trimmed_report

echo "=== Successfully! ==="
