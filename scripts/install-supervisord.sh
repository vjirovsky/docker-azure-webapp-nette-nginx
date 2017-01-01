#!/bin/bash
echo "Starting supervisord..."
/usr/bin/supervisord -c "/etc/supervisord.conf" &
