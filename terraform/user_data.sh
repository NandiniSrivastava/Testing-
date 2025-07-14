#!/bin/bash
yum update -y
yum install -y git curl

# Install Node.js 18
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs

# Create app directory
mkdir -p /opt/cloudscale-commerce
cd /opt/cloudscale-commerce

# Clone repo
git clone https://github.com/NandiniSrivastava/CloudScale-Commerce.git app
cd app

# Install dependencies
npm install

# Start the app in the background
nohup npm run dev > /var/log/cloudscale-app.log 2>&1 &
