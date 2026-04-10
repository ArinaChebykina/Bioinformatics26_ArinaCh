import pandas as pd
import matplotlib.pyplot as plt
from Bio import SeqIO
from Bio.Seq import Seq
import gzip

# загрузка SNP файла (NUCMER)
rows = []

with open("../results/ecoli_full_filt1_snps.tsv") as f:
    for line in f:
        line = line.strip()

        if not line:
            continue

        if line.startswith("NUCMER"):
            continue

        parts = line.split()

        if len(parts) > 0 and parts[0] in ["[P1]", "P1"]:
            continue

        if len(parts) < 9:
            continue

        try:
            int(parts[0])
        except:
            continue

        rows.append([
            parts[0],  # P1
            parts[1],  # REF
            parts[2],  # ALT
            parts[3],  # P2
            parts[4],  # BUFF
            parts[5],  # DIST
            parts[6],  # FRM
            parts[7],  # TAG1
            parts[8]   # TAG2
        ])

snps = pd.DataFrame(rows, columns=[
    "P1", "REF", "ALT", "P2",
    "BUFF", "DIST", "FRM",
    "TAG1", "TAG2"
])

snps["P1"] = snps["P1"].astype(int)

# фильтр SNP (indels с "." исключаем)
snps = snps[snps["ALT"] != "."]

# загрузка генов 
genes_df = pd.read_csv("../results/genes_table.tsv", sep="\t")

genes_df["start"] = genes_df["start"].astype(int)
genes_df["end"] = genes_df["end"].astype(int)
genes_df["strand"] = genes_df["strand"].astype(int)

# загрузка генома GenBank
with gzip.open("../data/ecoli_k12.gbff.gz", "rt") as handle:
    record = SeqIO.read(handle, "genbank")

genome_seq = record.seq


def translate_codon(codon):
    return str(Seq(codon).translate())


results = []

for _, snp in snps.iterrows():

    pos = snp["P1"] - 1

    gene_hit = genes_df[
        (genes_df["start"] <= pos) &
        (genes_df["end"] > pos)
    ]

    if gene_hit.empty:
        results.append({
            "pos": snp["P1"],
            "gene": "intergenic",
            "type": "intergenic",
            "aa_change": "-",
            "effect": "non-coding"
        })
        continue

    gene_row = gene_hit.iloc[0]
    gene = gene_row["gene"]
    start = gene_row["start"]
    end = gene_row["end"]
    strand = gene_row["strand"]

    if strand == 1:
        cds_pos = pos - start
    else:
        cds_pos = end - pos - 1

    codon_pos = cds_pos // 3
    codon_start = start + codon_pos * 3

    codon = genome_seq[codon_start:codon_start + 3]

    if strand == -1:
        codon = codon.reverse_complement()

    codon = list(str(codon))

    codon_index = cds_pos % 3

    mutated_codon = codon.copy()
    mutated_codon[codon_index] = snp["ALT"]

    aa_ref = translate_codon("".join(codon))
    aa_alt = translate_codon("".join(mutated_codon))

    aa_pos = codon_pos + 1

    if aa_ref == aa_alt:
        snp_type = "synonymous"
        effect = "low"
    else:
        snp_type = "nonsynonymous"
        effect = "moderate"

    results.append({
        "pos": snp["P1"],
        "gene": gene,
        "type": snp_type,
        "aa_change": f"p.{aa_ref}{aa_pos}{aa_alt}",
        "effect": effect
    })

annotated = pd.DataFrame(results)

annotated.to_csv("../results/snps_annotated.tsv", sep="\t", index=False)

# топ-10 генов
top_genes = (
    annotated[annotated["gene"] != "intergenic"]
    .groupby("gene")
    .size()
    .sort_values(ascending=False)
    .head(10)
)

top_genes.to_csv("../results/top_genes.tsv", sep="\t")

# SNP density
plt.figure(figsize=(14, 6))

plt.hist(annotated["pos"], bins=100, alpha=0.6, label="SNP density")

for _, g in genes_df.iterrows():
    plt.axvspan(g["start"], g["end"], color = "lightblue", alpha=0.08)

# легенда-обманка (чтобы гены были видны в legend)
plt.plot([], [], color="lightblue", alpha=0.3, linewidth=10, label="Genes")

plt.title("SNP density with gene regions")
plt.xlabel("Position")
plt.ylabel("Count")

plt.legend()

plt.tight_layout()

plt.savefig("../results/snp_density.png")
plt.close()# распределение типов SNP
plt.figure(figsize=(7, 5))

type_counts = annotated["type"].value_counts()

colors = {
    "synonymous": "#4CAF50",
    "nonsynonymous": "#F44336",
    "intergenic": "#9E9E9E"
}

bars = plt.bar(
    type_counts.index,
    type_counts.values,
    color=[colors.get(x, "blue") for x in type_counts.index]
)

plt.title("SNP type distribution")
plt.ylabel("Count")

plt.xticks(rotation=0)

# короткие подписи 
plt.gca().set_xticklabels([
    "Synonymous",
    "Nonsynonymous",
    "Intergenic"
])

plt.tight_layout()

plt.savefig("../results/impact_distribution.png", dpi=300)
plt.close()
print("Analysis completed!")
