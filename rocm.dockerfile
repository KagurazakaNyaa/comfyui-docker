FROM rocm/pytorch:rocm6.4.1_ubuntu24.04_py3.12_pytorch_release_2.6.0

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
