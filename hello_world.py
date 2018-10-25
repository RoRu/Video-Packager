"""
Для работы уcтановить cwl:
    pip install cwlref-runner


Принимает в качестве аргументов:
1. CWL-скрипт
2. аргументы (?) для CWL-скрипта
Проверить: python hello_world.py 1st-tool.cwl echo-job.yml

Так же можно запустить без аргументов, тогда вызовется функция use_import, которая использует библиотеку cwltool
"""

import sys


def use_subprocess(script_path, args_path):
    from subprocess import call
    cwl_command = ['cwl-runner', script_path, args_path]
    call(cwl_command)


def use_import():
    from cwltool.factory import Factory
    import yaml
    fac = Factory()

    echo = fac.make("1st-tool.cwl")
    with open('echo-job.yml', 'r') as f:
        print(echo(**yaml.safe_load(f)))


if __name__ == '__main__':
    if len(sys.argv) == 3:
        use_subprocess(sys.argv[1], sys.argv[2])
    else:
        use_import()
