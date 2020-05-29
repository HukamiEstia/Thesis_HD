#! /bin/bash

docker run --gpus all -it \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device /dev/dri \
    -v $(pwd):/home/ \
    --privileged \
    opencv/sfm
