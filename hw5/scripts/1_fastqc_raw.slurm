#!/bin/bash
#SBATCH --job-name=fastqc_raw
#SBATCH --cpus-per-task=4
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --output=~/hw5_fastqc_trimming/fastqc_raw_%j.out
#SBATCH --partition=AMD9554-common

# Пути
DATA_DIR=~/hw5_fastqc_trimming/data/raw
OUTPUT_DIR=~/hw5_fastqc_trimming/results/fastqc_raw
MULTIQC_DIR=~/hw5_fastqc_trimming/results/multiqc

mkdir -p $OUTPUT_DIR $MULTIQC_DIR

cd $DATA_DIR

echo "=== FastQC для скачанных данных ==="
fastqc -t 4 *.fastq.gz -o $OUTPUT_DIR

echo "=== MultiQC ==="
multiqc $OUTPUT_DIR -o $MULTIQC_DIR -n multiqc_raw_report

echo "=== FastQC and MultiQC completed successfully! ==="
