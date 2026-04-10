import os
import gzip
import pandas as pd
from Bio import SeqIO

# путь к файлу (ЛОКАЛЬНО)

GBFF_PATH = "../data/ecoli_k12.gbff.gz"

# путь к папке с результатами

RESULTS_DIR = "../results"
os.makedirs(RESULTS_DIR, exist_ok=True)

OUTPUT_PATH = os.path.join(RESULTS_DIR, "genes_table.tsv")

# загрузка данных из локального файла

def load_genbank_from_file(path: str):
    with gzip.open(path, "rt") as handle:
        record = SeqIO.read(handle, "genbank")
    return record

print("Loading GenBank...")
record = load_genbank_from_file(GBFF_PATH)

print("Loaded:", record.id)
print("Genome length:", len(record.seq))

# извлечение CDS генов

genes = []

for feature in record.features:
    if feature.type == "CDS":

        # координаты
        start = int(feature.location.start)
        end = int(feature.location.end)
        strand = feature.location.strand if feature.location.strand else 0

        # аннотации
        gene_name = feature.qualifiers.get("gene", ["unknown"])[0]
        locus_tag = feature.qualifiers.get("locus_tag", [""])[0]
        product = feature.qualifiers.get("product", [""])[0]

        genes.append({
            "gene": gene_name,
            "locus_tag": locus_tag,
            "start": start,
            "end": end,
            "strand": strand,
            "product": product
        })

genes_df = pd.DataFrame(genes)

# сортировка по координате
genes_df = genes_df.sort_values("start").reset_index(drop=True)

# сохранение

genes_df.to_csv(OUTPUT_PATH, sep="\t", index=False)

print("\nDone!")
print("Genes extracted:", genes_df.shape)
print("Saved to:", OUTPUT_PATH)
print("\nPreview:")
print(genes_df.head())
