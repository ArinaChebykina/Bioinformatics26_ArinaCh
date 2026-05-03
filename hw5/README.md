# Homework 5: FastQC and Trimming

## Структура папки hw5

```
hw5/
├── README.md                     # Описание проекта и структура папки
├── hw5_report.ipynb              # Jupyter notebook с отчетом
├── scripts/
│   ├── 1_fastqc_raw.slurm        # FastQC для сырых данных
│   ├── 2_fastp.slurm             # Тримминг fastp
│   └── 3_fastqc_trimmed.slurm    # FastQC после тримминга
│
└── results/
    ├── fastqc_raw/               # FastQC отчеты (сырые данные)
    ├── fastqc_trimmed/           # FastQC отчеты (после тримминга)
    └── multiqc/                  # MultiQC отчеты (до и после тримминга)
        ├── multiqc_raw_report.html
        └── multiqc_trimmed_report.html
```

## Параметры тримминга (fastp)

| Параметр                     | Значение | Назначение                              |
|-----------------------------|----------|----------------------------------------|
| `--detect_adapter_for_pe`   | да       | авто-детекция адаптеров                |
| `--cut_front --cut_tail`    | да       | обрезка начала и конца ридов           |
| `--cut_window_size`         | 5        | скользящее окно для оценки качества    |
| `--cut_mean_quality`        | 20       | порог качества Q20                     |
| `--length_required`         | 36       | минимальная длина рида                 |
