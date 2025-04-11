#!/bin/bash

#Step 1: Import Data

source activate qiime2-amplicon-2024.5

qiime tools import \
	--type 'SampleData[PairedEndSequencesWithQuality]' \
	--input-path qiime2_dataset/manifest.tsv \
	--output-path paired-end-demux.qza \
	--input-format PairedEndFastqManifestPhred33V2
