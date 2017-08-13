arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=batch-single
- sentinel_outputs=vrn_file_joint
- sentinel_inputs=jointvc_batch_rec:record,vrn_file_joint:var
baseCommand:
- bcbio_nextgen.py
- runfn
- postprocess_variants
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-vc
  dockerPull: quay.io/bcbio/bcbio-vc
- class: ResourceRequirement
  coresMin: 2
  outdirMin: 1024
  ramMin: 4096
- class: SoftwareRequirement
  packages:
  - package: snpeff
    specs:
    - https://anaconda.org/bioconda/snpeff
    version:
    - 4.3i
inputs:
- id: jointvc_batch_rec
  type:
    items:
      fields:
      - name: description
        type: string
      - name: validate__summary
        type:
        - File
        - 'null'
      - name: validate__tp
        type:
        - File
        - 'null'
      - name: validate__fp
        type:
        - File
        - 'null'
      - name: validate__fn
        type:
        - File
        - 'null'
      - name: vrn_file
        type: File
      - name: config__algorithm__validate
        type:
        - File
        - 'null'
        - string
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
      - name: genome_resources__aliases__snpeff
        type: string
      - name: align_bam
        type: File
      - name: regions__sample_callable
        type: File
      - name: config__algorithm__callable_regions
        type: File
      name: jointvc_batch_rec
      type: record
    type: array
- id: vrn_file_joint_toolinput
  secondaryFiles:
  - .tbi
  type: File
outputs:
- id: vrn_file_joint
  secondaryFiles:
  - .tbi
  type: File
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
