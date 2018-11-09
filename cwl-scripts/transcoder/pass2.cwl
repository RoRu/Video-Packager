class: CommandLineTool
cwlVersion: v1.0
$namespaces:
  sbg: 'https://www.sevenbridges.com'
id: pass2
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
  - default: transcoded_video_4k.mp4
    id: output_file_name
    type: string
    inputBinding:
      position: 0
  - id: log_file
    type: File
outputs:
  - id: transcoded_video
    type: File
    outputBinding:
      glob: transcoded_video_4k.mp4
label: pass2
arguments:
  - '-y'
  - '-vsync'
  - '1'
  - '-pix_fmt'
  - yuv420p
  - '-c:v'
  - libx265
  - '-tune'
  - zerolatency
  - '-x265-params'
  - >-
    log-level=full:input-res=3840x2160:fps=24:level-idc=5.0:high-tier=1:sar=1:no-open-gop=1:keyint=$(inputs.keyint):min-keyint=$(inputs.keyint):scenecut=0:no-scenecut=1:colorprim=bt709:bitrate=20000:vbv-maxrate=30000:vbv-bufsize=40000:pass=2
  - '-an'
  - '-map'
  - '0:v:0'
  - '-an'
  - '-f'
  - mp4
requirements:
  - class: InlineJavascriptRequirement
