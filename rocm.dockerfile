FROM rocm/dev-ubuntu-24.04:6.3.4-complete

RUN apt-get update &&\
    apt-get install -y ffmpeg libsm6 libxext6 libjpeg-dev python3-dev python3-pip &&\
    apt-get clean &&\
    pip3 install wheel setuptools

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui &&\
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git /opt/comfyui/custom_nodes/ComfyUI-Manager

WORKDIR /opt/comfyui

RUN pip3 install -r requirements.txt &&\
    pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm6.3/

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--lowvram

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
