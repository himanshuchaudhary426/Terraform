#!/bin/bash

sudo apt update -y
sudo mkfs -t ext4 /dev/xvdh
sudo mkdir /new1
sudo mount /dev/xvdh /new1