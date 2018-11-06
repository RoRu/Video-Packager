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
    var properties = JSON.parse(contents).streams[0];
    if (properties["codec_type"] === "video") {
        if (properties["width"] >= 3840) {
            if (properties["height"] <= 2160) {
                console.log("OK");
                return ({"answer": "OK"});
            }
        }
    }

  }
