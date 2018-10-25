#!/usr/bin/env cwl-runner

# Шаг с примером использования ExpressionTool

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

# Expression задано как NodeJS код, возвращающий мапу определённую в outputs.
expression: |
  ${
    var secretNumber = parseInt(inputs.secretFile.contents.trim());
    return {"ans": secretNumber == inputs.guess ? "Win" : "Lose"};
  }
