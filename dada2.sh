#!/bin/bash

qiime dada2 denoise-paired \
	--i-demultiplexed-seqs ../data/paired-end-demux.qza \
	--p-trim-left-f 0 \
	--p-trim-left-r 0 \
	--p-trunc-len-f 250 \
	--p-trunc-len-r 150 \
	--o-table dada2/table.qza \
	--o-representative-sequences dada2/rep-seqs.qza \
	--o-denoising-stats dada2/denoising-stats.qza
