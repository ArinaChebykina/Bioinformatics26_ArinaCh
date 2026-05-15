#!/bin/bash
#SBATCH --job-name=htseq_count
#SBATCH --cpus-per-task=4
#SBATCH --mem=8gb
#SBATCH --time=0:30:00
#SBATCH --output=~/hw6/logs/htseq_%j.out
#SBATCH --partition=AMD9554-common

export PATH="/home/STUDY/FBMF/bioinformatics/anaconda3/bin:$PATH"

BAM=~/hw6/results/star_alignment/RNA_Aligned.sortedByCoord.out.bam
GTF=/home/STUDY/FBMF/bioinformatics/GRCh38/Homo_sapiens.GRCh38.110.chr.gtf
OUTDIR=~/hw6/results/htseq_out
mkdir -p $OUTDIR

htseq-count \
    --format bam \
    --order pos \
    --stranded no \
    --type exon \
    --idattr gene_id \
    $BAM $GTF > $OUTDIR/htseq_counts.txt

echo "HTSeq-count completed"
