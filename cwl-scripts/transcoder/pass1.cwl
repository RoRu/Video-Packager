class: CommandLineTool
cwlVersion: v1.0
id: pass1
baseCommand:
  - ffmpeg
inputs:
  - default: '24'
    id: fps
    type: string
    inputBinding:
      position: 1
      prefix: '-r'
  - id: input_file
    type: File
    inputBinding:
      position: 2
      prefix: '-i'
  - default: ultrafast
    id: preset
    type: string
    inputBinding:
      position: -1
      prefix: '-preset'
  - default: '48'
    id: keyint
    type: string
  - id: verification
    type: string
    inputBinding:
      position: -2
outputs:
  - id: log_file
    type: File
    outputBinding:
      glob: '*.log'
label: pass1
arguments:
  - '-vsync'
  - '1'
  - '-pix_fmt'
  - yuv420p
  - '-c:v'
  - libx265
  - '-tune'
  - zerolatency
  - '-x265-params'
  - 'input-res=3840x2160:fps=24:level-idc=5.0:high-tier=1:sar=1:no-open-gop=1:keyint=$(inputs.keyint):min-keyint=$(inputs.keyint):scenecut=0:no-scenecut=1:colorprim=bt709:bitrate=20000:vbv-maxrate=30000:vbv-bufsize=40000:pass=1'
  - '-an'
  - '-map'
  - '0:v:0'
  - '-an'
  - '-f'
  - mp4
  - /dev/null
requirements:
  - class: InlineJavascriptRequirement
