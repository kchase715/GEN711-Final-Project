#!/bin/bash

qiime feature-table tabulate-seqs \
	--i-data results/dada2/rep-seqs-filtered.qza \
	--i-taxonomy results/dada2/taxonomy-filtered.qza \
	--o-visualization results/dada2/asv-seqs-filtered.qzv
