#!/bin/bash

if [[ -d /opt/comfyui/venv ]]; then
    # shellcheck source=/dev/null
    source /opt/comfyui/venv/bin/activate
fi

if [[ ! -d /data/custom_nodes ]]; then
    cp -r custom_nodes /data/custom_nodes
fi
if [[ ! -d /data/input ]]; then
    cp -r input /data/input
fi
if [[ ! -d /data/output ]]; then
    cp -r output /data/output
fi
if [[ ! -d /data/models ]]; then
    cp -r models /data/models
fi
if [[ ! -d /data/user ]]; then
    mkdir -p /data/user
fi

if [[ ! -L custom_nodes ]]; then
    rm -rf custom_nodes
fi
if [[ ! -L input ]]; then
    rm -rf input
fi
if [[ ! -L output ]]; then
    rm -rf output
fi
if [[ ! -L models ]]; then
    rm -rf models
fi
if [[ ! -L user ]]; then
    rm -rf user
fi

ln -sf /data/custom_nodes -T custom_nodes
ln -sf /data/input -T input
ln -sf /data/output -T output
ln -sf /data/models -T models
ln -sf /data/user -T user

requires=(/data/custom_nodes/*/requirements.txt)
for deps in "${requires[@]}"; do
    pip3 install -r "$deps"
done

if [ $# -eq 0 ]; then
    python main.py --listen "0.0.0.0" --port 8188 "${EXTRA_ARGS}"
else
    exec "$@"
fi
