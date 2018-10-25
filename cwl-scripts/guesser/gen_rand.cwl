#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: Generate random number and write it to output file

requirements:
  InlineJavascriptRequirement: {}

baseCommand: echo

arguments: [$(Math.floor(Math.random() * (inputs.range + 1)))]

inputs:
  range: 
    type: int

outputs:
  secretFile:
    type: stdout

stdout: secret.txt