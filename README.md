# GEN711 Final Project
## Pond Microbiome Study

### Members 
- Kendell Chase
- Avery Hathaway

---

## Background
16s rRNA sequencing data was borrowed from a graduate student studying the microbiome composition of duckweeds.
The dataset includes:

- 40 paired-end FASTQ files from 20 samples (Illumina HiSeq 2500, 250 bp)
- Two pond sampling locations
- Two treatments:
  - Microbiome from duckweed skimmed off the pond surface
  - Microbiome from pond water
- 5 replicates per treatment
- A metadata file describing the samples
- A manifest file listing the FASTQ locations
  
- **Project Goal:** To analyze and compare the microbial community composition between duckweed and pond water samples.

---

## Methods
**Methods Flow Chart**
![Methods Flow Chart](M.Flow.C.png)
### Data Source 
- Provided by a graduate student working on duckweed microbiomes
- Data Type: Paired-end 250 bp reads (FASTQ format)

### Analysis
- Conducted on RON remote cluster with `tmux` and `conda`
- Code was run in the `qiime2-amplicon-2024.5` and `qiime2-amplicon-2024.10` environments

### Tools Used

#### QIIME2
- Used for data import, demultiplexing, denoising with DADA2, taxonomic classification, and diversity analysis
- Imported FASTQ files using a manifest
- Denoised using `qiime dada2 denoise-paired`
- Generated feature table and representative sequences

#### Taxonomic Composition
- Trained classifier using SILVA reference database
  - Extracted 515F-806R region to match primers
- Ran taxonomy classification with `qiime feature-classifier classify-skylearn`
- Visualized using `qiime taxa barplot` at phylum level (Level 2)

#### q2-kmerizer + q2-boots
- Used to perform kmer-based diversity analysis (instead of building phylogenetic trees)
- Implemented via `qiime boots kmer-diversity`
- Calculated alpha and beta diversity metrics (e.g., Shannon, Evenness, Bray-Curtis)

#### Alpha Rarefaction
- Used `qiime diversity alpha-rarefaction` to assess species richness over sequencing depth
- Chose max-depth of 2500 based on frequency distribution

#### Differential Abundance
- Collapsed feature table to genus level
- Ran ANCOM-BC using `qiime composition ancombc`
- Compared duckweed vs. water samples for significantly enhanced or lacking genera

## Findings
![Taxonomic Bar Plot](image001.png)
**Figure 1. Taxonomic Composition by Sample Type (Phylum Level)**
- Barplot
- Shows dominant phyla across duckweed and pond water microbiomes
- Generated using qiime taxa barplot
- Inputs:
  - `asv-table.qza`
  - `metadata.tsv`
  - `taxonomy.qza`

 
![Alpha Rarefaction Curve 1](image002.png)
![Alpha Rarefaction Curve 2](image003.png)
**Figure 2. Alpha Rarefaction Curve (Observed Features)**
- Line Graph
- Shows alpha diversity plotted across sequencing depths
- Created with `qiime diversity alpha-rarefaction`
- Inputs:
  - `alpha-rarefraction.qzv`
- Confirms 2500 as a resonable sampling depth

## Final Script
[View Final Script](script.sh)

## Citations
1. Gut-to-Soil Axis Tutorial Microbiome Marker
Gene Analysis with QIIME 2. https://amplicon-
docs.qiime2.org/en/latest/tutorials/gut-to-
soil.html#LiWetXeH8D. Accessed 10 May 2025.
2. QIIME 2 View. https://view.qiime2.org/.
Accessed 10 May 2025.
3. Training Feature Classifiers with Q2-Feature-
Classifier — QIIME 2 2024.2.0 Documentation.
https://docs.qiime2.org/2024.2/tutorials/feature-
classifier/. Accessed 10 May 2025.
