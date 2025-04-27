#!/bin/bash

qiime feature-table tabulate-seqs \
	--i-data results/dada2/rep-seqs.qza \
	--o-visualization results/dada2/rep-seqs.qzv
