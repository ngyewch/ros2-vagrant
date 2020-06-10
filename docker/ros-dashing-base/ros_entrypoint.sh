#!/bin/bash

exit_func() {
  echo "SIGTERM detected"
  exit 1
}

trap exit_func SIGTERM SIGINT

set -e
# setup ros environment
source "/opt/ros/dashing/setup.bash"
exec "$@"
