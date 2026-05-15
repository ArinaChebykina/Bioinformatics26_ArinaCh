#!/bin/bash
#SBATCH --job-name=stringtie_assemble
#SBATCH --cpus-per-task=4
#SBATCH --mem=32gb
#SBATCH --time=1:00:00
#SBATCH --output=~/hw6/logs/stringtie_%j.out
#SBATCH --partition=AMD9554-common

export PATH="/home/STUDY/FBMF/bioinformatics/anaconda3/bin:$PATH"

BAM=~/hw6/results/star_alignment/RNA_Aligned.sortedByCoord.out.bam
OUTDIR=~/hw6/results/stringtie_out

mkdir -p $OUTDIR

stringtie $BAM \
    -o $OUTDIR/transcripts.gtf \
    -p $SLURM_CPUS_PER_TASK

echo "StringTie assembly completed"
