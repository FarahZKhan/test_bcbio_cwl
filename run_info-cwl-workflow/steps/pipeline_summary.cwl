arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
baseCommand:
- bcbio_nextgen.py
- runfn
- pipeline_summary
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-qc
  dockerPull: quay.io/bcbio/bcbio-qc
- class: ResourceRequirement
  coresMin: 2
  outdirMin: 1024
  ramMin: 4096
- class: SoftwareRequirement
  packages:
  - package: bcftools
    specs:
    - https://anaconda.org/bioconda/bcftools
  - package: bedtools
    specs:
    - https://anaconda.org/bioconda/bedtools
  - package: fastqc
    specs:
    - https://anaconda.org/bioconda/fastqc
  - package: goleft
    specs:
    - https://anaconda.org/bioconda/goleft
  - package: picard
    specs:
    - https://anaconda.org/bioconda/picard
  - package: pythonpy
    specs:
    - https://anaconda.org/bioconda/pythonpy
  - package: qsignature
    specs:
    - https://anaconda.org/bioconda/qsignature
  - package: qualimap
    specs:
    - https://anaconda.org/bioconda/qualimap
  - package: sambamba
    specs:
    - https://anaconda.org/bioconda/sambamba
  - package: samtools
    specs:
    - https://anaconda.org/bioconda/samtools
inputs:
- default: multi-parallel
  id: sentinel_parallel
  inputBinding:
    itemSeparator: ;;
    position: 0
    prefix: sentinel_parallel=
    separate: false
  type: string
- default: summary__qc,summary__metrics
  id: sentinel_outputs
  inputBinding:
    itemSeparator: ;;
    position: 1
    prefix: sentinel_outputs=
    separate: false
  type: string
- id: description
  inputBinding:
    itemSeparator: ;;
    position: 2
    prefix: description=
    separate: false
  type:
    items: string
    type: array
- id: reference__fasta__base
  inputBinding:
    itemSeparator: ;;
    position: 3
    prefix: reference__fasta__base=
    separate: false
  type:
    items: File
    type: array
- id: config__algorithm__coverage_interval
  inputBinding:
    itemSeparator: ;;
    position: 4
    prefix: config__algorithm__coverage_interval=
    separate: false
  type:
    items: string
    type: array
- id: genome_build
  inputBinding:
    itemSeparator: ;;
    position: 5
    prefix: genome_build=
    separate: false
  type:
    items: string
    type: array
- id: config__algorithm__coverage
  inputBinding:
    itemSeparator: ;;
    position: 6
    prefix: config__algorithm__coverage=
    separate: false
  type:
    items:
    - File
    - 'null'
    type: array
- id: config__algorithm__tools_off
  inputBinding:
    itemSeparator: ;;
    position: 7
    prefix: config__algorithm__tools_off=
    separate: false
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__qc
  inputBinding:
    itemSeparator: ;;
    position: 8
    prefix: config__algorithm__qc=
    separate: false
  type:
    items:
      items: string
      type: array
    type: array
- id: analysis
  inputBinding:
    itemSeparator: ;;
    position: 9
    prefix: analysis=
    separate: false
  type:
    items: string
    type: array
- id: config__algorithm__tools_on
  inputBinding:
    itemSeparator: ;;
    position: 10
    prefix: config__algorithm__tools_on=
    separate: false
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__variant_regions
  inputBinding:
    itemSeparator: ;;
    position: 11
    prefix: config__algorithm__variant_regions=
    separate: false
  type:
    items: File
    type: array
- id: align_bam
  inputBinding:
    itemSeparator: ;;
    position: 12
    prefix: align_bam=
    separate: false
  type:
    items: File
    type: array
- id: config__algorithm__variant_regions_merged
  inputBinding:
    itemSeparator: ;;
    position: 13
    prefix: config__algorithm__variant_regions_merged=
    separate: false
  type:
    items:
    - File
    - 'null'
    type: array
- id: config__algorithm__coverage_merged
  inputBinding:
    itemSeparator: ;;
    position: 14
    prefix: config__algorithm__coverage_merged=
    separate: false
  type:
    items:
    - File
    - 'null'
    type: array
outputs:
- id: summary__qc
  type:
  - File
  - 'null'
- id: summary__metrics
  type: string
