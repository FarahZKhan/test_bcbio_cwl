arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
baseCommand:
- bcbio_nextgen.py
- runfn
- batch_for_variantcall
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-base
  dockerPull: quay.io/bcbio/bcbio-base
- class: ResourceRequirement
  coresMin: 1
  outdirMin: 1024
  ramMin: 2048
inputs:
- default: multi-batch
  id: sentinel_parallel
  inputBinding:
    itemSeparator: ;;
    position: 0
    prefix: sentinel_parallel=
    separate: false
  type: string
- default: batch_rec:description;config__algorithm__validate;reference__fasta__base;reference__rtg;config__algorithm__variantcaller;config__algorithm__coverage_interval;metadata__batch;metadata__phenotype;reference__genome_context;config__algorithm__validate_regions;genome_build;config__algorithm__tools_off;genome_resources__variation__dbsnp;genome_resources__variation__cosmic;analysis;config__algorithm__tools_on;config__algorithm__variant_regions;align_bam;regions__callable;config__algorithm__callable_regions
  id: sentinel_outputs
  inputBinding:
    itemSeparator: ;;
    position: 1
    prefix: sentinel_outputs=
    separate: false
  type: string
- default: analysis:var,genome_build:var,align_bam:var,config__algorithm__callable_regions:var,metadata__batch:var,metadata__phenotype:var,regions__callable:var,config__algorithm__variantcaller:var,config__algorithm__coverage_interval:var,config__algorithm__variant_regions:var,config__algorithm__validate:var,config__algorithm__validate_regions:var,config__algorithm__tools_on:var,config__algorithm__tools_off:var,reference__fasta__base:var,reference__rtg:var,reference__genome_context:var,genome_resources__variation__cosmic:var,genome_resources__variation__dbsnp:var,description:var
  id: sentinel_inputs
  inputBinding:
    itemSeparator: ;;
    position: 2
    prefix: sentinel_inputs=
    separate: false
  type: string
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
- id: regions__callable
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
    type: array
- id: config__algorithm__validate_regions
  type:
    items:
    - File
    - 'null'
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
  type:
    items: File
    type: array
- id: reference__rtg
  type:
    items: File
    type: array
- id: reference__genome_context
  type:
    items:
      items: File
      type: array
    type: array
- id: genome_resources__variation__cosmic
  type:
    items: File
    type: array
- id: genome_resources__variation__dbsnp
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
        - name: reference__fasta__base
          type: File
        - name: reference__rtg
          type: File
        - name: config__algorithm__variantcaller
          type: string
        - name: config__algorithm__coverage_interval
          type: string
        - name: metadata__batch
          type: string
        - name: metadata__phenotype
          type: string
        - name: reference__genome_context
          type:
            items: File
            type: array
        - name: config__algorithm__validate_regions
          type:
          - File
          - 'null'
        - name: genome_build
          type: string
        - name: config__algorithm__tools_off
          type:
            items: string
            type: array
        - name: genome_resources__variation__dbsnp
          type: File
        - name: genome_resources__variation__cosmic
          type: File
        - name: analysis
          type: string
        - name: config__algorithm__tools_on
          type:
            items: string
            type: array
        - name: config__algorithm__variant_regions
          type: File
        - name: align_bam
          type: File
        - name: regions__callable
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
