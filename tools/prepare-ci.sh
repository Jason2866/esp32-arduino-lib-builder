#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macOS OS detected. Install dependencies..."
    brew install gsed || true
    brew install gawk || true
    brew install gperf || true
    brew install ninja || true
    brew install ccache || true
    brew install coreutils || true
    brew install xz || true
    brew install uv || true
    uv venv
    uv pip install future pyelftools
else
    echo "Linux detected. Install dependencies..."
    sudo apt update && sudo apt install -y gperf cmake ninja-build ccache xz-utils
    curl -LsSf https://astral.sh/uv/install.sh | sh
    uv venv
    uv pip install future pyelftools
fi
