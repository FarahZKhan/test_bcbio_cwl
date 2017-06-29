arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=multi-combined
- sentinel_outputs=alignment_rec:description;config__algorithm__align_split_size;reference__fasta__base;rgnames__lb;rgnames__rg;rgnames__lane;reference__bwa__indexes;files;config__algorithm__aligner;rgnames__pl;rgnames__pu;config__algorithm__mark_duplicates;rgnames__sample;reference__snap__indexes
- sentinel_inputs=files:var,config__algorithm__align_split_size:var,reference__fasta__base:var,rgnames__pl:var,rgnames__sample:var,rgnames__pu:var,rgnames__lane:var,rgnames__rg:var,rgnames__lb:var,reference__bwa__indexes:var,reference__snap__indexes:var,config__algorithm__aligner:var,config__algorithm__mark_duplicates:var,description:var
baseCommand:
- bcbio_nextgen.py
- runfn
- alignment_to_rec
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
- id: files
  secondaryFiles:
  - .bai
  type:
    items:
      items: File
      type: array
    type: array
- id: config__algorithm__align_split_size
  type:
    items:
    - 'null'
    - long
    type: array
- id: reference__fasta__base
  secondaryFiles:
  - .fai
  - ^.dict
  type:
    items: File
    type: array
- id: rgnames__pl
  type:
    items: string
    type: array
- id: rgnames__sample
  type:
    items: string
    type: array
- id: rgnames__pu
  type:
    items: string
    type: array
- id: rgnames__lane
  type:
    items: string
    type: array
- id: rgnames__rg
  type:
    items: string
    type: array
- id: rgnames__lb
  type:
    items: 'null'
    type: array
- id: reference__bwa__indexes
  secondaryFiles:
  - ^.bwt
  - ^.pac
  - ^.sa
  type:
    items:
    - 'null'
    - File
    type: array
- id: reference__snap__indexes
  secondaryFiles:
  - Index
  - IndexHash
  type:
    items:
    - File
    - 'null'
    type: array
- id: config__algorithm__aligner
  type:
    items: string
    type: array
- id: config__algorithm__mark_duplicates
  type:
    items: string
    type: array
- id: description
  type:
    items: string
    type: array
outputs:
- id: alignment_rec
  type:
    items:
      fields:
      - name: description
        type: string
      - name: config__algorithm__align_split_size
        type:
        - 'null'
        - long
      - name: reference__fasta__base
        type: File
      - name: rgnames__lb
        type: 'null'
      - name: rgnames__rg
        type: string
      - name: rgnames__lane
        type: string
      - name: reference__bwa__indexes
        type:
        - 'null'
        - File
      - name: files
        type:
          items: File
          type: array
      - name: config__algorithm__aligner
        type: string
      - name: rgnames__pl
        type: string
      - name: rgnames__pu
        type: string
      - name: config__algorithm__mark_duplicates
        type: string
      - name: rgnames__sample
        type: string
      - name: reference__snap__indexes
        type:
        - File
        - 'null'
      name: alignment_rec
      type: record
    type: array
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
