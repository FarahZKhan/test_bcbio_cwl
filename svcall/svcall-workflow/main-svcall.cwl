class: Workflow
cwlVersion: v1.0
hints: []
inputs:
- id: config__algorithm__align_split_size
  type:
    items:
    - 'null'
    - string
    type: array
- id: reference__fasta__base
  secondaryFiles:
  - .fai
  - ^.dict
  type:
    items: File
    type: array
- id: config__algorithm__svcaller
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__coverage_interval
  type:
    items:
    - 'null'
    - string
    type: array
- id: genome_resources__rnaseq__gene_bed
  type:
    items: File
    type: array
- id: rgnames__lb
  type:
    items:
    - 'null'
    - string
    type: array
- id: rgnames__rg
  type:
    items: string
    type: array
- id: metadata__batch
  type:
    items: string
    type: array
- id: rgnames__lane
  type:
    items: string
    type: array
- id: config__algorithm__nomap_split_targets
  type:
    items: long
    type: array
- id: reference__bwa__indexes
  type:
    items: File
    type: array
- id: reference__twobit
  type:
    items: File
    type: array
- id: config__algorithm__nomap_split_size
  type:
    items: long
    type: array
- id: files
  secondaryFiles:
  - .bai
  type:
    items:
      items: File
      type: array
    type: array
- id: description
  type:
    items: string
    type: array
- id: config__algorithm__aligner
  type:
    items: string
    type: array
- id: rgnames__pl
  type:
    items: string
    type: array
- id: genome_build
  type:
    items: string
    type: array
- id: rgnames__pu
  type:
    items: string
    type: array
- id: config__algorithm__recalibrate
  type:
    items:
    - string
    - 'null'
    - boolean
    type: array
- id: metadata__phenotype
  type:
    items: string
    type: array
- id: config__algorithm__tools_off
  type:
    items:
      items:
      - 'null'
      - string
      type: array
    type: array
- id: genome_resources__variation__dbsnp
  secondaryFiles:
  - .tbi
  type:
    items: File
    type: array
- id: config__algorithm__mark_duplicates
  type:
    items:
    - string
    - 'null'
    - boolean
    type: array
- id: config__algorithm__qc
  type:
    items:
      items: string
      type: array
    type: array
- id: config__algorithm__sv_regions
  type:
    items: File
    type: array
- id: analysis
  type:
    items: string
    type: array
- id: rgnames__sample
  type:
    items: string
    type: array
- id: config__algorithm__tools_on
  type:
    items:
      items:
      - 'null'
      - string
      type: array
    type: array
- id: config__algorithm__variant_regions
  type:
    items:
    - 'null'
    - string
    type: array
- id: resources
  type:
    items: string
    type: array
outputs:
- id: align_bam
  outputSource: postprocess_alignment/align_bam
  type:
    items: File
    type: array
- id: regions__sample_callable
  outputSource: postprocess_alignment/regions__sample_callable
  type:
    items: File
    type: array
- id: summary__multiqc
  outputSource: multiqc_summary/summary__multiqc
  type:
    items:
    - File
    - 'null'
    type: array
- id: sv__calls
  outputSource: summarize_sv/sv__calls
  type:
    items:
      items:
      - File
      - 'null'
      type: array
    type: array
requirements:
- class: EnvVarRequirement
  envDef:
  - envName: MPLCONFIGDIR
    envValue: .
- class: ScatterFeatureRequirement
- class: SubworkflowFeatureRequirement
steps:
- id: alignment_to_rec
  in:
  - id: files
    source: files
  - id: config__algorithm__align_split_size
    source: config__algorithm__align_split_size
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: rgnames__pl
    source: rgnames__pl
  - id: rgnames__sample
    source: rgnames__sample
  - id: rgnames__pu
    source: rgnames__pu
  - id: rgnames__lane
    source: rgnames__lane
  - id: rgnames__rg
    source: rgnames__rg
  - id: rgnames__lb
    source: rgnames__lb
  - id: reference__bwa__indexes
    source: reference__bwa__indexes
  - id: config__algorithm__aligner
    source: config__algorithm__aligner
  - id: config__algorithm__mark_duplicates
    source: config__algorithm__mark_duplicates
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: alignment_rec
  run: steps/alignment_to_rec.cwl
- id: alignment
  in:
  - id: alignment_rec
    source: alignment_to_rec/alignment_rec
  out:
  - id: align_bam
  - id: work_bam_plus__disc
  - id: work_bam_plus__sr
  - id: hla__fastq
  run: wf-alignment.cwl
  scatter:
  - alignment_rec
  scatterMethod: dotproduct
- id: prep_samples_to_rec
  in:
  - id: config__algorithm__variant_regions
    source: config__algorithm__variant_regions
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: prep_samples_rec
  run: steps/prep_samples_to_rec.cwl
- id: prep_samples
  in:
  - id: prep_samples_rec
    source: prep_samples_to_rec/prep_samples_rec
  out:
  - id: config__algorithm__variant_regions
  - id: config__algorithm__variant_regions_merged
  - id: config__algorithm__variant_regions_orig
  - id: config__algorithm__coverage
  - id: config__algorithm__coverage_merged
  - id: config__algorithm__coverage_orig
  - id: config__algorithm__seq2c_bed_ready
  run: steps/prep_samples.cwl
  scatter:
  - prep_samples_rec
  scatterMethod: dotproduct
- id: postprocess_alignment_to_rec
  in:
  - id: align_bam
    source: alignment/align_bam
  - id: config__algorithm__coverage_interval
    source: config__algorithm__coverage_interval
  - id: config__algorithm__variant_regions
    source: prep_samples/config__algorithm__variant_regions
  - id: config__algorithm__variant_regions_merged
    source: prep_samples/config__algorithm__variant_regions_merged
  - id: config__algorithm__variant_regions_orig
    source: prep_samples/config__algorithm__variant_regions_orig
  - id: config__algorithm__coverage
    source: prep_samples/config__algorithm__coverage
  - id: config__algorithm__coverage_merged
    source: prep_samples/config__algorithm__coverage_merged
  - id: config__algorithm__coverage_orig
    source: prep_samples/config__algorithm__coverage_orig
  - id: config__algorithm__seq2c_bed_ready
    source: prep_samples/config__algorithm__seq2c_bed_ready
  - id: config__algorithm__recalibrate
    source: config__algorithm__recalibrate
  - id: config__algorithm__tools_on
    source: config__algorithm__tools_on
  - id: genome_resources__rnaseq__gene_bed
    source: genome_resources__rnaseq__gene_bed
  - id: genome_resources__variation__dbsnp
    source: genome_resources__variation__dbsnp
  - id: reference__twobit
    source: reference__twobit
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: postprocess_alignment_rec
  run: steps/postprocess_alignment_to_rec.cwl
- id: postprocess_alignment
  in:
  - id: postprocess_alignment_rec
    source: postprocess_alignment_to_rec/postprocess_alignment_rec
  out:
  - id: config__algorithm__coverage_interval
  - id: config__algorithm__variant_regions
  - id: config__algorithm__variant_regions_merged
  - id: config__algorithm__variant_regions_orig
  - id: config__algorithm__coverage
  - id: config__algorithm__coverage_merged
  - id: config__algorithm__coverage_orig
  - id: config__algorithm__seq2c_bed_ready
  - id: regions__callable
  - id: regions__sample_callable
  - id: regions__nblock
  - id: depth__variant_regions__regions
  - id: depth__variant_regions__dist
  - id: depth__sv_regions__regions
  - id: depth__sv_regions__dist
  - id: depth__coverage__regions
  - id: depth__coverage__dist
  - id: depth__coverage__thresholds
  - id: align_bam
  run: steps/postprocess_alignment.cwl
  scatter:
  - postprocess_alignment_rec
  scatterMethod: dotproduct
- id: combine_sample_regions
  in:
  - id: regions__callable
    source: postprocess_alignment/regions__callable
  - id: regions__nblock
    source: postprocess_alignment/regions__nblock
  - id: config__algorithm__nomap_split_size
    source: config__algorithm__nomap_split_size
  - id: config__algorithm__nomap_split_targets
    source: config__algorithm__nomap_split_targets
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: config__algorithm__callable_regions
  - id: config__algorithm__non_callable_regions
  - id: config__algorithm__callable_count
  run: steps/combine_sample_regions.cwl
- id: qc_to_rec
  in:
  - id: align_bam
    source: postprocess_alignment/align_bam
  - id: analysis
    source: analysis
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: genome_build
    source: genome_build
  - id: config__algorithm__coverage_interval
    source: postprocess_alignment/config__algorithm__coverage_interval
  - id: config__algorithm__tools_on
    source: config__algorithm__tools_on
  - id: config__algorithm__tools_off
    source: config__algorithm__tools_off
  - id: config__algorithm__qc
    source: config__algorithm__qc
  - id: depth__variant_regions__regions
    source: postprocess_alignment/depth__variant_regions__regions
  - id: depth__variant_regions__dist
    source: postprocess_alignment/depth__variant_regions__dist
  - id: depth__sv_regions__regions
    source: postprocess_alignment/depth__sv_regions__regions
  - id: depth__sv_regions__dist
    source: postprocess_alignment/depth__sv_regions__dist
  - id: depth__coverage__regions
    source: postprocess_alignment/depth__coverage__regions
  - id: depth__coverage__dist
    source: postprocess_alignment/depth__coverage__dist
  - id: depth__coverage__thresholds
    source: postprocess_alignment/depth__coverage__thresholds
  - id: config__algorithm__variant_regions
    source: postprocess_alignment/config__algorithm__variant_regions
  - id: config__algorithm__variant_regions_merged
    source: postprocess_alignment/config__algorithm__variant_regions_merged
  - id: config__algorithm__coverage
    source: postprocess_alignment/config__algorithm__coverage
  - id: config__algorithm__coverage_merged
    source: postprocess_alignment/config__algorithm__coverage_merged
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: qc_rec
  run: steps/qc_to_rec.cwl
- id: pipeline_summary
  in:
  - id: qc_rec
    source: qc_to_rec/qc_rec
  out:
  - id: qcout_rec
  run: steps/pipeline_summary.cwl
  scatter:
  - qc_rec
  scatterMethod: dotproduct
- id: multiqc_summary
  in:
  - id: qcout_rec
    source: pipeline_summary/qcout_rec
  out:
  - id: summary__multiqc
  run: steps/multiqc_summary.cwl
- id: calculate_sv_bins
  in:
  - id: align_bam
    source: postprocess_alignment/align_bam
  - id: reference__fasta__base
    source: reference__fasta__base
  - id: metadata__batch
    source: metadata__batch
  - id: metadata__phenotype
    source: metadata__phenotype
  - id: config__algorithm__callable_regions
    source: combine_sample_regions/config__algorithm__callable_regions
  - id: config__algorithm__coverage_interval
    source: postprocess_alignment/config__algorithm__coverage_interval
  - id: config__algorithm__sv_regions
    source: config__algorithm__sv_regions
  - id: config__algorithm__variant_regions
    source: postprocess_alignment/config__algorithm__variant_regions
  - id: config__algorithm__variant_regions_merged
    source: postprocess_alignment/config__algorithm__variant_regions_merged
  - id: config__algorithm__svcaller
    source: config__algorithm__svcaller
  - id: depth__variant_regions__regions
    source: postprocess_alignment/depth__variant_regions__regions
  - id: genome_resources__rnaseq__gene_bed
    source: genome_resources__rnaseq__gene_bed
  - id: description
    source: description
  - id: resources
    source: resources
  out:
  - id: sv_bin_rec
  run: steps/calculate_sv_bins.cwl
- id: calculate_sv_coverage
  in:
  - id: sv_bin_rec
    source: calculate_sv_bins/sv_bin_rec
  out:
  - id: sv_rawcoverage_rec
  run: steps/calculate_sv_coverage.cwl
  scatter:
  - sv_bin_rec
  scatterMethod: dotproduct
- id: normalize_sv_coverage
  in:
  - id: sv_rawcoverage_rec
    source: calculate_sv_coverage/sv_rawcoverage_rec
  out:
  - id: sv_coverage_rec
  run: steps/normalize_sv_coverage.cwl
- id: batch_for_sv
  in:
  - id: analysis
    source: analysis
  - id: genome_build
    source: genome_build
  - id: work_bam_plus__disc
    source: alignment/work_bam_plus__disc
  - id: work_bam_plus__sr
    source: alignment/work_bam_plus__sr
  - id: config__algorithm__tools_on
    source: config__algorithm__tools_on
  - id: config__algorithm__tools_off
    source: config__algorithm__tools_off
  - id: sv_coverage_rec
    source: normalize_sv_coverage/sv_coverage_rec
  out:
  - id: sv_batch_rec
  run: steps/batch_for_sv.cwl
- id: svcall
  in:
  - id: sv_batch_rec
    source: batch_for_sv/sv_batch_rec
  out:
  - id: sv_rec
  run: wf-svcall.cwl
  scatter:
  - sv_batch_rec
  scatterMethod: dotproduct
- id: summarize_sv
  in:
  - id: sv_rec
    source: svcall/sv_rec
  out:
  - id: sv__calls
  run: steps/summarize_sv.cwl
