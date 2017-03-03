#!/bin/bash


#loop over all the files containing scater objects
wget https://scrnaseq-public-datasets.s3.amazonaws.com/scater-objects/biase.rds

Rscript estimate_k.R biase.rds k_estimation.tsv

