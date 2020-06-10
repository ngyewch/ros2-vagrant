#!/bin/bash

exit_func() {
  echo "SIGTERM detected"
  exit 1
}

trap exit_func SIGTERM SIGINT

set -e
# setup ros environment
source "/opt/ros/dashing/setup.bash"
source "/dev_ws/install/setup.bash"

if [ -f /dev_ws/install_dependencies.sh ]; then
  sh /dev_ws/install_dependencies.sh > /dev/null
fi

exec "$@"
