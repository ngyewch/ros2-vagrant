#!/usr/bin/env python3

import os
import subprocess
import sys


def read_list(stdout):
    array = []
    while True:
        line = stdout.readline()
        if not line:
            break
        array.append(line.strip())
    return array


def get_package_paths(packages):
    proc = subprocess.Popen(f"colcon list -p --packages-up-to {' '.join(packages)}",
                            shell=True, stdout=subprocess.PIPE, encoding='UTF-8')
    return read_list(proc.stdout)


def get_rosdep_keys(paths):
    proc = subprocess.Popen(f"rosdep keys --from-paths {' '.join(paths)}",
                            shell=True, stdout=subprocess.PIPE, encoding='UTF-8')
    return read_list(proc.stdout)


def rosdep_resolve(keys):
    proc = subprocess.Popen(f"rosdep resolve {' '.join(keys)}",
                            shell=True, stdout=subprocess.PIPE, encoding='UTF-8')
    install_type = ''
    apt_packages = []
    while True:
        line = proc.stdout.readline()
        if not line:
            break
        line = line.strip()
        if line.startswith("#ROSDEP["):
            install_type = ''
        elif line.startswith("#"):
            install_type = line[1:]
        else:
            if install_type == 'apt':
                apt_packages.append(line.strip())
    return apt_packages


packages_to_build = sys.argv[1:]
package_paths = get_package_paths(packages_to_build)
package_keys = get_rosdep_keys(package_paths)
apt_pkgs = rosdep_resolve(package_keys)
apt_pkgs.sort()

file = open("apt_pkgs", "w")
file.write(' '.join(apt_pkgs))
file.close()

os.system(f"sudo apt-get install -y --no-install-recommends {' '.join(apt_pkgs)}")
os.system(f"colcon build --packages-up-to {' '.join(packages_to_build)}")
