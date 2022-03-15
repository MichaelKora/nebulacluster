#!/bin/bash

#please check you systems architecture 
    # dpkg --print-architecture

#install nebula
wget https://github.com/slackhq/nebula/releases/download/v1.5.2/nebula-linux-amd64.tar.gz

# extract pkgs (create nebula  & nebula cert)
tar -xzf nebula-linux-amd64.tar.gz

#Creating certificate authority ( This will create files named ca.key and ca.cert in the current directory. )
./nebula-cert ca -name "Quantstack"

#Creating Keys and Certificates offline:
./nebula-cert sign -name "lighthouse" -ip "10.0.0.1/24"
./nebula-cert sign -name "server-1" -ip "10.0.0.11/24" -groups "servers"
./nebula-cert sign -name "server-2" -ip "10.0.0.12/24" -groups "servers"
	
#./nebula-cert sign -name "creator-laptop" -ip "10.0.0.13/24" -groups "laptops"

#config file for each node
curl -o config-1.yml https://raw.githubusercontent.com/slackhq/nebula/master/examples/config.yml
cp config-1.yml config-lighthouse.yaml
cp config-1.yml config.yaml
cp config-1.yml configlaptops.yaml
