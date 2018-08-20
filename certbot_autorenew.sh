#!/bin/bash
#
# cron.daily/certbot -- daily check that certificates are up to date. 
#
# This program is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, 
# either version 3 of the License, or (at your option) any 
# later version.

set -eu

if [ -x /opt/letsencrypt/certbot-auto ]; then
    /opt/letsencrypt/certbot-auto renew --quiet
else
    exit 1
fi
