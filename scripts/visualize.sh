#!/bin/bash

mkdir -p results

qiime demux summarize \
	--i-data ../data/paired-end-demux.qza \
	--o-visualization ../results/paired-end-demux.qzv
