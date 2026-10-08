#!/usr/bin/env bash
# Execution RESET: clear msqrole.settings tags_to_invalidate to '' so verify FAILS until the
# agent adds the required cache tag. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset msqrole.settings tags_to_invalidate '' -y >/dev/null 2>&1
echo "reset: msqrole.settings tags_to_invalidate=''"
