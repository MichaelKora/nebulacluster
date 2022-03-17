#!/bin/bash

ansible-inventory -i ./inventory --list

ansible-playbook -i ./inventory ./playbook.yml --private-key=../ida_rsa

