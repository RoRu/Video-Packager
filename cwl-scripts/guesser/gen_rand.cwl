#!/usr/bin/env cwl-runner

# Шаг с примером использования CommandLineTool

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

# stdout утилиты перенаправляем в заданный файл
outputs:
  secretFile:
    type: stdout

stdout: secret.txt
