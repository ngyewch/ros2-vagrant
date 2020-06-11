FROM ros2-vagrant/ros-dashing-base:latest

RUN apt-get install -y --no-install-recommends \
    sudo

COPY install_dependencies.sh .
RUN sh ./install_dependencies.sh

COPY ros_entrypoint.sh .

ENTRYPOINT ["./ros_entrypoint.sh"]
