arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=single-split
- sentinel_outputs=process_alignment_rec:files;config__algorithm__quality_format;align_split
- sentinel_inputs=alignment_rec:record
baseCommand:
- bcbio_nextgen.py
- runfn
- prep_align_inputs
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-align
  dockerPull: quay.io/bcbio/bcbio-align
- class: ResourceRequirement
  coresMin: 1
  outdirMin: 1028
  ramMin: 2048
  tmpdirMin: 4
- class: SoftwareRequirement
  packages:
  - package: grabix
    specs:
    - https://anaconda.org/bioconda/grabix
  - package: htslib
    specs:
    - https://anaconda.org/bioconda/htslib
  - package: biobambam
    specs:
    - https://anaconda.org/bioconda/biobambam
inputs:
- id: alignment_rec
  type:
    fields:
    - name: description
      type: string
    - name: config__algorithm__align_split_size
      type: long
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
outputs:
- id: process_alignment_rec
  type:
    items:
      fields:
      - name: files
        type:
          items: File
          type: array
      - name: config__algorithm__quality_format
        type: string
      - name: align_split
        type:
        - string
        - 'null'
      name: process_alignment_rec
      type: record
    type: array
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
