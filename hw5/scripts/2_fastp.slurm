#!/bin/bash
#SBATCH --job-name=fastp_trim
#SBATCH --cpus-per-task=4
#SBATCH --mem=4gb
#SBATCH --time=00:30:00
#SBATCH --output=~/hw5_fastqc_trimming/fastp_%j.out
#SBATCH --partition=AMD9554-common

# Пути
RAW_DIR=~/hw5_fastqc_trimming/data/raw
TRIMMED_DIR=~/hw5_fastqc_trimming/data/trimmed
REPORT_DIR=~/hw5_fastqc_trimming/results/multiqc

mkdir -p $TRIMMED_DIR $REPORT_DIR

cd $RAW_DIR

for file in *.fastq.gz; do
    filename=$(basename "$file" .fastq.gz)
    
    echo "=== Обработка: $filename ==="
    
    fastp \
        -i "$file" \
        -o "$TRIMMED_DIR/${filename}_trimmed.fastq.gz" \
        --detect_adapter_for_pe \
        --cut_front \
        --cut_tail \
        --cut_window_size 5 \
        --cut_mean_quality 20 \
        --length_required 36 \
        --html "$REPORT_DIR/${filename}_fastp.html"
    
    echo "$filename обработан"
done

echo ""
echo "=== Successfully! ==="
