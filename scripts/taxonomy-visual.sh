#!/bin/bash

qiime metadata tabulate \
	--m-input-file results/dada2/taxonomy.qza \
	--o-visualization results/dada2/taxonomy.qzv
