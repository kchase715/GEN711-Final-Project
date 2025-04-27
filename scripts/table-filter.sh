#!/bin/bash

qiime feature-table filter-samples \
	--i-table results/dada2/table.qza \
	--p-min-frequency 1000 \
	--o-filtered-table results/dada2/table-filtered.qza
