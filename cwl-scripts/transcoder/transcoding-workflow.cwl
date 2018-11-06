cwlVersion: v1.0
class: Workflow

inputs:
  input_file:
    type: File
  seconds:
    type: string

outputs:
  result:
    type: string
    outputSource: analyze/answer

steps:
  cut:
    run: cut-job.cwl
    in:
      input_file: input_file
      seconds: seconds
    out: [cut_video]

  get_props:
    run: get-properties.cwl
    in:
      input_file: cut/cut_video
    out: [json_file]

  analyze:
    run: verify.cwl
    in:
      json_file: get_props/json_file
    out: [answer]
