#!/usr/bin/env bash
# Execution RESET: force formtips.settings:formtips_max_width to the default '500px' so verify
# FAILS until the agent sets it to '640px'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset formtips.settings formtips_max_width '500px' -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: formtips.settings formtips_max_width=500px"
