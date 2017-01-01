#!/bin/bash
echo "Installing auto-cache-cleaner of Nette app..."
mkdir -p /home/site/deployments/tools/PostDeploymentActions/
cp -f /usr/bin/delete-nette-cache.cmd /home/site/deployments/tools/PostDeploymentActions/delete-nette-cache.cmd
