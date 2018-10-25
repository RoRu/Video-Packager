#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  guess: int
  secretFile: 
    type: File
    inputBinding:
      loadContents: true

outputs:
  ans: 
    type: string

expression: |
  ${
    var secretNumber = parseInt(inputs.secretFile.contents.trim());
    return {"ans": secretNumber == inputs.guess ? "Win" : "Lose"};
  }