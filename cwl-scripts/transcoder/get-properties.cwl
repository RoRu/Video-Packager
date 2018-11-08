class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - ffprobe
inputs:
  - id: input_file
    type: File
    inputBinding:
      position: 1
outputs:
  - id: json_file
    type: File
    outputBinding:
      glob: '*.json'
arguments:
  - '-v'
  - quiet
  - '-print_format'
  - json
  - '-show_format'
  - '-show_streams'
stdout: properties.json
