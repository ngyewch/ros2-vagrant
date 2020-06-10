#!/usr/bin/env bash

docker build -q -t ros2-vagrant/ros-dashing-base:latest docker/ros-dashing-base
docker build -q -t ros2-vagrant/dev_ws:latest docker/dev_ws
docker run -t -i --rm \
    --mount type=bind,source="$(pwd)"/dev_ws,target=/dev_ws \
    ros2-vagrant/dev_ws:latest \
    "$@"
