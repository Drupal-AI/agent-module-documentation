#!/usr/bin/env bash
# Introspection SETUP: ensure config_distro_filter is enabled and caches clear so its extension
# info (lifecycle: deprecated) is readable live via extension.list.module. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: read config_distro_filter extension info (lifecycle) on the live site"
