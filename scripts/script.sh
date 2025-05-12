#!/bin/bash

# Exit on error
set -e

# Activate QIIME2 environment
source activate qiime2-amplicon-2024.10

#Set base paths
BASE_DIR="$(dirname "$0")/.."
DATA_DIR="$BASE_DIR/../qiime2_dataset"
RESULTS_DIR="$BASE_DIR/../results"
CLASSIFIER_DIR="$BASE_DIR/../training-feature-classifiers"
DADA2_DIR="$BASE_DIR/../dada2"

MANIFEST="$DATA_DIR/manifest.tsv"
METADATA="$DATA_DIR/metadata.tsv"
DEMUX="$BASE_DIR/../data/paired-end-demux.qza"
DEMUX_VIS="$BASE_DIR/../data/paired-end-demux.qzv"

#Create directories
mkdir -p "$BASE_DIR/../data" "$DADA2_DIR" "$RESULTS_DIR/dada2"

echo "### IMPORTING DATA ###"
qiime tools import \
	--type 'SampleData[PairedEndSequencesWithQuality]' \
	--input-path "$MANIFEST" \
	--output-path "$DEMUX" \
	--input-format PairedEndFastqManifestPhred33V2

qiime demux summarize \
	--i-data "$DEMUX" \
	--o-visualization "$DEMUX_VIS"

### DADA2 Denoising ###
echo "### RUNNING DADA2 ###"
qiime dada2 denoise-paired \
	--i-demultiplexed-seqs "$DEMUX" \
	--p-trim-left-f 0 \
	--p-trim-left-r 0 \
	--p-trunc-len-f 250 \
	--p-trunc-len-r 150 \
	--o-table "$DADA2_DIR/table.qza" \
	--o-representative-sequences "$DADA2_DIR/rep-seqs.qza" \
	--o-denoising-stats "$DADA2_DIR/denoising-stats.qza"

qiime metadata tabulate \
	--m-input-file "$DADA2_DIR/denoising-stats.qza" \
	--o-visualization "$DADA2_DIR/denoising-stats.qzv"

## FILTERING & TABULATING ###
echo "### FILTERING BY MINIMUM FREQUENCY ###"
qiime feature-table filter-samples \
	--i-table "$DADA2_DIR/table.qza" \
	--p-min-frequency 1000 \
	--o-filtered-table "$DADA2_DIR/table-filtered.qza"

qiime feature-table filter-seqs \
	--i-data "$DADA2_DIR/rep-seqs.qza" \
	--i-table "$DADA2_DIR/table-filtered.qza" \
	--o-filtered-data "$DADA2_DIR/rep-seqs-filtered.qza"

qiime feature-table tabulate-seqs \
	--i-data "$DADA2_DIR/rep-seqs.qza" \
	--o-visualization "$DADA2_DIR/rep-seqs.qzv"

### CLASSIFIER TRAINING AND TAXONOMY ###
echo "### TRAINING CLASSIFIER AND CLASSIFYING SEQUENCES ###"
qiime feature-classifier extract-reads \
	--i-sequences "$CLASSIFIER_DIR/85_otus.qza" \
	--p-f-primer GTGCCAGCMGCCGCGGTAA \
	--p-r-primer GGACTACHVGGGTWTCTAAT \
	--p-trunc-len 0 \
	--p-min-length 100 \
	--p-max-length 400 \
	--o-reads "$CLASSIFIER_DIR/extract-reference.qza"

qiime feature-classifier fit-classifier-naive-bayes \
	--i-reference-reads "$CLASSIFIER_DIR/extract-reference.qza" \
	--i-reference-taxonomy "$CLASSIFIER_DIR/ref-taxonomy.qza" \
	--o-classifier "$CLASSIFIER_DIR/classifier.qza"

qiime feature-classifier classify-sklearn \
	--i-classifier "$CLASSIFIER_DIR/classifier.qza" \
	--i-reads "$DADA2_DIR/rep-seqs-filtered.qza" \
	--o-classification "$DADA2_DIR/taxonomy.qza"

qiime metadata tabulate \
	--m-input-file "$DADA2_DIR/taxonomy.qza" \
	--o-visualization "$DADA2_DIR/taxonomy.qzv"

qiime feature-table tabulate-seqs \
	--i-data "$DADA2_DIR/rep-seqs-filtered.qza" \
	--i-taxonomy "$DADA2_DIR/taxonomy.qza" \
	--o-visualization "$DADA2_DIR/asv-seqs-filtered.qzv"

### ALPHA RAREFACTION ###
echo "### RUNNING ALPHA RAREFACTION ###"
qiime diversity alpha-rarefaction \
	--i-table "$DADA2_DIR/table-filtered.qza" \
	--p-max-depth 2500 \
	--m-metadata-file "$METADATA" \
	--o-visualization "$RESULTS_DIR/alpha-rarefaction.qzv"

### TAXA BARPLOTS ###
echo "### TAXONOMIC BAR PLOTS ###"
qiime taxa barplot \
	--i-table "$DADA2_DIR/table.qza" \
	--i-taxonomy "$DADA2_DIR/taxonomy.qza" \
	--m-metadata-file "$METADATA" \
	--o-visualization "$RESULTS_DIR/taxa-bar-plots.qzv"

### KMER-BASED DIVERSITY ###
echo "### KMER-BASED DIVERSITY ANALYSIS ###"

qiime boots kmer-diversity \
	--i-table "$DADA2_DIR/table-filtered.qza" \
	--i-sequences "$DADA2_DIR/rep-seqs-filtered.qza" \
	--m-metadata-file "$METADATA" \
	--p-sampling-depth 2000 \
	--p-n 10 \
	--p-kmer-size 8 \
	--p-replacement False \
	--p-alpha-average-method median \
	--p-beta-average-method medoid \
	--o-resampled-tables "$RESULTS_DIR/bootstrap-tables.qza" \
	--o-kmer-tables "$RESULTS_DIR/kmer-tables.qza" \
	--o-distance-matrices "$RESULTS_DIR/kmer-distance-matrices.qza" \
	--o-alpha-diversities "$RESULTS_DIR/kmer-alpha-diversity.qza" \
	--o-pcoas "$RESULTS_DIR/bootstrap-pcoas.qza" \
	--o-scatter-plot "$RESULTS_DIR/kmer-scatter-plot.qzv"

### ANCOM-BC DIFFERENTIAL ABUNDANCE ###
echo "### ANCOM-BC DIFFERENTIAL ABUNDANCE ###"
qiime feature-table filter-samples \
	--i-table "$DADA2_DIR/table-filtered.qza" \
	--m-metadata-file "$METADATA" \
	--p-where '[SampleType] IN ("Duckweed", "PondWater")' \
	--o-filtered-table "$RESULTS_DIR/dominant-types.qza"

qiime taxa collapse \
	--i-table "$RESULTS_DIR/dominant-types.qza" \
	--i-taxonomy "$DADA2_DIR/taxonomy.qza" \
	--p-level 6 \
	--o-collapsed-table "$RESULTS_DIR/genus-table.qza"

qiime composition add-pseudocount \
	--i-table "$RESULTS_DIR/genus-table.qza" \
	--o-composition-table "$RESULTS_DIR/genus-table-comp.qza" \

qiime composition ancombc \
	--i-table "$RESULTS_DIR/genus-table-comp.qza" \
	--m-metadata-file "$METADATA" \
	--p-formula SampleType \
	--p-reference-levels 'SampleType::Duckweed' \
	--o-differentials "$RESULTS_DIR/genus-ancombc.qza"

qiime composition da-barplot \
	--i-data "$RESULTS_DIR/genus-ancombc.qza" \
	--p-significance-threshold 0.001 \
	--p-level-delimiter ';' \
	--o-visualization "$RESULTS_DIR/genus-ancombc.qzv"

echo "### PIPELINE COMPLETE ###"
