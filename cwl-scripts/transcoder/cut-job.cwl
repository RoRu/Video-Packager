cwlVersion: v1.0
class: CommandLineTool
baseCommand: ffmpeg

arguments: [-y, -c, copy, video_4k.mp4]

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
  seconds:
    type: string
    inputBinding:
      prefix: -t

outputs:
  cut_video:
    type: File
    outputBinding:
      glob: video_4k.mp4
