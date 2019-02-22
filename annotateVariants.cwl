class: CommandLineTool
cwlVersion: v1.0

requirements:
  - class: DockerRequirement
    dockerPull: "bjstubbs/waldronvariants"

inputs:
  script:
    type: File
    doc: annotateVariants.R
    inputBinding:
      position: 1

  vanilla:
    type: string
    inputBinding:
      position: 2
    
  symbol:
    type: string
    doc: Gene Symbol
    inputBinding:
      position: 3

  radius:
    type: int
    doc: radius for GRange
    inputBinding:
      position: 4

outputs:
  Rscript_out:
   type: File
   outputBinding:
      glob: result.csv


baseCommand: Rscript



