#!/usr/bin/env bash
# Execution RESET: ensure role eswhub_editor exists WITHOUT the 'see content subscriptions'
# permission, so verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create eswhub_editor 'ESW Hub Editor' >/dev/null 2>&1
drush role:perm:remove eswhub_editor 'see content subscriptions' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role eswhub_editor present without 'see content subscriptions'"
