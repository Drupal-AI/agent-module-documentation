#!/usr/bin/env bash
# Introspection SETUP: ensure the user module is enabled and caches clear so the
# config_provider collector deterministically reports user's provided config. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: run config_provider.collector for the user module to see provided config"
