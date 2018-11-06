cwlVersion: v1.0
class: CommandLineTool
baseCommand: ffprobe

arguments: [-v, quiet, -print_format, json, -show_format, -show_streams]

inputs:
  input_file:
    type: File
    inputBinding:
      position: 1

outputs:
  json_file:
    type: stdout

stdout: properties.json
