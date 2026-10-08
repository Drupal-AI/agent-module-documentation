#!/usr/bin/env bash
# Execution RESET: force cache_ttl back to the default 86400 so the verify (which wants 3600)
# FAILS until the agent changes it.
set -uo pipefail
cd /var/www/html
drush cset views_json_source.settings cache_ttl 86400 -y >/dev/null 2>&1
echo "reset: views_json_source.settings cache_ttl = 86400"
