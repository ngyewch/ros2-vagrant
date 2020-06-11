FROM ros2-vagrant/ros-dashing-base:latest

COPY apt_pkgs .
RUN apt-get update && \
    apt-get install -y --no-install-recommends $(cat apt_pkgs)

COPY ros_entrypoint.sh .

ENTRYPOINT ["./ros_entrypoint.sh"]
