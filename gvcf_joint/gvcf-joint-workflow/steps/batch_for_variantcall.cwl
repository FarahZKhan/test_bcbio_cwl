arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=multi-batch
- sentinel_outputs=batch_rec:description;config__algorithm__validate;reference__fasta__base;config__algorithm__variantcaller;config__algorithm__coverage_interval;metadata__batch;metadata__phenotype;reference__snpeff__hg19;config__algorithm__validate_regions;genome_build;genome_resources__aliases__human;config__algorithm__tools_off;genome_resources__variation__dbsnp;genome_resources__variation__cosmic;reference__genome_context;analysis;config__algorithm__tools_on;config__algorithm__variant_regions;genome_resources__aliases__ensembl;reference__rtg;genome_resources__aliases__snpeff;align_bam;regions__sample_callable;config__algorithm__callable_regions
- sentinel_inputs=analysis:var,genome_build:var,align_bam:var,config__algorithm__callable_regions:var,metadata__batch:var,metadata__phenotype:var,regions__sample_callable:var,config__algorithm__variantcaller:var,config__algorithm__coverage_interval:var,config__algorithm__variant_regions:var,config__algorithm__validate:var,config__algorithm__validate_regions:var,config__algorithm__tools_on:var,config__algorithm__tools_off:var,reference__fasta__base:var,reference__rtg:var,reference__genome_context:var,genome_resources__variation__cosmic:var,genome_resources__variation__dbsnp:var,genome_resources__aliases__ensembl:var,genome_resources__aliases__human:var,genome_resources__aliases__snpeff:var,reference__snpeff__hg19:var,description:var
baseCommand:
- bcbio_nextgen.py
- runfn
- batch_for_variantcall
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-vc
  dockerPull: quay.io/bcbio/bcbio-vc
- class: ResourceRequirement
  coresMin: 1
  outdirMin: 1031
  ramMin: 2048
  tmpdirMin: 7
inputs:
- id: analysis
  type:
    items: string
    type: array
- id: genome_build
  type:
    items: string
    type: array
- id: align_bam
  secondaryFiles:
  - .bai
  type:
    items: File
    type: array
- id: config__algorithm__callable_regions
  type:
    items: File
    type: array
- id: metadata__batch
  type:
    items: string
    type: array
- id: metadata__phenotype
  type:
    items: string
    type: array
- id: regions__sample_callable
  type:
    items: File
    type: array
- id: config__algorithm__variantcaller
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__coverage_interval
  type:
    items: string
    type: array
- id: config__algorithm__variant_regions
  type:
    items: File
    type: array
- id: config__algorithm__validate
  type:
    items:
    - File
    - 'null'
    - string
    type: array
- id: config__algorithm__validate_regions
  type:
    items:
    - File
    - 'null'
    - string
    type: array
- id: config__algorithm__tools_on
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__tools_off
  type:
    items:
      items: string
      type: array
    type: array
- id: reference__fasta__base
  secondaryFiles:
  - .fai
  - ^.dict
  type:
    items: File
    type: array
- id: reference__rtg
  type:
    items: File
    type: array
- id: reference__genome_context
  secondaryFiles:
  - .tbi
  type:
    items:
      items: File
      type: array
    type: array
- id: genome_resources__variation__cosmic
  secondaryFiles:
  - .tbi
  type:
    items: File
    type: array
- id: genome_resources__variation__dbsnp
  secondaryFiles:
  - .tbi
  type:
    items: File
    type: array
- id: genome_resources__aliases__ensembl
  type:
    items: string
    type: array
- id: genome_resources__aliases__human
  type:
    items:
    - string
    - 'null'
    - boolean
    type: array
- id: genome_resources__aliases__snpeff
  type:
    items: string
    type: array
- id: reference__snpeff__hg19
  type:
    items: File
    type: array
- id: description
  type:
    items: string
    type: array
outputs:
- id: batch_rec
  type:
    items:
      items:
        fields:
        - name: description
          type: string
        - name: config__algorithm__validate
          type:
          - File
          - 'null'
          - string
        - name: reference__fasta__base
          type: File
        - name: config__algorithm__variantcaller
          type: string
        - name: config__algorithm__coverage_interval
          type: string
        - name: metadata__batch
          type: string
        - name: metadata__phenotype
          type: string
        - name: reference__snpeff__hg19
          type: File
        - name: config__algorithm__validate_regions
          type:
          - File
          - 'null'
          - string
        - name: genome_build
          type: string
        - name: genome_resources__aliases__human
          type:
          - string
          - 'null'
          - boolean
        - name: config__algorithm__tools_off
          type:
            items: string
            type: array
        - name: genome_resources__variation__dbsnp
          type: File
        - name: genome_resources__variation__cosmic
          type: File
        - name: reference__genome_context
          type:
            items: File
            type: array
        - name: analysis
          type: string
        - name: config__algorithm__tools_on
          type:
            items: string
            type: array
        - name: config__algorithm__variant_regions
          type: File
        - name: genome_resources__aliases__ensembl
          type: string
        - name: reference__rtg
          type: File
        - name: genome_resources__aliases__snpeff
          type: string
        - name: align_bam
          type: File
        - name: regions__sample_callable
          type: File
        - name: config__algorithm__callable_regions
          type: File
        name: batch_rec
        type: record
      type: array
    type: array
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
