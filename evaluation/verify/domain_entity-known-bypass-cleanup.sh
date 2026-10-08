#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush cset -y domain_entity.settings bypass_access_conditions 0 >/dev/null 2>&1
echo "cleanup: domain_entity.settings bypass_access_conditions restored to false"
