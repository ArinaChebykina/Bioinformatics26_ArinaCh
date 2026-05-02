#!/bin/bash
#SBATCH --job-name=velvet_gentle
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=02:00:00
#SBATCH --output=~/hw4_velvet_assembly/logs/velvet_gentle_%j.log
#SBATCH --error=~/hw4_velvet_assembly/logs/velvet_gentle_%j.err
#SBATCH --partition=AMD9554-common

VELVET_DIR="$HOME/velvet"
OUTPUT_BASE="$HOME/hw4_velvet_assembly/results/velvet_gentle"

KMERS=(55 65 75)
INS_LENGTH=300

for k in "${KMERS[@]}"; do
    echo "=== Velvet мягкий тримминг k=$k ==="
    OUTPUT_DIR="${OUTPUT_BASE}/k${k}"
    mkdir -p $OUTPUT_DIR
    
    $VELVET_DIR/velveth $OUTPUT_DIR $k -fastq -shortPaired \
        ~/hw4_velvet_assembly/data/R1_gentle.fastq \
        ~/hw4_velvet_assembly/data/R2_gentle.fastq
    
    $VELVET_DIR/velvetg $OUTPUT_DIR -ins_length $INS_LENGTH
    
    echo "Результат:"
    grep "Final assembly" $OUTPUT_DIR/stats.txt
    echo "Количество контигов: $(grep -c '^>' $OUTPUT_DIR/contigs.fa)"
done

echo ""
echo "=== Все сборки завершены ==="
echo "Результаты в: $OUTPUT_BASE"
