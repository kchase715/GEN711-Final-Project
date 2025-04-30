#!/bin/bash

qiime feature-classifier classify-sklearn \
	--i-classifier silva-138-99-nb-classifier.qza \
	--i-reads rep-seqs-filtered.qza \
	--o-classification taxonomy.qza
