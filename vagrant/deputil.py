#!/usr/bin/env python3

import fileinput

install_type = ''
apt_packages = []

for line in fileinput.input():
    line = line.strip()
    if line.startswith("#ROSDEP["):
        install_type = ''
    elif line.startswith("#"):
        install_type = line[1:]
    else:
        if install_type == 'apt':
            apt_packages.append(line.strip())

apt_packages.sort()

print(' '.join(apt_packages))
