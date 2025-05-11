# GEN711 Final Project
## Pond Microbiome Study

## Members 
- Kendell Chase & Avery Hathaway

## Background
- The data for this project was borrowed from a graduate student who is studying the microbiome composition of duckweed. We recieved 40 paired-end fastq files and a metadata file. The sequencing was performed on an Illumina HiSeq 2500 platform and 250 bp paired-end reads were produced. 
- The dataset included:
        - 20 total samples
        - Two pond sampling locations
        - Two treatments:
                  - Microbiome sampled from duckweed gathered on surface of the pond
                  - Microbiome sampled from the pond water
        - 5 replicates per treatment per location
        - A metadata file for sample groupings
        - A manifest file for Qiime2 import
- Our goal was to analyze and compare the microbial communities between the duckweed-associated and water-associated microbiomes.

## Methods
- **Data Source:** Borrowed from a graduate student working on duckweed microbiomes
- **Data Type:** 16s rRNA sequencing, paired-end, 250 bp reads
- **Analysis:** Performed on RON using QIIME2 and conda environments
- **Pipeline:**
        1. Importing Data
                  - Used qiime tools import with metadata and manifest files
                  - Imported as SampleData[PairedEndSequencesWithQuality]
        2. Demultiplexing Visualization
                  - Visualized read quality with qiime demux summarize
        3. Denoising with DADA2
                  - Used qiime dada2 denoise-paired
                  - Output: Feature table, representative sequences, denoising stats
        4. Filtering Low-Count Features
                  - Used qiime feature-table filter-features
        5. Taxonomic Classification
                  - Trained a custom classifier on Greengenes data
                  - Classified using qiime feature-classifier classify-sklearn
        6. Diversity Analysis with q2-boots/q2-kmerizer
                  - Installed plugins into a downloaded QIIME2 2024.10 environment
                  - Used qiime boots kmer-diversity with a sampling depth of 2500
                  - Generated ordination (PCoA) and alpha/beta diversity stats
        7. Alpha Rarefaction
                  - qiime diversity alpha-rarefaction with max-depth 2500
                  - Assessed if sampling depth captured community richness accurately
        8. Taxonomic Bar Plots
                  - qiime taxa barplot used to visualize relative abundance by phylum
        9. Differential Abundance (ANCOM-BC)
                  - Collapsed features to genus level
                  - Ran qiime composition ancombc and qiime composition da-barplot
                  - Compared enrichment/depletion across sample types
  
- what did the program do?
        - a paragraph or two at most (for each tool)
- what did that produce?
- what program did you use next?
- write out whole pipeline ...
- how did you visualize your results?

## Findings
- label figure (Figure1)
- what kind of plot is it? (i.e., venn diagram)
- what does the plot show? 
- how did you create the plot?
- what was the input to the plot?
- figure caption formatting
       - (do this for 2 figures)

## Citations
