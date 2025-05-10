#!/bin/bash

qiime composition da-barplot \
	--i-data genus-ancombc.qza \
	--p-significance-threshold 0.001 \
	--p-level-delimiter ';' \
	--o-visualization genus-ancombc.qzv
