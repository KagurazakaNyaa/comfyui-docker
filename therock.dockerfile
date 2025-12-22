FROM rocm/dev-ubuntu-24.04:7.1.1-complete

RUN apt-get update &&\
    apt-get install -y ffmpeg libsm6 libxext6 libjpeg-dev python3-dev python3-full git &&\
    apt-get clean

COPY VERSION /VERSION

RUN git clone --depth 1 --branch $(cat /VERSION) https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui

WORKDIR /opt/comfyui

RUN python3 -m venv venv &&\
    venv/bin/pip3 install --index-url https://rocm.nightlies.amd.com/v2/gfx110X-all/ --pre torch torchaudio torchvision &&\
    venv/bin/pip3 install -r requirements.txt -r manager_requirements.txt

COPY --chown=root:root --chmod=0755 docker-entrypoint.sh /docker-entrypoint.sh

ENV EXTRA_ARGS=--lowvram

VOLUME [ "/data" ]

EXPOSE 8188/tcp

ENTRYPOINT [ "/docker-entrypoint.sh" ]
