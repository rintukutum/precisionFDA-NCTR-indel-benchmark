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

absolute_path='/home/rintu.kutum/office/intern-rudra/workflow/lumpy-test-fda'
storage_path='/storage/bic/data/pfda-nctr/data/test'

bwa mem -R "@RG\tID:read1\tSM:read1\tLB:lib" $storage_path/reference/hg19.fa \
    $storage_path/data/PanelA_LAB1_LIB1_R1.fastq.gz $storage_path/data/PanelA_LAB1_LIB1_R3.fastq.gz \
    | samblaster --excludeDups --addMateTags --maxSplitCount 2 --minNonOverlap 20 \
    | samtools view -S -b - \
    > $storage_path/read_1.bam

samtools view -b -F 1294 $storage_path/read_1.bam > $storage_path/read_1.discordants.unsorted.bam

samtools view -h $storage_path/read_1.bam \
    | $absolute_path/extractSplitReads_BwaMem -i stdin \
    | samtools view -Sb - \
    > $storage_path/read_1.splitters.unsorted.bam

samtools sort $storage_path/read_1.discordants.unsorted.bam > $storage_path/read_1.discordants.bam

samtools sort $storage_path/read_1.splitters.unsorted.bam > $storage_path/read_1.splitters.bam

lumpyexpress \
    -B $storage_path/read_1.bam \
    -S $storage_path/read_1.splitters.bam \
    -D $storage_path/read_1.discordants.bam \
    -o $storage_path/read_1.vcf 