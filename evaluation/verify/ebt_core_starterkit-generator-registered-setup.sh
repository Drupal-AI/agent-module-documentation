#!/usr/bin/env bash
# Introspection SETUP: the ebt:module generator is registered by the enabled ebt_core_starterkit
# module; rebuild caches so drush discovers it, then the agent lists drush generators. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: ebt_core_starterkit enabled; 'drush generate' should list ebt:module"
