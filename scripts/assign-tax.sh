#!/bin/bash

qiime feature-classifier classify-sklearn \
	--i-classifier training-feature-classifiers/classifier.qza \
	--i-reads results/dada2/rep-seqs-filtered.qza \
	--o-classification results/dada2/taxonomy-filtered.qza
