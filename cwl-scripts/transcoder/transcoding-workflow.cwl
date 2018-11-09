class: Workflow
cwlVersion: v1.0
inputs:
  - id: input_file
    type: File
  - id: seconds
    type: string
outputs:
  - id: log_file
    outputSource:
      - pass2/transcoded_video
    type: File
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
  - id: get_properties
    in:
      - id: input_file
        source: cut/cut_video
    out:
      - id: json_file
    run: ./get-properties.cwl
  - id: verify
    in:
      - id: json_file
        source: get_properties/json_file
    out:
      - id: answer
    run: verify.cwl
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
requirements: []
