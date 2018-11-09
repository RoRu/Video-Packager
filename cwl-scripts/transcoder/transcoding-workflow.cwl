class: Workflow
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
inputs:
  - id: input_file
    type: File
    'sbg:x': -106
    'sbg:y': 235.5
  - id: seconds
    type: string
    'sbg:x': -121
    'sbg:y': 24.5
outputs:
  - id: log_file
    outputSource:
      - pass2/transcoded_video
    type: File
    'sbg:x': 699.943603515625
    'sbg:y': 258.5
steps:
  - id: cut
    in:
      - id: input_file
        source: input_file
      - id: seconds
        source: seconds
    out:
      - id: cut_video
    run: cut-job.cwl
    'sbg:x': 116.28125
    'sbg:y': 126
  - id: get_properties
    in:
      - id: input_file
        source: cut/cut_video
    out:
      - id: json_file
    run: ./get-properties.cwl
    'sbg:x': 155.9952392578125
    'sbg:y': -79
  - id: verify
    in:
      - id: json_file
        source: get_properties/json_file
    out:
      - id: answer
    run: verify.cwl
    'sbg:x': 338.943603515625
    'sbg:y': -225.5
  - id: pass1
    in:
      - id: input_file
        source: cut/cut_video
      - id: verification
        source: verify/answer
    out:
      - id: log_file
    run: ./pass1.cwl
    label: pass1
    'sbg:x': 349.9952392578125
    'sbg:y': -75
  - id: pass2
    in:
      - id: input_file
        source: cut/cut_video
      - id: log_file
        source: pass1/log_file
    out:
      - id: transcoded_video
    run: ./pass2.cwl
    label: pass2
    'sbg:x': 439.9952392578125
    'sbg:y': 253
requirements: []
