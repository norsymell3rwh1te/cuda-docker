
SHELL:=/bin/bash

IMAGE_VERSION?=11.2.1-runtime-ubuntu20.04-gpu-burn
IMAGE_TAG?=traptic/cuda:${IMAGE_VERSION}

shell: image
	docker run --runtime=nvidia --rm -it ${IMAGE_TAG} bash

burn: image
	docker run --name gpuburn --runtime=nvidia --rm ${IMAGE_TAG}

image:
	docker build --tag ${IMAGE_TAG} .
