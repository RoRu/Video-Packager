cwlVersion: v1.0
class: CommandLineTool
baseCommand: [ffmpeg, -y]

arguments: [-c, copy, $(inputs.output_filename)]

inputs:
  input_file:
    type: File
    inputBinding:
      prefix: -i
  seconds:
    type: string
    inputBinding:
      prefix: -t
  output_filename:
    type: string
    default: video_4k.mp4 # /home/karon/development/Video-Packager/videos/

outputs: []
#  cut_video:
#    type: File
#    outputBinding:
#     glob: "*home/karon/development/Video-Packager/videos/video_4k.mp4"
