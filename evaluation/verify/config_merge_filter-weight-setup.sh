#!/usr/bin/env bash
# Introspection SETUP: ensure config_merge_filter is enabled and caches clear so the config_merge
# config filter plugin is registered and its definition (weight 1000) is discoverable live via
# plugin.manager.config_filter. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx config_merge_filter || drush en config_merge_filter -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: config_merge_filter enabled; inspect plugin.manager.config_filter for the config_merge plugin"
