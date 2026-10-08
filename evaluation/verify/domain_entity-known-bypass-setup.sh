#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset -y domain_entity.settings bypass_access_conditions 1 >/dev/null 2>&1
echo "setup: domain_entity.settings bypass_access_conditions=true"
