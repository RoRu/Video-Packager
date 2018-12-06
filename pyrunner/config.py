#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import configparser
import copy
from collections import UserDict
from threading import Lock

# Change this to path to main config file
DEFAULT_CONFIG_FILE = './conf/pyrunner.conf-example'
DEFAULT_CONFIG = {
    'cwl': {
        'cwl_folder': 'cwl-scripts',
        'contract_file': 'contract.yml',
    },
}


def init_config(conf_file=DEFAULT_CONFIG_FILE):
    """
    init config from file
    :param conf_file: main config file
    """
    Config(conf_file)


class Config(UserDict):
    """
    Thread-safe object for configs
    user interface is dict-like

    Example usage:
        conf = Config()
        conf['section']['param']
        conf.section['param']
    """

    _lock = Lock()
    _is_loaded = False
    _config_file = None

    def __init__(self, conf_file):
        """
        Read config from config_file and merge it with default configs
        :param conf_file: path to config file
        """
        with self._lock:
            if not self._is_loaded:
                self.data = copy.deepcopy(DEFAULT_CONFIG)
                self.data.update(self.__load_config(conf_file))
                self._is_loaded = True

    def __getattr__(self, item):
        with self._lock:
            assert self._is_loaded, 'Load config first'
            return self[item]

    def __load_config(self, conf_file):
        self._config_file = conf_file
        config = configparser.ConfigParser()
        with open(conf_file) as conf_file_obj:
            config.read_file(conf_file_obj)
        return {sect: dict(config.items(sect)) for sect in config.sections()}
