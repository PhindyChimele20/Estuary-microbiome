#  README

## 1. Data sources

This task is based on on publicly available sequencing data from the study " Decomposing a San Francisco estuary microbiome using long read metagenomics reveals species- and strain-level dominance 
from picoeukaryotes to viruses" which focused decomposing an estuarine metagenome to obtain a more accurate estimate of microbial diversity. ONT long-read sequencing was done using two R9.4.1 MinION 
flow cells and two R10.4 PromethION flow cells.. For this analysis only the assemblied long reads contigs are used as the inputs for the workflow.

---

## 2. How to download

The refined genome bins from the nano pore metagenome assemblies are available on Zenodo (https://zenodo.org/records/13227923). The Illumina sequencing data and metagenome assemblies are also available 
on Zenodo (https://zenodo.org/records/13228283).


## 3. Pre-processing 

From the Zenodo site we downloaded the refined genome binz .fasta.gz file that we used as the input for the workflow

## 4. How the workflow works
The workflow files is stored in workflow/ and it is divided into different steps:
The workflow files are stored in `workflow/`.

---

### Step 1 – Quality Check

**Purpose:** The workflow takes each contig and assess the quality
**Tools:** `quast`
**Inputs:** fasta files (from `data/`)
**Outputs:** quality matrix (html)
**Command:**

```bash
quast.py illumina_contigs.fasta.gz -o illumina_contigs

```

---

### Step 2 - Protein and RNA gene annotatio

**Purpose:** From the assemblied genome contigs, this part of the workflow predicts genes and proteins of the genome
**Tools:** 'Prodigal'
**Inputs:** fasta file
**Outputs:** genes.fasta and proteins.fasta
**Command:**

```bash
prodigal -i illumina_contigs.fasta.gz -o illumina_contigs.gff -a illumina_proteins.fasta -d illumina_genes.fasta

```
---

### Step 3 – Plasmid and virus classification 

**Purpose:** the pipeline classifies contigs as mobile genetic elements (i.e., plasmids and viruses) and to assign viral taxonomy
**Tools:** 'geNomad', 'dedupe', 'cmscan'
**Inputs:** fasta.gz
**Outputs:** genomad.output, .fna, contigs.cmscan
**Command:**
```bash
genomad end-to-end illumina_contigs.fasta.gz illumina_contigs_genomad.ouput /home/databases/genomad/genomad_db  -t 12

dedupe.sh in=illumina_contigs_genomad.output/illumina_contigs_summary/illumina_contigs_virus.fna \
          out=illumina_contigs_virus_deduped.fna \
          minidentity=95

cmscan --rfam --cut_ga --nohmmonly --tblout illumina_contigs.tblout --fmt 2 --clanin Rfam.clanin Rfam.cm illumina_contigs.fasta.gz > illumina_contigs.cmscan

```
---
