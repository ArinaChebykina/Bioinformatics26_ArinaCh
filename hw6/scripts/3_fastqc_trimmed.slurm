#!/bin/bash
#SBATCH --job-name=fastqc_trimmed
#SBATCH --cpus-per-task=4
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --output=~/hw6/logs/fastqc_trimmed_%j.out
#SBATCH --partition=AMD9554-common

DATA_DIR=~/hw6/data/trimmed
OUTPUT_DIR=~/hw6/results/fastqc_trimmed
MULTIQC_DIR=~/hw6/results/multiqc

mkdir -p $OUTPUT_DIR $MULTIQC_DIR
cd $DATA_DIR

fastqc -t 4 *.fastq.gz -o $OUTPUT_DIR
multiqc $OUTPUT_DIR -o $MULTIQC_DIR -n multiqc_trimmed_report

echo "=== Готово! ==="
