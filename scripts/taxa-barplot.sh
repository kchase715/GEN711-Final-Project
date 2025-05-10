#!/bin/bash

qiime taxa barplot \
	--i-table results/dada2/table.qza \
	--i-taxonomy results/dada2/taxonomy.qza \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--o-visualization results/taxa-bar-plots.qzv
