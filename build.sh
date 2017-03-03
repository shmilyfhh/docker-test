#!/bin/bash


#loop over all the files containing scater objects
for file in *rds ; do
    Rscript estimate_k.R $file k_estimation.tsv
done

