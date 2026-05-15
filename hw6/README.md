# hw6 — RNA-seq анализ (STAR + StringTie + HTSeq)

## Структура папки hw6

```
hw6/
├── README.md
├── hw6_bioinf_отчет.ipynb
│
├── scripts/
│   ├── 1_fastqc_raw.slurm
│   ├── 2_fastp.slurm
│   ├── 3_fastqc_trimmed.slurm
│   ├── 4_star.slurm
│   ├── 5_stringtie.slurm
│   └── 6_htseq.slurm
│
└── results/
    ├── fastqc_raw/
    │   ├── Eg_Treg_S71_R1_001_fastqc.html
    │   ├── Eg_Treg_S71_R1_001_fastqc.zip
    │   ├── Eg_Treg_S71_R2_001_fastqc.html
    │   └── Eg_Treg_S71_R2_001_fastqc.zip
    │
    ├── fastqc_trimmed/
    │   ├── Eg_Treg_S71_R1_trimmed_fastqc.html
    │   ├── Eg_Treg_S71_R1_trimmed_fastqc.zip
    │   ├── Eg_Treg_S71_R2_trimmed_fastqc.html
    │   └── Eg_Treg_S71_R2_trimmed_fastqc.zip
    │
    ├── multiqc/
    │   ├── multiqc_raw_report.html
    │   ├── multiqc_trimmed_report.html
    │   └── Eg_Treg_S71_fastp.html
    │
    ├── star_alignment/
    │   ├── RNA_Log.final.out
    │   ├── RNA_Log.out
    │   ├── RNA_Log.progress.out
    │   ├── RNA_ReadsPerGene.out.tab
    │   └── RNA_SJ.out.tab
    │
    ├── stringtie_out/
    │   └── transcripts.gtf
    │
    └── htseq_out/
        └── htseq_counts.txt
```

