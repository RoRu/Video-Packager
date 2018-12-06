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


def init_config(conf_path=DEFAULT_CONFIG_FILE):
    """
    init config from file
    :param conf_path: main config file
    """
    Config(conf_path)


class Config(UserDict):
    """
    Thread-safe object for configs with dict-like user interface
    call init_config() for default config initialization

    Example usage:
        conf = Config()
        conf['section']['param']
        conf.section['param']
    """

    _lock = Lock()
    _is_loaded = False
    _conf_path = None

    def __init__(self, conf_path=None):
        """
        Read config from config_file and merge it with default configs
        :param conf_path: path to config file
        """
        with Config._lock:
            if not Config._is_loaded:
                Config.data = copy.deepcopy(DEFAULT_CONFIG)
                main_conf = self._load_config(conf_path)
                for section, value in main_conf.items():
                    Config.data[section].update(value)
                Config._is_loaded = True

    def __getattr__(self, item):
        with Config._lock:
            assert Config._is_loaded, 'Load config first'
            return Config.data[item]

    @staticmethod
    def _load_config(conf_path):
        if not conf_path:
            return {}

        Config._conf_path = conf_path
        config = configparser.ConfigParser()
        with open(conf_path) as conf_file_obj:
            config.read_file(conf_file_obj)
        return {sect: dict(config.items(sect)) for sect in config.sections()}
