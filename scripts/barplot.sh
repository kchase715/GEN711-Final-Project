#!/bin/bash

qiime taxa barplot \
	--i-table results/dada2/table-filtered.qza \
	--i-taxonomy results/dada2/taxonomy-filtered.qza \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--o-visualization results/dada2/taxa-bar-plots.qzv
