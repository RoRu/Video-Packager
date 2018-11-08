cwlVersion: v1.0
class: ExpressionTool

requirements:
  InlineJavascriptRequirement: {}

inputs:
  json_file:
    type: File
    inputBinding:
      loadContents: true

outputs:
  answer:
    type: string

expression: |
  ${
    var contents = inputs.json_file.contents;
    var props = JSON.parse(contents);
    var vstream = props.streams[0];
    if (vstream["codec_type"] === "video") {
        if (vstream["width"] >= 3840) {
            if (vstream["height"] <= 2160) {
                console.log(props.format["duration"]);
                console.log("I AM HERE")
                return ({"answer": "-y"});
            } else {
                console.log("I AM THERE")
                return ({"answer": "Invalid video"})
            }
        }
    }
  }
