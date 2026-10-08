#!/usr/bin/env bash
# Execution CLEANUP: restore msqrole.settings tags_to_invalidate to shipped default (''). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset msqrole.settings tags_to_invalidate '' -y >/dev/null 2>&1
echo "cleanup: msqrole.settings tags_to_invalidate restored to ''"
