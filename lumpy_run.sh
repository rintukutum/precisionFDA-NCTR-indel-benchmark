#! /bin/bash
#PBS -N pfda
#PBS -o out.log
#PBS -e err.log
#PBS -l ncpus=1
#PBS -q cpu

module load compiler/anaconda

conda activate indel-oncopanel

absolute_path='/home/rintu.kutum/office/intern-rudra/workflow/lumpy-test-fda'
storage_path='/storage/bic/data/pfda-nctr/data/test'

bwa mem $storage_path/reference/hg19.fa $storage_path/data/PanelA_LAB1_LIB1_R1.fastq.gz $storage_path/data/PanelA_LAB1_LIB1_R3.fastq.gz | samtools view -Sb - > $storage_path/mapped_reads/read_1.bam

samtools sort -T $storage_path/sorted_reads/read_1.bam -O bam $storage_path/mapped_reads/read_1.bam > $storage_path/sorted_reads/read_1.bam

samtools index $storage_path/sorted_reads/read_1.bam