#!/bin/bash

sudo amazon-linux-extras install nginx1.12 -y
sudo systemctl enable nginx.service
sudo systemctl start nginx.service
