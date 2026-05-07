FROM pytorch/pytorch:2.11.0-cuda12.6-cudnn9-runtime

RUN apt-get update &&\
    apt-get install -y ffmpeg libsm6 libxext6 python3-venv git &&\
    apt-get clean

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui

WORKDIR /opt/comfyui

RUN python3 -m venv --system-site-packages venv &&\
    venv/bin/pip3 install -r requirements.txt -r manager_requirements.txt

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--lowvram

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
