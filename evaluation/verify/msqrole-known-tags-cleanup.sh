#!/usr/bin/env bash
# Introspection CLEANUP: restore msqrole.settings tags_to_invalidate to its shipped default (''). Exit 0.
set -uo pipefail
cd /var/www/html
drush cset msqrole.settings tags_to_invalidate '' -y >/dev/null 2>&1
echo "cleanup: msqrole.settings tags_to_invalidate restored to ''"
