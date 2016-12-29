#!/bin/bash

# ----------------------
# Nette delete cache
# Version: 1.0.0
# Author: Vaclav Jirovsky <vjirovsky@vjirovsky.cz>
# ----------------------
NETTE_TEMP_DIR="/home/site/wwwroot/temp/*"

##################################################################################################################################

find $NETTE_TEMP_DIR -not \( -name '.htaccess' -o -name 'web.config' \) -delete 1> /dev/null 

##################################################################################################################################
echo "TEMP folder of Nette application cleaned successfully."
