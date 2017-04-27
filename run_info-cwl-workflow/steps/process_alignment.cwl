arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
baseCommand:
- bcbio_nextgen.py
- runfn
- process_alignment
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-align
  dockerPull: quay.io/bcbio/bcbio-align
- class: ResourceRequirement
  coresMin: 2
  outdirMin: 1028
  ramMin: 4096
  tmpdirMin: 4
- class: SoftwareRequirement
  packages:
  - package: bwa
    specs:
    - https://anaconda.org/bioconda/bwa
  - package: bwakit
    specs:
    - https://anaconda.org/bioconda/bwakit
  - package: grabix
    specs:
    - https://anaconda.org/bioconda/grabix
  - package: novoalign
    specs:
    - https://anaconda.org/bioconda/novoalign
  - package: snap-aligner
    specs:
    - https://anaconda.org/bioconda/snap-aligner
    version:
    - 1.0dev.97
  - package: sentieon
    specs:
    - https://anaconda.org/bioconda/sentieon
  - package: samtools
    specs:
    - https://anaconda.org/bioconda/samtools
  - package: sambamba
    specs:
    - https://anaconda.org/bioconda/sambamba
  - package: fgbio
    specs:
    - https://anaconda.org/bioconda/fgbio
  - package: umis
    specs:
    - https://anaconda.org/bioconda/umis
  - package: biobambam
    specs:
    - https://anaconda.org/bioconda/biobambam
  - package: seqtk
    specs:
    - https://anaconda.org/bioconda/seqtk
  - package: samblaster
    specs:
    - https://anaconda.org/bioconda/samblaster
inputs:
- default: single-parallel
  id: sentinel_parallel
  inputBinding:
    itemSeparator: ;;
    position: 0
    prefix: sentinel_parallel=
    separate: false
  type: string
- default: work_bam,align_bam,hla__fastq,work_bam_plus__disc,work_bam_plus__sr
  id: sentinel_outputs
  inputBinding:
    itemSeparator: ;;
    position: 1
    prefix: sentinel_outputs=
    separate: false
  type: string
- id: config__algorithm__quality_format
  inputBinding:
    itemSeparator: ;;
    position: 2
    prefix: config__algorithm__quality_format=
    separate: false
  type: string
- id: align_split
  inputBinding:
    itemSeparator: ;;
    position: 3
    prefix: align_split=
    separate: false
  type:
  - string
  - 'null'
- id: files
  inputBinding:
    itemSeparator: ;;
    position: 4
    prefix: files=
    separate: false
  type:
    items: File
    type: array
- id: description
  inputBinding:
    itemSeparator: ;;
    position: 5
    prefix: description=
    separate: false
  type: string
- id: config__algorithm__align_split_size
  inputBinding:
    itemSeparator: ;;
    position: 6
    prefix: config__algorithm__align_split_size=
    separate: false
  type: long
- id: reference__fasta__base
  inputBinding:
    itemSeparator: ;;
    position: 7
    prefix: reference__fasta__base=
    separate: false
  type: File
- id: rgnames__lb
  inputBinding:
    itemSeparator: ;;
    position: 8
    prefix: rgnames__lb=
    separate: false
  type: 'null'
- id: rgnames__rg
  inputBinding:
    itemSeparator: ;;
    position: 9
    prefix: rgnames__rg=
    separate: false
  type: string
- id: rgnames__lane
  inputBinding:
    itemSeparator: ;;
    position: 10
    prefix: rgnames__lane=
    separate: false
  type: string
- id: reference__bwa__indexes
  inputBinding:
    itemSeparator: ;;
    position: 11
    prefix: reference__bwa__indexes=
    separate: false
  type:
  - 'null'
  - File
- id: config__algorithm__aligner
  inputBinding:
    itemSeparator: ;;
    position: 12
    prefix: config__algorithm__aligner=
    separate: false
  type: string
- id: rgnames__pl
  inputBinding:
    itemSeparator: ;;
    position: 13
    prefix: rgnames__pl=
    separate: false
  type: string
- id: rgnames__pu
  inputBinding:
    itemSeparator: ;;
    position: 14
    prefix: rgnames__pu=
    separate: false
  type: string
- id: config__algorithm__mark_duplicates
  inputBinding:
    itemSeparator: ;;
    position: 15
    prefix: config__algorithm__mark_duplicates=
    separate: false
  type: string
- id: rgnames__sample
  inputBinding:
    itemSeparator: ;;
    position: 16
    prefix: rgnames__sample=
    separate: false
  type: string
- id: reference__snap__indexes
  inputBinding:
    itemSeparator: ;;
    position: 17
    prefix: reference__snap__indexes=
    separate: false
  type:
  - File
  - 'null'
outputs:
- id: work_bam
  type: File
- id: align_bam
  type: File
- id: hla__fastq
  type:
  - File
  - 'null'
  - items: File
    type: array
- id: work_bam_plus__disc
  secondaryFiles:
  - .bai
  type:
  - File
  - 'null'
- id: work_bam_plus__sr
  secondaryFiles:
  - .bai
  type:
  - File
  - 'null'
