import pandas as pd
import matplotlib.pyplot as plt

snps = pd.read_csv("../results/snps_annotated.tsv", sep="\t")
genes_table = pd.read_csv("../results/genes_table.tsv", sep="\t")

metal_genes = {
    "Cu": ["nusA", "pagP", "atpC", "dpiA", "tatE", "dpiB"],
    "Cd": ["hflB", "araG", "napB", "araH"],
    "Pb": ["chaB", "lolD"],
    "Cr": ["nepI"]
}

gene_to_metal = {
    gene: metal
    for metal, genes in metal_genes.items()
    for gene in genes
}

snps = snps[snps["gene"].isin(gene_to_metal.keys())].copy()
snps["metal"] = snps["gene"].map(gene_to_metal)

snps = snps.merge(
    genes_table[["gene", "product"]],
    on="gene",
    how="left"
)

print("SNPs per gene")
print(snps["gene"].value_counts())

print("SNPs per metal")
print(snps["metal"].value_counts())

if "type" in snps.columns:
    print("SNP effect distribution")
    print(snps["type"].value_counts())

snps.to_csv("../results/part3_functional_snps.tsv", sep="\t", index=False)

plt.figure(figsize=(8, 5))
snps["gene"].value_counts().plot(kind="bar")
plt.title("SNP distribution across genes")
plt.xlabel("Gene")
plt.ylabel("Number of SNPs")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("../results/snp_per_gene.png", dpi=300)
plt.close()

plt.figure(figsize=(6, 4))
snps["metal"].value_counts().plot(kind="bar")
plt.title("SNP distribution by metal category")
plt.xlabel("Metal")
plt.ylabel("Number of SNPs")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("../results/snp_per_metal.png", dpi=300)
plt.close()

plt.figure(figsize=(10, 5))
snps["product"].value_counts().head(10).plot(kind="bar")
plt.title("Top affected protein functions")
plt.xlabel("Protein function")
plt.ylabel("Number of SNPs")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.savefig("../results/snp_per_product.png", dpi=300)
plt.close()

summary = snps.groupby(["gene", "metal", "product"]).size().reset_index(name="SNP_count")
summary.to_csv("../results/part3_summary_table.tsv", sep="\t", index=False)

print("Analysis completed")
