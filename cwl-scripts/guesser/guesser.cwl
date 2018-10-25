#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

inputs:
  range: int
  guess: int

outputs:
  result:
    type: string
    outputSource: compare/ans
  file:
    type: File
    outputBinding:
      glob: secret.txt
    outputSource: gen_random/secretFile

steps:
  gen_random:
    run: gen_rand.cwl
    in:
      range: range
    out: [secretFile]
  compare:
    run: compare_step.cwl
    in:
      guess: guess
      secretFile: gen_random/secretFile
    out: [ans]