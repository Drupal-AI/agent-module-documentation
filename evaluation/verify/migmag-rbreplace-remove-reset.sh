#!/usr/bin/env bash
# Introspection SETUP: enable migmag_rollbackable_replace so core 'config' destination uses RollbackableConfig.
set -uo pipefail
cd /var/www/html
drush en migmag_rollbackable_replace -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migmag_rollbackable_replace enabled (config -> RollbackableConfig)"
