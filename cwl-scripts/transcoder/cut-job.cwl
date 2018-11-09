class: CommandLineTool
cwlVersion: v1.0
baseCommand:
  - ffmpeg
inputs:
  - id: input_file
    type: File
    inputBinding:
      position: -1
      prefix: '-i'
  - default: '1'
    id: seconds
    type: string
    inputBinding:
      position: -1
      prefix: '-t'
outputs:
  - id: cut_video
    type: File
    outputBinding:
      glob: '*.mp4'
arguments:
  - '-preset'
  - ultrafast
  - '-y'
  - '-c'
  - copy
  - video_4k.mp4
