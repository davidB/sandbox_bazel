#!/bin/bash

python -m venv .venv
source .venv/bin/activate
python -m pip install -r third_party/requirements.txt --disable-pip-version-check
python --version
