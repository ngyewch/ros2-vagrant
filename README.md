# ros2-vagrant

## Pre-requisites

* Vagrant 2.x
    * https://www.vagrantup.com/
* VirtualBox
    * https://www.virtualbox.org/
* Docker
    * https://www.docker.com/

## Development workflow

### Startup the Vagrant box

From the host machine:

```
./dev-start.sh
```

This command builds the Vagrant box (if it has not been built previously) and starts it.

#### Example

From the Vagrant box:
```
#### Create source directory and check out source repositories

mkdir -p src && \
    cd src && \
        git clone https://github.com/ros2/examples.git && \
        cd examples && \
            git checkout ${ROS_DISTRO} && \
            cd .. && \
        cd ..

#### Resolve and install dependencies 

rosdep install -i --from-path src --rosdistro ${ROS_DISTRO} -y

#### Build the workspace

colcon build
```

```
#### Create script to install dependencies 

rosdep install --simulate --reinstall --from-path src > install_dependencies.sh
```

This creates artifacts in the `dev_ws/install/` directory. 

### Stop the Vagrant box

To release resources taken up by the virtualized development environment.

From the host machine:

```
./dev-stop.sh
```

### Destroy the Vagrant box

To reset the development environment.

From the host machine:

```
./dev-destroy.sh
```

## Running built artifacts

### Examples

Assumes the example described earlier has been built. 

NOTE: The development environment need not be running.

In one terminal on the host machine:
```
./run.sh ros2 run examples_rclcpp_minimal_publisher publisher_member_function
```

In another terminal on the host machine:
```
./run.sh ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function
```
