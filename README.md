# ComfyUI Docker

[![Check Upstream for Updates](https://github.com/KagurazakaNyaa/comfyui-docker/actions/workflows/update.yml/badge.svg)](https://github.com/KagurazakaNyaa/comfyui-docker/actions/workflows/update.yml)
[![Build Docker Image](https://github.com/KagurazakaNyaa/comfyui-docker/actions/workflows/docker.yml/badge.svg)](https://github.com/KagurazakaNyaa/comfyui-docker/actions/workflows/docker.yml)

![Docker Pulls](https://img.shields.io/docker/pulls/kagurazakanyaa/comfyui)
![Docker Stars](https://img.shields.io/docker/stars/kagurazakanyaa/comfyui)

![Image Size (CPU)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/cpu-latest?label=cpu-latest)
![Image Size (CUDA)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/cuda-latest?label=cuda-latest)
![Image Size (CUDA 13.0)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/cu130-latest?label=cu130-latest)
![Image Size (CUDA 12.8)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/cu128-latest?label=cu128-latest)
![Image Size (CUDA 12.6)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/cu126-latest?label=cu126-latest)
![Image Size (ROCm)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/rocm-latest?label=rocm-latest)
![Image Size (TheRock)](https://img.shields.io/docker/image-size/kagurazakanyaa/comfyui/therock-latest?label=therock-latest)

ComfyUI ROCm CUDA CPU docker image build

## Images

Images are published to Docker Hub and GitHub Container Registry:

- `kagurazakanyaa/comfyui`
- `ghcr.io/kagurazakanyaa/comfyui`

Available runtime tags:

| Runtime | Tag prefix | Base |
| --- | --- | --- |
| CPU | `cpu` | Python CPU image with PyTorch CPU wheels |
| CUDA 13.0 | `cu130` | `pytorch/pytorch:2.11.0-cuda13.0-cudnn9-runtime` |
| CUDA 12.8 | `cu128` | `pytorch/pytorch:2.11.0-cuda12.8-cudnn9-runtime` |
| CUDA 12.6 | `cu126` | `pytorch/pytorch:2.11.0-cuda12.6-cudnn9-runtime` |
| ROCm | `rocm` | `rocm/dev-ubuntu-24.04:7.2.3-complete` |
| TheRock | `therock` | ROCm/TheRock nightly wheels |

For tag pushes, each runtime gets its own tags, such as `cu130-latest`, `cu128-latest`, and `rocm-latest`.
The generic CUDA alias `cuda-latest` points to the CUDA 13.0 build (`cu130`).

## Docker Compose

Start one runtime at a time because all services expose ComfyUI on host port `8188`:

```bash
docker compose up cu130
```

Other available services are `cpu`, `rocm`, `therock`, `cu128`, and `cu126`.
