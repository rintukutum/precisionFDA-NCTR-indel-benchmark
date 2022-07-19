#! /bin/bash
#PBS -N pfda
#PBS -o out.log
#PBS -e err.log
#PBS -l mem=12gb,ncpus=12
#PBS -q cpu

module load compiler/anaconda3

conda init

source ~/.bashrc

conda activate indel-oncopanel

storage_path='/storage/bic/data/pfda-nctr/clever-test'

cd $storage_path

clever --use_xa input.bam reference/hg19.fa results/