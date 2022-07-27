configfile = "config.yaml"

rule all:
    input:
        "all.vcf"

def get_left_reads(wildcards):
    return config["left_reads"][wildcards.sample]

def get_right_reads(wildcards):
    return config["right_reads"][wildcards.sample]

rule bwa_map:
    input:
        fa = "reference/hg19.fa",
        left_read = get_left_reads,
        right_read = get_right_reads
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
    input:
        "sorted_reads/{sample}.bam"
    output:
        "sorted_reads/marked_duplicates_{sample}.bam"
    shell:
        "java -jar picard.jar MarkDuplicates "
        "I={input}.bam "
        "O={output}.bam "
        "M=marked_dup_metrics_{wildcards.sample}.txt"

rule delly:
    input:
        fa="reference/hg19.fa",
        bam="sorted_reads/{sample}.bam"
    output:
        "delly/{sample}.bcf"
    shell:
        "delly call -o {output} -g {input.fa} {input.bam}"

rule convert_to_vcf:
    input:
        "delly/{sample}.bcf"
    output:
        "delly/{sample}.vcf"
    shell:
        "bcftools view {input} > {output}"