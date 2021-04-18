#!/bin/bash

PYENV_VERSION="3.9.2"

eval "$(pyenv init -)"
pyenv install ${PYENV_VERSION} --skip-existing
pyenv local ${PYENV_VERSION}
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r third_party/requirements.txt
python --version
