FROM nvidia/cuda:11.0-base-ubuntu20.04

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget git build-essential && rm -rf /var/lib/apt/lists/*

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda --version


RUN mkdir /workspace
WORKDIR /workspace

RUN git clone https://github.com/microsoft/CameraTraps.git CameraTraps
RUN cd CameraTraps && git checkout 33d876aba6596fd91c737309a484f47b14dfcbc1

RUN mkdir blobs
RUN wget -O blobs/4.1.0.pb https://github.com/microsoft/CameraTraps/releases/download/v4.1/md_v4.1.0.pb

WORKDIR /workspace/CameraTraps

RUN conda env create --file environment-detector.yml
RUN conda init bash
RUN echo "conda activate cameratraps-detector" >> ~/.bashrc

ENV PYTHONPATH '/workspace/CameraTraps'

ENTRYPOINT [ "conda", "run", "-n", "cameratraps-detector", "--no-capture-output"]
