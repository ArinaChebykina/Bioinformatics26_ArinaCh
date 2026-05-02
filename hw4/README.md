# Homework 4: Genome Assembly with Velvet and SPAdes

## Описание hw4
Сборка генома вируса гриппа из данных секвенирования Illumina с использованием **Velvet** и **SPAdes**

## Структура папки `hw4`

```
hw4/
├── all_contigs/                  # Финальные контиги всех сборок
│   ├── velvet_original_k55.fa   # Velvet original (k=55)
│   ├── velvet_original_k65.fa   # Velvet original (k=65)
│   ├── velvet_gentle_k55.fa     # Velvet улучшенный (k=55)
│   ├── velvet_gentle_k65.fa     # Velvet улучшенный (k=65) — ЛУЧШИЙ
│   ├── spades_default.fasta     # SPAdes default (базовый)
│   ├── spades_careful.fasta     # SPAdes careful (c триммингом)
│   ├── spades_final.fasta       # SPAdes final (без cov-cutoff) — ЛУЧШИЙ
│   └── spades_final_vers.fasta  # SPAdes version 2 (альтернативный)
│
├── QUASTs/                      # QUAST отчеты (6 папок)
│   ├── quast_3_final/           # SPAdes 3 версии (default, careful, final)
│   ├── quast_all/               # Часть 2. Velvet vs SPAdes
│   ├── quast_all_final/         # Все сборки финальные
│   ├── quast_spades_three/      # SPAdes 3 версии (default, careful, vers2)
│   ├── quast_velvet_final/      # Velvet original vs gentle (k65)
│   └── quast_velvet_gentle/     # Velvet original vs gentle (k55,k65)
│
├── scripts/                     # SLURM скрипты для запуска
│   ├── velvet_job.slurm         # Оригинальный Velvet
│   └── velvet_gentle.slurm      # Улучшенный Velvet (с триммингом)
│
├── hw4_report.ipynb             # Jupyter notebook с отчетом
└── README.md                    # Этот файл
```
