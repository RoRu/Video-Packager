import argparse
import sys
from subprocess import call

import yaml
from cwltool import factory, context


def run_in_subprocess(cwl_args, script_path, args_path):
    args = cwl_args if cwl_args is not None else []
    cwl_command = ['cwl-runner', *args, script_path, args_path]
    call(cwl_command)


def run(cwl_args, script_path, args_path):
    def runtime_context_eval(cwl_args):
        if not cwl_args:
            return {}
        result = {}
        last_index = len(cwl_args) - 1
        for i in range(last_index):
            arg, value = cwl_args[i], cwl_args[i + 1]
            if arg.startswith('--'):
                arg = arg[2:].replace('-', '_')
                if not value.startswith('--'):
                    result[arg] = value
                else:
                    result[arg] = True
        if cwl_args[last_index].startswith('--'):
            result[cwl_args[last_index][2:].replace('-', '_')] = True
        return result

    runtime_context = context.RuntimeContext(runtime_context_eval(cwl_args))
    workflow = factory.Factory(
        runtime_context=runtime_context,
    ).make(script_path)
    with open(args_path, 'r') as f:
        print(workflow(**yaml.safe_load(f)))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Python runner for CWL scripts.')
    parser.add_argument('-s', '--subprocess', action='store_true', help='run script in separate process')
    parser.add_argument(
        '--cwl-args',
        type=str,
        help='command line arguments for cwl-runner (see "cwl-runner -h" for more info)',
    )
    parser.add_argument('script_path', type=str, help='path to CWL scrpt')
    parser.add_argument('args_path', type=str, help='path to script arguments')

    # a little hack to make argparse recognise specific case: --cwl-args "--<cwl-runner argument>=<value>"
    for i in range(len(sys.argv)):
        if sys.argv[i] == '--cwl-args':
            sys.argv[i:i + 2] = ['='.join(sys.argv[i:i + 2])]
            break

    args = parser.parse_args()
    if args.cwl_args is not None:
        cwl_args = args.cwl_args.replace('=', ' ').split(' ')
    else:
        cwl_args = []

    if args.subprocess:
        run_in_subprocess(cwl_args, args.script_path, args.args_path)
    else:
        run(cwl_args, args.script_path, args.args_path)
