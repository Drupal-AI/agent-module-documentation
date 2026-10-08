#!/usr/bin/env bash
# Execution RESET: delete httpswww.settings so it does not exist (shipped baseline), which
# means verify MUST fail (enabled/prefix/scheme are all unset). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:delete httpswww.settings >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: httpswww.settings deleted"
