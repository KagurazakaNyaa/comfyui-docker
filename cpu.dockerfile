FROM python:3.12

# Install dependencies
RUN apt-get update &&\
    apt-get install -y ffmpeg libsm6 libxext6 &&\
    apt-get clean &&\
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui &&\
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /opt/comfyui/custom_nodes/ComfyUI-Manager

WORKDIR /opt/comfyui

RUN pip3 install -r requirements.txt

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--cpu

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
