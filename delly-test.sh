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

storage_path='/storage/bic/data/pfda-nctr/delly-test'

cd $storage_path

bwa mem reference/hg19.fa data/PanelA_LAB1_LIB1_R1.fastq.gz data/PanelA_LAB1_LIB1_R3.fastq.gz | samtools view -Sb - > input.bam

samtools sort input.bam > input_sorted.bam

samtools index sorted/input.bam

java -jar picard.jar MarkDuplicates \
      I=input_sortedt.bam \
      O=marked_duplicate.bam

delly call -x hg19.excl -o delly-test.bcf -g reference/hg19.fa input_sorted.bam

bcftools view delly-test.bcf > delly-test.vcf
