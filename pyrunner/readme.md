Для работы уcтановить cwl:

    `pip install cwlref-runner`
    
или
 
    `pip install -r requirements.txt`


Принимает в качестве аргументов:
1. CWL-скрипт
2. аргументы для CWL-скрипта

Проверить: 

    `python hello_world.py 1st-tool.cwl echo-job.yml`

Так же можно запустить без аргументов, тогда вызовется функция use_import, которая использует библиотеку cwltool