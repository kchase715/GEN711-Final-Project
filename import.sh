#! /bin/bash

source activate qiime2-amplicon-2024.5

qiime tools import \
	--type 'SampleData[PairedEndSequencesWithQuality]' \
	--input-path qiime2_dataset/manifest.tsv \
	--output-path data/paired-end-demux.qza \
	--input-format PairedEndFastqManifestPhred33V2

