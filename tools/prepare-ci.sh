#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS OS detected. Install dependencies..."
    brew install gsed || true
    brew install gawk || true
    brew install gperf || true
    brew install ninja || true
    brew install ccache || true
    python3 -m pip install uv
    uv venv
    uv pip install future pyelftools
else
    echo "Linux detected. Install dependencies..."
    sudo apt update && sudo apt install -y gperf cmake ninja-build ccache
    pip3 install wheel future pyelftools
fi
