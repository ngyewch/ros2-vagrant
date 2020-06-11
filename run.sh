#!/usr/bin/env bash

rm -rf build
mkdir -p build/docker
cp -p -r docker/dev_ws/ build/docker/
cp -p dev_ws/apt_pkgs build/docker/dev_ws/

docker build -q -t ros2-vagrant/ros-dashing-base:latest docker/ros-dashing-base
docker build -t ros2-vagrant/dev_ws:latest build/docker/dev_ws
docker run -t -i --rm \
    --mount type=bind,source="$(pwd)"/dev_ws,target=/dev_ws \
    ros2-vagrant/dev_ws:latest \
    "$@"
