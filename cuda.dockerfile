FROM pytorch/pytorch:2.9.1-cuda13.0-cudnn9-runtime

RUN apt-get update &&\
    apt-get install -y ffmpeg libsm6 libxext6 git &&\
    apt-get clean

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui &&\
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /opt/comfyui/custom_nodes/ComfyUI-Manager

WORKDIR /opt/comfyui

RUN pip3 install -r requirements.txt

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--lowvram

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
