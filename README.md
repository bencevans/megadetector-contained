# MegaDetector Contained

> Docker image for running the [MegaDetector](https://github.com/microsoft/CameraTraps/blob/master/megadetector.md) camera-trap object detection model.

## Requirements

- CUDA 11.0 (adjustable by changing base image)
- docker
- nvidia-docker (`sudo apt install nvidia-docker2` on Ubuntu 20.04.1)

## Building

```bash
docker build -t bencevans/megadetector .
```

## Batch Detection

Change `/path/to/dataset/on/host` to the location of your dataset on the host machine.

```bash
nvidia-docker run \
    --rm \
    -it \
    -v "/path/to/dataset/on/host":/dataset \
    bencevans/megadetector \
    python detection/run_tf_detector_batch.py \
        --recursive \
        --output_relative_filenames \
        --checkpoint_frequency 10000 \
        /workspace/blobs/4.1.0.pb \
        /dataset/ \
        /dataset/md.4.1.0.json
```
