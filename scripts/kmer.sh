#!/bin/bash

qiime boots kmer-diversity \
	--i-table results/dada2/table-filtered.qza \
	--i-sequences results/dada2/rep-seqs-filtered.qza \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--p-sampling-depth 2000 \
	--p-n 10 \
	--p-kmer-size 8 \
	--p-replacement False \
	--p-alpha-average-method median \
	--p-beta-average-method medoid \
	--o-resampled-tables results/bootstrap-tables.qza \
	--o-kmer-tables results/kmer-tables.qza \
	--o-distance-matrices results/kmer-distance-matrices.qza \
	--o-alpha-diversities results/kmer-alpha-diversity.qza \
	--o-pcoas results/bootstrap-pcoas.qza \
	--o-scatter-plot results/kmer-scatter-plot.qzv
