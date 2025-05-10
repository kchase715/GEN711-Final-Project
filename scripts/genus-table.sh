#!/bin/bash

qiime taxa collapse \
	--i-table asv-table-dominant-types.qza \
	--i-taxonomy results/dada2/taxonomy.qza \
	--p-level 6 \
	--o-collapsed-table genus-table-dominant-types.qza
