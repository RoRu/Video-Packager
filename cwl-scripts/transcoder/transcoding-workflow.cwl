class: Workflow
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: input_file
    type: File
    'sbg:x': -5
    'sbg:y': 182
  - id: seconds
    type: string
    'sbg:x': -10
    'sbg:y': 55
outputs:
  - id: log_file
    outputSource:
      - pass1/log_file
    type: File
    'sbg:x': 780.65625
    'sbg:y': 104.5
steps:
  - id: verify
    in:
      - id: json_file
        source: get_properties/json_file
    out:
      - id: answer
    run: verify.cwl
    'sbg:x': 556.1514892578125
    'sbg:y': -78.5
  - id: cut
    in:
      - id: input_file
        source: input_file
      - id: seconds
        source: seconds
    out:
      - id: cut_video
    run: cut-job.cwl
    'sbg:x': 272.28125
    'sbg:y': 137.5
  - id: get_properties
    in:
      - id: input_file
        source: cut/cut_video
    out:
      - id: json_file
    run: ./get-properties.cwl
    'sbg:x': 348.9952697753906
    'sbg:y': -71.5
  - id: pass1
    in:
      - id: input_file
        source: cut/cut_video
    out:
      - id: log_file
    run: ./pass1.cwl
    label: pass1
    'sbg:x': 586
    'sbg:y': 143
requirements: []
