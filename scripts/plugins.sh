#!/bin/bash

pip install git+https://github.com/bokulich-lab/q2-kmerizer.git

pip install git+https://github.com/caporaso-lab/q2-boots.git

qiime dev refresh-cache
