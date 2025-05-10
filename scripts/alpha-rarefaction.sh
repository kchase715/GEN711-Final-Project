#!/bin/bash

qiime diversity alpha-rarefaction \
	--i-table results/dada2/table.qza \
	--p-max-depth 2500 \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--o-visualization alpha-rarefaction.qzv
