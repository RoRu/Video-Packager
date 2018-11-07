#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
# uncomment next line if using docker image without ffmpeg as entry point
# baseCommand: ffmpeg

doc: trim mp4 file (from URL) and save it as <out_file_name>.mp4

arguments: [
  "-i", $(inputs.input_file_link), 
  "-t", $(inputs.trim_seconds), 
  "$(inputs.out_file_name).mp4"
]

hints:
  DockerRequirement:
    # self-created docker image
    # dockerImageId: ffmpeg4

    # public docker image
    dockerPull: "jrottenberg/ffmpeg:4.0-ubuntu"

inputs:
  input_file_link: string
  trim_seconds: int
  out_file_name: string

outputs:
  out_video:
    type: File
    outputBinding:
      glob: "$(inputs.out_file_name).mp4"
