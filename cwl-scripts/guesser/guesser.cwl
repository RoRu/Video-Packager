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

# Если мы хотим, чтобы после выполнения остался файл с загаданным числом,
#     то надо указать его в outputs. Иначе после выполнения промежуточные
#     файлы удаляются.
  file:
    type: File
    outputBinding:
      glob: secret.txt
    outputSource: gen_random/secretFile

steps:
# В этом шаге генерируется рандомное число и записывается в файл.
  gen_random:
    run: gen_rand.cwl
    in:
      range: range
    out: [secretFile]

# Сравнивает guess с числом, записанном в файле из предыдущего шага.
  compare:
    run: compare_step.cwl
    in:
      guess: guess
      secretFile: gen_random/secretFile
    out: [ans]
