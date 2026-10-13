FROM ubuntu:24.04

ARG THEROCK_DEVICE_EXTRAS=device-all
ARG THEROCK_INDEX_URL=https://nightly.repo.amd.com/rocm/whl-next/

RUN apt-get update &&\
    apt-get install -y --no-install-recommends ca-certificates ffmpeg libsm6 libxext6 libjpeg-dev python3-venv python3-full git &&\
    rm -rf /var/lib/apt/lists/*

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/Comfy-Org/ComfyUI.git /opt/comfyui

WORKDIR /opt/comfyui

RUN python3 -m venv venv &&\
    venv/bin/pip3 install --no-cache-dir --index-url "${THEROCK_INDEX_URL}" --pre "torch[${THEROCK_DEVICE_EXTRAS}]" "torchvision[${THEROCK_DEVICE_EXTRAS}]" torchaudio &&\
    venv/bin/pip3 install -r requirements.txt -r manager_requirements.txt

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--lowvram

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
