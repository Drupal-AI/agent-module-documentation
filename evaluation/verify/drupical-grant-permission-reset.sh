#!/usr/bin/env bash
# Execution RESET: revoke the "access events" permission from the anonymous and authenticated
# roles so the "grant access to the events feed" task starts from empty state.
set -uo pipefail
cd /var/www/html
drush role:perm:remove anonymous 'access events' >/dev/null 2>&1
drush role:perm:remove authenticated 'access events' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: 'access events' revoked from anonymous + authenticated"
