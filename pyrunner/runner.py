import argparse


def run_in_subprocess(script_path, args_path):
    from subprocess import call
    cwl_command = ['cwl-runner', script_path, args_path]
    call(cwl_command)


def run(script_path, args_path):
    from cwltool.factory import Factory
    import yaml
    workflow = Factory().make(script_path)
    with open(args_path, 'r') as f:
        print(workflow(**yaml.safe_load(f)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Python runner for CWL scripts.')
    parser.add_argument('-s', '--subprocess', action='store_true', help='run script in separate process')
    parser.add_argument('script_path', type=str, help='path to CWL scrpt')
    parser.add_argument('args_path', type=str, help='path to script arguments')
    args = parser.parse_args()

    if args.subprocess:
        run_in_subprocess(args.script_path, args.args_path)
    else:
        run(args.script_path, args.args_path)
