#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default cache_ttl (86400).
set -uo pipefail
cd /var/www/html
drush cset views_json_source.settings cache_ttl 86400 -y >/dev/null 2>&1
echo "cleanup: views_json_source.settings cache_ttl restored to 86400"
