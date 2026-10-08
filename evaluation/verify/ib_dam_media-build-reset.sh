#!/usr/bin/env bash
# Execution RESET/CLEANUP: delete ib_dam_media.settings so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush cdel ib_dam_media.settings -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: ib_dam_media.settings deleted"
