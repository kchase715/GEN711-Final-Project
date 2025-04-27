#!/bin/bash

qiime feature-table filter-seqs \
	--i-data results/dada2/rep-seqs.qza \
	--i-table results/dada2/table-filtered.qza \
	--o-filtered-data results/dada2/rep-seqs-filtered.qza
