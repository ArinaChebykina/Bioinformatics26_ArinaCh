#!/bin/bash
#SBATCH --job-name=hw4_velvet
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=02:00:00
#SBATCH --output=~/hw4_velvet_assembly/logs/velvet_%j.log
#SBATCH --error=~/hw4_velvet_assembly/logs/velvet_%j.err
#SBATCH --partition=AMD9554-common

# Пути
VELVET_DIR="$HOME/velvet"
DATA_DIR="$HOME/hw4_velvet_assembly/data"
OUTPUT_BASE="$HOME/hw4_velvet_assembly/results/velvet"

# K-mer значения (31, 43, 55, 65)
KMERS=(31 43 55 65)
INS_LENGTH=300

for k in "${KMERS[@]}"; do
    echo ""
    echo "=== k=$k ==="
    OUTPUT_DIR="${OUTPUT_BASE}/k${k}"
    mkdir -p $OUTPUT_DIR
    
    $VELVET_DIR/velveth $OUTPUT_DIR $k -fastq -shortPaired \
        $DATA_DIR/7_S4_L001_R1_001.fastq \
        $DATA_DIR/7_S4_L001_R2_001.fastq
    
    $VELVET_DIR/velvetg $OUTPUT_DIR -ins_length $INS_LENGTH
    
    echo "k=$k done:"
    grep "Final assembly" $OUTPUT_DIR/stats.txt
done

echo "Results: $OUTPUT_BASE"
