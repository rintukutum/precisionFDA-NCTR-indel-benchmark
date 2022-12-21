import glob
import subprocess

reference = "reference/hg19.fa"
left_reads = glob.glob("data/*_R1.fastq.gz")
right_reads = glob.glob("data/*_R2.fastq.gz")

for i in left_reads:
    subprocess.call("bwa mem ", reference ,left_reads[i], right_reads[i], " | samtools view -Sb - > ", )