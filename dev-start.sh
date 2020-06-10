#!/usr/bin/env bash

cd vagrant

# start up vagrant box
vagrant up --provider=virtualbox

# SSH into vagrant box
exec vagrant ssh
