#!/bin/bash

qiime composition ancombc \
	--i-table genus-table-dominant-types.qza \
	--m-metadata-file qiime2_dataset/metadata.tsv \
	--p-formula sample_type \
	--p-reference-levels 'sample_type::water' \
	--o-differentials genus-ancombc.qza
