FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

#### Setup locale

RUN apt-get update && apt-get install -y --no-install-recommends \
    locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

#### Add the ROS 2 apt repository

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg2 \
    lsb-release
RUN curl -skLO https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc
RUN apt-key add ros.asc
RUN echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list

#### Install ROS 2 packages

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-dashing-ros-base

COPY ros_entrypoint.sh .

ENTRYPOINT ["./ros_entrypoint.sh"]
