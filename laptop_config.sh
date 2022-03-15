#!/bin/bash

sudo mkdir /etc/nebula

sudo cp configlaptops.yaml /etc/nebula/config.yaml
sudo cp ca.crt /etc/nebula/ca.crt
sudo mv creator-laptop.crt /etc/nebula/host.crt
sudo mv creator-laptop.key /etc/nebula/host.key

#get the node running
sudo ./nebula -config /etc/nebula/config.yaml