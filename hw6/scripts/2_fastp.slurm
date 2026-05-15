#!/bin/bash
#SBATCH --job-name=fastp_trim
#SBATCH --cpus-per-task=4
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --output=~/hw6/logs/fastp_%j.out
#SBATCH --partition=AMD9554-common

RAW_DIR=~/hw6/data/raw
TRIMMED_DIR=~/hw6/data/trimmed
REPORT_DIR=~/hw6/results/multiqc

mkdir -p $TRIMMED_DIR $REPORT_DIR
cd $RAW_DIR

echo "=== Тримминг Eg_Treg_S71 ==="

fastp \
    -i Eg_Treg_S71_R1_001.fastq.gz \
    -I Eg_Treg_S71_R2_001.fastq.gz \
    -o $TRIMMED_DIR/Eg_Treg_S71_R1_trimmed.fastq.gz \
    -O $TRIMMED_DIR/Eg_Treg_S71_R2_trimmed.fastq.gz \
    --detect_adapter_for_pe \
    --cut_front --cut_tail \
    --cut_window_size 5 --cut_mean_quality 20 \
    --length_required 36 \
    --html $REPORT_DIR/Eg_Treg_S71_fastp.html

echo "=== Тримминг завершен ==="
