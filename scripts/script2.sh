#!/bin/bash

source activate qiime2-amplicon-2024.5

#Summarize demultiplexed paired-end data

qiime demux summarize \
	--i-data paired-end-demux.qza \
	--o-visualization paired-end-demux.qzv
