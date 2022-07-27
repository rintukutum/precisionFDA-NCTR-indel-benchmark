rule all:
    input:
        "all.vcf"

rule bwa_map:
    input:
        fa = "reference/hg19.fa",
        left_read = "{sample}_R1.fastq.gz",
        right_read = "{sample}_R3.fastq.gz"
    output:
        "mapped_reads/{sample}.bam"
    shell:
        "bwa mem {input.fa} {input.left_read} {input.right_read} | samtools view -Sb - > {output}"

rule samtools_sort:
    input:
        "mapped_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam"
    shell:
        "samtools sort -T sorted_reads/{wildcards.sample} -O bam {input} > {output}"

rule samtools_index:
    input:
        "sorted_reads/{sample}.bam"
    output:
        "sorted_reads/{sample}.bam.bai"
    shell:
        "samtools index {input}"

rule mark_duplicates:
