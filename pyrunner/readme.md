## Primitive Python runner for CWL scripts

#### Requirements:
*       Python 3.6+
*       pip install -r requirements.txt


#### Usage:
    runner.py [-h] [-s] [--cwl-args CWL_ARGS] script_path args_path


###### For example:
    python runner.py -s --cwl-args "--outdir ./.tmp" ../cwl-scripts/guesser/guesser.cwl ../cwl-scripts/guesser/guesser-job.yml


**Positional arguments**:

    script_path       path to CWL scrpt
    args_path         path to script arguments

**Optional arguments**:
    
    -h, --help        show this help message and exit
    -s, --subprocess  run script in separate process
    --cwl-args CWL_ARGS  command line arguments for cwl-runner (see "cwl-runner -h" for more info)
