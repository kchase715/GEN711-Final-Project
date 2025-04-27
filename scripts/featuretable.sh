#!/bin/bash

qiime feature-table summarize \
	--i-table results/dada2/table.qza \
	--o-visualization results/dada2/table.qzv \
	--m-sample-metadata-file qiime2_dataset/metadata.tsv
