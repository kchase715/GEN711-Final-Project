#!/bin/bash

qiime feature-table filter-samples \
	--i-table results/dada2/table.qza \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--p-where '[sample_type] IN ("duckweed", "water")' \
	--o-filtered-table asv-table-dominant-types.qza
