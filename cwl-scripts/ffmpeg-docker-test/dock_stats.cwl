#! /usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
# uncomment next line if using docker image without ffmpeg as entry point
# baseCommand: ffmpeg

doc: write video file (from URL) stats to output.txt

arguments: ["-i", $(inputs.input_file_link), "-hide_banner"]

hints:
  DockerRequirement:
    # self-created image
    # dockerImageId: ffmpeg4

    # public docker image (has an entrypoint)
    dockerPull: "jrottenberg/ffmpeg:4.0-ubuntu"

inputs: 
  input_file_link: string

outputs:
  example_out:
    type: stderr
stderr: output.txt

successCodes: [0, 1]
