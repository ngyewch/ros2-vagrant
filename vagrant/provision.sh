#!/usr/bin/env bash

#### Setup locale

locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

#### Setup ROS 2 apt repositories

apt-get update && \
apt-get install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list

#### Install ROS 2 packages

apt-get update && \
apt-get install -y --no-install-recommends \
    ros-dashing-ros-base

#### Install development tools and ROS tools

apt-get update && \
apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    python3-colcon-common-extensions \
    python3-pip \
    python-rosdep \
    python3-vcstool \
    wget
# install some pip packages needed for testing
python3 -m pip install -U \
    argcomplete \
    flake8 \
    flake8-blind-except \
    flake8-builtins \
    flake8-class-newline \
    flake8-comprehensions \
    flake8-deprecated \
    flake8-docstrings \
    flake8-import-order \
    flake8-quotes \
    pytest-repeat \
    pytest-rerunfailures \
    pytest \
    pytest-cov \
    pytest-runner \
    setuptools
# install Fast-RTPS dependencies
apt-get install -y --no-install-recommends \
    libasio-dev \
    libtinyxml2-dev
# install Cyclone DDS dependencies
apt-get install -y --no-install-recommends \
    libcunit1-dev

#### Initialize rosdep

rosdep init
su - vagrant -c "rosdep update"

####

su - vagrant -c "echo 'source /opt/ros/dashing/setup.bash' > ~/.bash_login"
